import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The cart itself and every move it makes. Who owns one — a customer as `contact_id`, or a guest as the storefront's own `session_key`, never neither — how it is opened, read, renamed and thrown away, which of an owner's carts is THE current one, and the lifecycle a cart travels: abandoned and taken back, handed to order management, folded into another cart, or claimed for a contact on login. The scheduled sweep that abandons and deletes on a clock is the same lifecycle without a human, so it lives here too, as do the vocabularies behind the enums these routes enforce. The LINES inside a cart are their own group, and so is moving carts in and out as files.
open class Carts: Service {

    ///
    /// The cart index, and the route a storefront resumes a session with:
    /// `?contact_id=…` for a customer's carts, `?session_key=…` for a guest's,
    /// and `?is_current=true` alongside one of those two for the single cart
    /// carts.activate last marked — this list is the ONLY place that flag can be
    /// read back, and on its own the filter selects every current cart in the
    /// tenant. Filters are exact equality and never a search, unknown keys are
    /// dropped rather than refused, and `filter` echoes what was understood. Each
    /// row carries its own stored totals — `item_count` is the sum of the line
    /// QUANTITIES, not the number of lines — but never its lines: those are one
    /// call per cart. With no filter at all this is every cart the tenant holds,
    /// paged, which is a report rather than a session lookup.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - name: String (optional)
    ///   - status: RevenexxEnums.CartStatus (optional)
    ///   - contactId: String (optional)
    ///   - sessionKey: String (optional)
    ///   - channelId: String (optional)
    ///   - currency: String (optional)
    ///   - isCurrent: Bool (optional)
    ///   - itemCount: Int (optional)
    ///   - subtotal: Double (optional)
    ///   - abandonedAt: String (optional)
    ///   - orderedAt: String (optional)
    ///   - orderRef: String (optional)
    ///   - mergedIntoCartId: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsList(
        id: String? = nil,
        name: String? = nil,
        status: RevenexxEnums.CartStatus? = nil,
        contactId: String? = nil,
        sessionKey: String? = nil,
        channelId: String? = nil,
        currency: String? = nil,
        isCurrent: Bool? = nil,
        itemCount: Int? = nil,
        subtotal: Double? = nil,
        abandonedAt: String? = nil,
        orderedAt: String? = nil,
        orderRef: String? = nil,
        mergedIntoCartId: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts"

        let apiParams: [String: Any?] = [
            "id": id,
            "name": name,
            "status": status,
            "contact_id": contactId,
            "session_key": sessionKey,
            "channel_id": channelId,
            "currency": currency,
            "is_current": isCurrent,
            "item_count": itemCount,
            "subtotal": subtotal,
            "abandoned_at": abandonedAt,
            "ordered_at": orderedAt,
            "order_ref": orderRef,
            "merged_into_cart_id": mergedIntoCartId,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "limit": limit,
            "offset": offset,
            "order": order
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Opens an empty cart. The one thing it requires is an OWNER — `contact_id`
    /// for a signed-in customer or `session_key` for a guest, never neither: that
    /// is a database check on the table, and this route refuses it first with a
    /// 400 so the caller gets a sentence rather than a constraint name. Everything
    /// else is defaulted: the name 'Cart', currency EUR, status 'active', both
    /// totals 0. No column of a cart is unique, so one owner may hold as many
    /// carts as they like — unless the tenant's `multi_cart_enabled` is off, in
    /// which case a second ACTIVE cart for the same owner answers 409 naming the
    /// cart that already exists, because a storefront that hit that wants to fill
    /// THAT cart. Send `is_current: true` to have the new cart made current in the
    /// same call, which clears the flag on every sibling of the same owner. Lines
    /// are added afterwards, one call each or one bulk replace.
    ///
    /// - Parameters:
    ///   - channelId: String (optional)
    ///   - contactId: String (optional)
    ///   - currency: String (optional)
    ///   - isCurrent: Bool (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - sessionKey: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsCreate(
        channelId: String? = nil,
        contactId: String? = nil,
        currency: String? = nil,
        isCurrent: Bool? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        sessionKey: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts"

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "contact_id": contactId,
            "currency": currency,
            "is_current": isCurrent,
            "metadata": metadata,
            "name": name,
            "session_key": sessionKey
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// The login call, and the one route that turns a guest into a customer: every
    /// ACTIVE cart of one session_key is handed to a contact_id, which is what a
    /// storefront fires the moment somebody signs in with a basket already filled.
    /// There are two ways it can land, and the body picks between them. Without a
    /// target_cart_id the session carts are ADOPTED as they stand — same carts,
    /// same lines, contact_id set and session_key cleared, nothing copied and
    /// nothing closed. With a target_cart_id they are instead folded into that
    /// cart, which survives while each session cart is closed as status merged;
    /// 'adopted' and 'merged' in the answer say which of the two happened to each
    /// one. With a target cart, cart_merge_strategy decides what happens to the
    /// target's OWN lines: 'merge' keeps them and folds the session lines in,
    /// 'replace' clears them first. 'strategy' overrides it for one call (merge |
    /// replace); the answer always echoes which one ran and how many lines a
    /// replace removed.
    ///
    /// - Parameters:
    ///   - contactId: String
    ///   - sessionKey: String
    ///   - strategy: RevenexxEnums.CartMergeStrategy (optional)
    ///   - targetCartId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsClaim(
        contactId: String,
        sessionKey: String,
        strategy: RevenexxEnums.CartMergeStrategy? = nil,
        targetCartId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/claim"

        let apiParams: [String: Any?] = [
            "contact_id": contactId,
            "session_key": sessionKey,
            "strategy": strategy,
            "target_cart_id": targetCartId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Two sweeps in one pass. abandon_after_minutes marks active carts that have
    /// sat untouched past the window as abandoned (stamping abandoned_at, which
    /// nothing else in the platform ever sets — without this the abandonment
    /// funnel is empty by construction, not empty because nobody abandons carts).
    /// cart_ttl_days / guest_cart_ttl_days then DELETE carts past their retention
    /// window, line items included; both default to 0 (never), and an 'ordered'
    /// cart is never touched at any setting because it is the source record of a
    /// sale. Send dry_run to get the same counts and cart ids while writing
    /// nothing. The platform runs this per installed tenant on the schedule; it is
    /// idempotent, so calling it by hand between ticks is safe.
    ///
    /// - Parameters:
    ///   - dryRun: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.CartMaintenanceResult
    ///
    open func cartsMaintenanceRun(
        dryRun: Bool? = nil
    ) async throws -> RevenexxModels.CartMaintenanceResult {
        let apiPath: String = "/v1/carts/maintenance/run"

        let apiParams: [String: Any?] = [
            "dry_run": dryRun
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.CartMaintenanceResult = { response in
            return RevenexxModels.CartMaintenanceResult.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Which of the two carts survives is the whole question, and the answer is
    /// the TARGET: the source's lines are COPIED into the target, the target keeps
    /// every line it already had, its totals are recomputed, and it is the cart
    /// the caller goes on using. Nothing is replaced and nothing is moved — the
    /// source keeps its own line rows and is closed with status 'merged' and
    /// `merged_into_cart_id` pointing at the target, so a merged cart stays
    /// readable as the record of what went where. On the way in, a plain product
    /// line with the same product/sku AND the same `unit_price` as a line already
    /// in the target adds its quantity to that line; configured and custom lines
    /// always land as new ones. Both carts must be active and must differ, and the
    /// tenant's line limits are enforced on the target as the copies land (422).
    /// Reach for carts.merge_into where the caller holds one cart id and not two.
    ///
    /// - Parameters:
    ///   - sourceCartId: String
    ///   - targetCartId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsMerge(
        sourceCartId: String,
        targetCartId: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/merge"

        let apiParams: [String: Any?] = [
            "source_cart_id": sourceCartId,
            "target_cart_id": targetCartId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Discovery for the vocabulary routes: every enum this app publishes, each as
    /// its name, its title and its description and nothing else. The VALUES are
    /// deliberately not here — this is the index a client builds a menu from,
    /// and one call per vocabulary fills it. Names: io-apply-modes, io-directions,
    /// io-entities, io-formats, item-types, statuses. Fetch one with GET
    /// /carts/vocabularies/{name}; a client holding the qualified pair
    /// 'carts.<name>' builds that URL from the pair alone.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.CartVocabularyIndex
    ///
    open func cartsVocabulariesList(
    ) async throws -> RevenexxModels.CartVocabularyIndex {
        let apiPath: String = "/v1/carts/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.CartVocabularyIndex = { response in
            return RevenexxModels.CartVocabularyIndex.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// One vocabulary with its values filled in — every value permitted by the
    /// column behind it, each carrying the key the database stores, a human title,
    /// a description where one was written and the badge tone a UI should render
    /// it in, which is everything a select or a status chip needs from one call.
    /// The values are read out of the column's CHECK constraint, so the served set
    /// IS the enforced set and the two cannot drift — a value added to the
    /// constraint appears here even before anyone labels it, titled from its own
    /// key. Values come back in constraint order, which is the order a select
    /// should offer. 'closed' says the set is exhaustive, so a value outside it is
    /// stale data rather than a missing label. Names: io-apply-modes,
    /// io-directions, io-entities, io-formats, item-types, statuses.
    ///
    /// - Parameters:
    ///   - name: RevenexxEnums.Name
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsVocabulariesGet(
        name: RevenexxEnums.Name
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/vocabularies/{name}"
            .replacingOccurrences(of: "{name}", with: name.rawValue)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Removes the cart row and, through the `on delete cascade` on
    /// `cart_items.cart_id`, every line in it. There is no soft delete and no
    /// undo. One status is protected and it is protected permanently: an 'ordered'
    /// cart is the source record of a sale — the order carries its id in
    /// `cart_id` and the order.placed event records it — so this route refuses
    /// it with 400 and there is no flag, no force and no lifecycle route that
    /// makes it deletable. Do not go looking for one. 'active', 'abandoned' and
    /// 'merged' are all deletable, which is deliberate and is the same set the
    /// cart-maintenance sweep removes on a retention window: clearing out
    /// abandoned guest carts is the main thing anyone deletes a cart for, and a
    /// merged cart's lines were COPIED into the target, which still holds them.
    /// What the delete does NOT take with it is the trail: `merged_into_cart_id`
    /// is a plain uuid column and not a foreign key, so deleting a cart that other
    /// carts were merged INTO leaves those carts pointing at a row that no longer
    /// exists, and nothing refuses the delete or clears the pointer — the
    /// retention sweep does the same, so this is a property of the column and not
    /// of this route. For a cart a buyer simply walked away from, carts.abandon
    /// keeps the row and the funnel; for deleting on a retention window, the
    /// cart-maintenance sweep does it per market and can be asked first with
    /// `dry_run`.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// One cart with its owner, its totals and its lifecycle stamps — and none
    /// of its lines: those are a separate call (`GET /carts/{cart_id}/items`),
    /// because a cart row is small and a filled cart is not. The two totals are
    /// derived and stored, never taken from a caller: `item_count` is the sum of
    /// the line QUANTITIES rather than the number of lines (two lines of five
    /// pieces answer 10, not 2) and `subtotal` the sum of the line totals, net of
    /// shipping and tax; both are recomputed after every line write. `status` says
    /// what may still be done — only an 'active' cart accepts a write of any
    /// kind, 'abandoned' is the one reversible ending, and a 'merged' cart carries
    /// `merged_into_cart_id`, which is the trail to the cart its lines were copied
    /// into.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// The four columns a cart's own editing screen owns, and only those: `name`,
    /// `currency`, `channel_id` and `metadata`. Everything else about a cart is
    /// either derived or a lifecycle move, and both are deliberately out of reach
    /// here — `item_count` and `subtotal` are recomputed from the lines,
    /// `status` travels through the action routes (activate, abandon, reopen,
    /// order, merge) so that every transition is guarded, and `market_id` is the
    /// platform's scope on the row rather than a column this app writes. A payload
    /// carrying none of the four answers 400 rather than storing nothing quietly,
    /// so a caller never believes an ignored field was saved. The owner is not
    /// updatable either: a guest cart becomes a customer's through carts.claim.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - channelId: String (optional)
    ///   - currency: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsUpdate(
        id: String,
        channelId: String? = nil,
        currency: String? = nil,
        metadata: Any? = nil,
        name: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "currency": currency,
            "metadata": metadata,
            "name": name
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// The by-hand half of the abandonment funnel: an active cart becomes
    /// 'abandoned', `abandoned_at` is stamped, and `is_current` is cleared — so
    /// its owner is left with no current cart until another one is activated.
    /// Nothing else in the platform writes `abandoned_at`; the only other writer
    /// is the cart-maintenance sweep, which does exactly this once a cart has sat
    /// untouched past the market's `abandon_after_minutes`. This is the one
    /// reversible ending: the lines are untouched throughout and carts.reopen
    /// takes the cart back. Only an active cart can be abandoned — an ordered or
    /// merged cart is already finished and answers 400 naming the status it
    /// actually holds.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsAbandon(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}/abandon"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Activate writes exactly one thing: `is_current` on this cart, cleared on
    /// every other cart of the same owner (the same contact_id, or the same
    /// session_key). It does NOT change the status — an active cart stays
    /// active, and only an active cart may be made current. Read it back with `GET
    /// /carts?is_current=true` plus the owner: that filter is the only way to see
    /// what this route wrote, and a storefront resuming a session is its main
    /// caller. The flag is cleared again by abandoning, ordering or merging the
    /// cart, so an owner can legitimately have no current cart at all.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsActivate(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}/activate"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Identical to carts.merge, with the SOURCE taken from the path — which is
    /// what makes the merge reachable from anything holding one cart and only one:
    /// a Cockpit row action, a detail page, a storefront session. The cart in the
    /// path is therefore the one that ends: its lines are copied into the
    /// `target_cart_id` named in the body, that target keeps its own lines and
    /// survives, and the path cart is closed with status 'merged' and
    /// `merged_into_cart_id` pointing at it. Getting the two the wrong way round
    /// is the mistake this route exists to make hard, so read the path id as "the
    /// cart I am giving away". Both carts must be active and must differ.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - targetCartId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsMergeInto(
        id: String,
        targetCartId: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}/merge-into"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "target_cart_id": targetCartId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// The hand-over to order management, and the end of the cart as a workspace:
    /// an ACTIVE cart becomes 'ordered', ordered_at is stamped, and the order_ref
    /// the call carries — order management's own number for the order this cart
    /// became — is stored on the cart, which is what lets anyone filter their
    /// way from an order number back to the cart behind it. Nothing moves out of
    /// 'ordered' afterwards, and no route will delete it. The conversion applies
    /// the two tenant decisions a cart cannot make for itself. price_snapshot_mode
    /// (snapshot | live) settles which of a line's two prices is charged — the
    /// snapshot the buyer was shown, or the current unit_price — and the cart's
    /// subtotal is rewritten to match, so cart and order can never disagree;
    /// 'pricing' reports the mode, the lines it rewrote and the subtotal on both
    /// sides. convert_reserves_stock (never | request | require) decides whether
    /// inventories is asked to hold the lines; at 'require' a refusal answers 409
    /// and the cart stays active and unchanged. The reservation is attempted
    /// BEFORE anything is written.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - orderRef: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsOrder(
        id: String,
        orderRef: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}/order"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "order_ref": orderRef
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Takes an abandoned cart back to 'active' with its lines exactly as they
    /// were — what a storefront calls when a buyer follows a recovery mail, and
    /// the way out of the 400 a write gets on a cart the maintenance sweep closed
    /// while nobody was looking. It also CLEARS `abandoned_at`, so a cart that was
    /// abandoned and reopened leaves nothing behind in the funnel: the funnel
    /// counts carts that are still abandoned, not carts that ever were. It does
    /// not restore `is_current` — a reopened cart is active but not current
    /// until carts.activate says so. Only an abandoned cart may be reopened;
    /// 'ordered' and 'merged' are final and answer 400 naming the status the cart
    /// holds.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsReopen(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}/reopen"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}