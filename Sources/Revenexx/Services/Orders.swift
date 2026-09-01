import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Commerce Studio Orders App — the Order Management core. Orders are snapshots (items, addresses, buyer, payment, shipping frozen at place-time) with three independent status dimensions: lifecycle (pending→placed→in_fulfillment→completed|cancelled, plus an orthogonal on_hold flag), payment_status (fed from payments), and a fulfillment_status DERIVED from quantity-based position bookkeeping (quantity_shipped/cancelled/returned per item — partial everything). Shipments with carrier/tracking, quantity-based cancellations, a FULL returns lifecycle (registered→received→completed|rejected with per-position restock flags), internal/customer comments, configurable number ranges (format {prefix}{counter:padding}{suffix}, configurable position numbering) and the order_events table: audit trail AND domain event feed in one — every action writes an event row, the manifest emits order_event.created on insert and the row name (order.placed, order.shipment.created, order.return.completed, …) is the domain event. Beside that raw feed the app fires 14 NAMED topics — order.placed/requested, acknowledged, cancelled, item_cancelled, shipment_created, completed, payment_status_changed, held/unheld and the four return topics — each keyed to the order id, so one realtime subscription hears an order's whole life. Subscribe to those OR to order_event.created, never to both. order.placed is the event to act on rather than the entity event order.created: that one fires on the orders INSERT, before any position row exists, and fires for a quote request too. Integration boundary: the event lands on the bus — ERP workflows live in Integration Studio. Revenue leaves the app only as an ANSWER: orders.reports.customer-rollup aggregates per-organization order count, revenue, first/last order date and 30/90/365-day windows in additive form (count/sum/min/max, so partial answers merge) — the customers app materializes it into a local projection its segment rules can query, because a cross-app join is forbidden (ADR-0055).
open class Orders: Service {

    ///
    /// The route behind every order overview: the open orders of one customer,
    /// everything on hold, everything a market placed last week, or the one order
    /// somebody is quoting a number for (?number=ORD-000123 — the number is not
    /// the id, and this is how one becomes the other). The order LIST: the order
    /// rows without their positions, shipments, returns or cancellations — read
    /// GET /orders/{id} for the aggregate of one. Every parameter below is an
    /// exact match on the column it names, and combining them is an AND. Two kinds
    /// of key are not offered: one that names NO column is dropped silently, so a
    /// mistyped ?stauts=placed answers 200 with the whole list (compare the
    /// 'filter' echo against what you sent — no status code reports it), and the
    /// jsonb columns buyer, billing_address, shipping_address, payment, shipping,
    /// user_data and metadata reach the database as a text comparison and answer
    /// 400 invalid_value for anything that is not a whole JSON document.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - number: String (optional)
    ///   - customerOrderNumber: String (optional)
    ///   - externalRef: String (optional)
    ///   - acknowledgedAt: String (optional)
    ///   - cartId: String (optional)
    ///   - contactId: String (optional)
    ///   - organizationId: String (optional)
    ///   - channelId: String (optional)
    ///   - currency: String (optional)
    ///   - status: RevenexxEnums.OrderStatus (optional)
    ///   - paymentStatus: RevenexxEnums.OrderPaymentStatus (optional)
    ///   - fulfillmentStatus: RevenexxEnums.OrderFulfillmentStatus (optional)
    ///   - onHold: Bool (optional)
    ///   - holdReason: String (optional)
    ///   - itemCount: Int (optional)
    ///   - subtotal: Double (optional)
    ///   - shippingTotal: Double (optional)
    ///   - taxTotal: Double (optional)
    ///   - grandTotal: Double (optional)
    ///   - placedAt: String (optional)
    ///   - completedAt: String (optional)
    ///   - cancelledAt: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func ordersList(
        id: String? = nil,
        number: String? = nil,
        customerOrderNumber: String? = nil,
        externalRef: String? = nil,
        acknowledgedAt: String? = nil,
        cartId: String? = nil,
        contactId: String? = nil,
        organizationId: String? = nil,
        channelId: String? = nil,
        currency: String? = nil,
        status: RevenexxEnums.OrderStatus? = nil,
        paymentStatus: RevenexxEnums.OrderPaymentStatus? = nil,
        fulfillmentStatus: RevenexxEnums.OrderFulfillmentStatus? = nil,
        onHold: Bool? = nil,
        holdReason: String? = nil,
        itemCount: Int? = nil,
        subtotal: Double? = nil,
        shippingTotal: Double? = nil,
        taxTotal: Double? = nil,
        grandTotal: Double? = nil,
        placedAt: String? = nil,
        completedAt: String? = nil,
        cancelledAt: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/orders"

        let apiParams: [String: Any?] = [
            "id": id,
            "number": number,
            "customer_order_number": customerOrderNumber,
            "external_ref": externalRef,
            "acknowledged_at": acknowledgedAt,
            "cart_id": cartId,
            "contact_id": contactId,
            "organization_id": organizationId,
            "channel_id": channelId,
            "currency": currency,
            "status": status,
            "payment_status": paymentStatus,
            "fulfillment_status": fulfillmentStatus,
            "on_hold": onHold,
            "hold_reason": holdReason,
            "item_count": itemCount,
            "subtotal": subtotal,
            "shipping_total": shippingTotal,
            "tax_total": taxTotal,
            "grand_total": grandTotal,
            "placed_at": placedAt,
            "completed_at": completedAt,
            "cancelled_at": cancelledAt,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "limit": limit,
            "offset": offset,
            "order": order
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// The counters this tenant numbers its orders, delivery notes and returns
    /// from — what an operator sees on the Number ranges settings page, and what
    /// a migration reads to check the prefixes and the padding before it imports
    /// anything. Every parameter below is an exact-match filter on the column it
    /// names (?code=order finds the order counter). Two things are not: a key that
    /// names NO column is dropped silently — the call answers 200 with the
    /// unfiltered page, so compare the 'filter' echo against what you sent — and
    /// the jsonb column 'metadata' is honoured by the router but refused by the
    /// database (400 invalid_value) unless the value is a whole JSON document,
    /// which is why it is not offered here. It does not draw a number: `counter`
    /// is the last number DRAWN, and only placing an order, a shipment or a return
    /// moves it.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - code: String (optional)
    ///   - prefix: String (optional)
    ///   - suffix: String (optional)
    ///   - padding: Int (optional)
    ///   - counter: Int (optional)
    ///   - step: Int (optional)
    ///   - positionStep: Int (optional)
    ///   - channelId: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func ordersNumberRangesList(
        id: String? = nil,
        code: String? = nil,
        `prefix`: String? = nil,
        suffix: String? = nil,
        padding: Int? = nil,
        counter: Int? = nil,
        step: Int? = nil,
        positionStep: Int? = nil,
        channelId: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/orders/number-ranges"

        let apiParams: [String: Any?] = [
            "id": id,
            "code": code,
            "prefix": `prefix`,
            "suffix": suffix,
            "padding": padding,
            "counter": counter,
            "step": step,
            "position_step": positionStep,
            "channel_id": channelId,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "limit": limit,
            "offset": offset,
            "order": order
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Add a counter beyond the three a tenant is seeded with, and give it the
    /// shape a merchant's numbers actually have: {prefix}{counter padded to
    /// `padding`}{suffix}, moving by `step` per draw. A new range is what the
    /// order_number_range_code / delivery_number_range_code /
    /// return_number_range_code settings can then be pointed at — the code is
    /// the name those settings use, and a setting naming a code no range carries
    /// makes placing an order answer 422. `code` is unique per tenant, so this is
    /// a 409 for one that is taken rather than a second counter under the same
    /// name. It does not renumber anything that already exists, and setting
    /// `counter` to a value already issued re-issues those numbers, which the
    /// unique index on the order number then refuses.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - channelId: String (optional)
    ///   - counter: Int (optional)
    ///   - metadata: Any (optional)
    ///   - padding: Int (optional)
    ///   - positionStep: Int (optional)
    ///   - prefix: String (optional)
    ///   - step: Int (optional)
    ///   - suffix: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersNumberRangesCreate(
        code: String,
        channelId: String? = nil,
        counter: Int? = nil,
        metadata: Any? = nil,
        padding: Int? = nil,
        positionStep: Int? = nil,
        `prefix`: String? = nil,
        step: Int? = nil,
        suffix: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/number-ranges"

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "code": code,
            "counter": counter,
            "metadata": metadata,
            "padding": padding,
            "position_step": positionStep,
            "prefix": `prefix`,
            "step": step,
            "suffix": suffix
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
    /// Make sure the three codes this app draws from exist: 'order' (ORD-),
    /// 'delivery' (DEL-) and 'return' (RET-), each padded to six digits and
    /// stepping by one. The app runs it for you on install, so a fresh tenant
    /// needs nothing; call it by hand after a range was deleted, or to check what
    /// a tenant has. Idempotent: a code that already exists comes back under
    /// 'existing' and is left EXACTLY as it is, counter included, so a merchant
    /// who changed the prefix keeps their change. Answers 200, never 201 — it is
    /// a reconcile, not a create — and it never repairs or renames a range that
    /// is already there.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.OrderNumberRangesSeeded
    ///
    open func ordersNumberRangesDefaults(
    ) async throws -> RevenexxModels.OrderNumberRangesSeeded {
        let apiPath: String = "/v1/orders/number-ranges/defaults"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.OrderNumberRangesSeeded = { response in
            return RevenexxModels.OrderNumberRangesSeeded.from(map: response as! [String: Any])
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
    /// Remove a counter a tenant no longer numbers anything from. It touches
    /// nothing that was numbered out of it: existing orders, delivery notes and
    /// returns keep the numbers they were given, because a number is copied onto
    /// the row at place-time and is not a reference to this table. Deleting one of
    /// the three standard codes is allowed and is usually a mistake — the next
    /// draw against it answers 422 'number_range_missing', unless POST
    /// /orders/number-ranges/defaults or a reinstall seeds it again, which starts
    /// its counter back at 0.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersNumberRangesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/number-ranges/{id}"
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
    /// One counter with its whole configuration: the prefix and suffix around the
    /// number, how wide it is padded, how far each draw moves it, where it
    /// currently stands, and the position_step new order lines are numbered in.
    /// Reach for it when you hold the id — from the list, or from what a create
    /// answered — and want the row as it stands now. Reading does not draw a
    /// number and does not move `counter`; the id is the range's uuid, not its
    /// `code`, and a code is turned into a range through GET
    /// /orders/number-ranges?code=order.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersNumberRangesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/number-ranges/{id}"
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
    /// Change the format or the state of an existing counter: a new prefix or
    /// suffix, a wider padding, a different step, a different position_step for
    /// new order lines — or `counter` itself, which is state rather than
    /// configuration. Everything takes effect on the NEXT draw only: nothing that
    /// was already numbered is renumbered, so widening the padding leaves
    /// ORD-000123 and starts writing ORD-0000124. Moving `counter` forward skips
    /// numbers, and moving it back re-issues numbers that exist, which the unique
    /// index on the order number answers 409 for at place-time rather than here.
    /// Renaming `code` to one another range of this tenant already holds is a 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - channelId: String (optional)
    ///   - code: String (optional)
    ///   - counter: Int (optional)
    ///   - metadata: Any (optional)
    ///   - padding: Int (optional)
    ///   - positionStep: Int (optional)
    ///   - prefix: String (optional)
    ///   - step: Int (optional)
    ///   - suffix: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersNumberRangesUpdate(
        id: String,
        channelId: String? = nil,
        code: String? = nil,
        counter: Int? = nil,
        metadata: Any? = nil,
        padding: Int? = nil,
        positionStep: Int? = nil,
        `prefix`: String? = nil,
        step: Int? = nil,
        suffix: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/number-ranges/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "code": code,
            "counter": counter,
            "metadata": metadata,
            "padding": padding,
            "position_step": positionStep,
            "prefix": `prefix`,
            "step": step,
            "suffix": suffix
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
    /// The way an order comes into existence — the call a checkout, a punch-out
    /// or an ERP import makes once the basket is final. The body is a SNAPSHOT:
    /// items with their product copies, plus the buyer, the addresses and the
    /// payment and shipping choices frozen as they were at this moment, so the
    /// order stays readable when the catalogue or the customer changes underneath
    /// it. The app draws the order number from the tenant's order range, numbers
    /// the positions, computes subtotal, tax and grand_total from the lines, and
    /// writes the order.placed event that carries the order onto the bus. It does
    /// not reserve stock, take payment or talk to an ERP: those are separate
    /// capabilities, and this route's job ends when the event is on the bus. Two
    /// things can turn a placement into a REQUEST awaiting approval, and both
    /// still answer 201 — with status='pending' and no placed_at: a principal
    /// holding only orders.request, and an order worth more than the tenant's
    /// require_approval_above_value (a principal holding orders.approve is exempt
    /// from the threshold). The order.requested event says which, in
    /// 'approval_reason'. The currency defaults to the market's default_currency
    /// setting and the position cap is the tenant's max_items_per_order.
    ///
    /// - Parameters:
    ///   - items: [RevenexxModels.OrderItemCreateRequest]
    ///   - billingAddress: Any (optional)
    ///   - buyer: Any (optional)
    ///   - cartId: String (optional)
    ///   - channelId: String (optional)
    ///   - contactId: String (optional)
    ///   - currency: String (optional)
    ///   - customerOrderNumber: String (optional)
    ///   - grandTotal: Double (optional)
    ///   - metadata: Any (optional)
    ///   - organizationId: String (optional)
    ///   - payment: Any (optional)
    ///   - shipping: Any (optional)
    ///   - shippingAddress: Any (optional)
    ///   - shippingTotal: Double (optional)
    ///   - userData: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersPlace(
        items: [RevenexxModels.OrderItemCreateRequest],
        billingAddress: Any? = nil,
        buyer: Any? = nil,
        cartId: String? = nil,
        channelId: String? = nil,
        contactId: String? = nil,
        currency: String? = nil,
        customerOrderNumber: String? = nil,
        grandTotal: Double? = nil,
        metadata: Any? = nil,
        organizationId: String? = nil,
        payment: Any? = nil,
        shipping: Any? = nil,
        shippingAddress: Any? = nil,
        shippingTotal: Double? = nil,
        userData: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/place"

        let apiParams: [String: Any?] = [
            "billing_address": billingAddress,
            "buyer": buyer,
            "cart_id": cartId,
            "channel_id": channelId,
            "contact_id": contactId,
            "currency": currency,
            "customer_order_number": customerOrderNumber,
            "grand_total": grandTotal,
            "items": items,
            "metadata": metadata,
            "organization_id": organizationId,
            "payment": payment,
            "shipping": shipping,
            "shipping_address": shippingAddress,
            "shipping_total": shippingTotal,
            "user_data": userData
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
    /// What each company has bought, as numbers another app can keep: order count,
    /// lifetime revenue, first and last order date, and the same count and revenue
    /// over the last 30, 90 and 365 days. This is what a customer segment like
    /// "bought for more than 100k last year" is built on, and the customers app
    /// materialises it into a local projection its segment rules query. It answers
    /// about ORGANIZATIONS only — a private or guest order carries none and is
    /// counted in orders_without_organization rather than attributed to anybody
    /// — and it converts nothing, so an organization that ordered in two
    /// currencies gets both listed and one summed number to read with care.
    /// Revenue lives in orders, customer segments live in the customers app, and
    /// the two may not join (ADR-0055: no cross-app FK, grant or view). This
    /// capability is the hand-over. Every number is additive (count/sum/min/max)
    /// so partial answers merge; the average order value is deliberately not
    /// returned — it is revenue_total / order_count over the merged parts.
    /// Windows are anchored at as_of, which is echoed back so a loop measures one
    /// consistent picture.
    ///
    /// - Parameters:
    ///   - asOf: String (optional)
    ///   - cursor: String (optional)
    ///   - organizationIds: [String] (optional)
    ///   - statuses: [RevenexxEnums.OrderStatus] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.OrderCustomerRollupResponse
    ///
    open func ordersReportsCustomerRollup(
        asOf: String? = nil,
        cursor: String? = nil,
        organizationIds: [String]? = nil,
        statuses: [RevenexxEnums.OrderStatus]? = nil
    ) async throws -> RevenexxModels.OrderCustomerRollupResponse {
        let apiPath: String = "/v1/orders/reports/customer-rollup"

        let apiParams: [String: Any?] = [
            "as_of": asOf,
            "cursor": cursor,
            "organization_ids": organizationIds,
            "statuses": statuses
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.OrderCustomerRollupResponse = { response in
            return RevenexxModels.OrderCustomerRollupResponse.from(map: response as! [String: Any])
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
    /// Which value sets this app will describe for you, by name — order
    /// statuses, payment statuses, fulfillment statuses, item types, return
    /// statuses and return resolutions — so a client can discover them instead
    /// of shipping its own copy of five statuses that goes stale one release
    /// later. The values themselves are deliberately NOT here: this is the index,
    /// and each set is fetched on its own. Discovery for the vocabulary routes.
    /// Names: cancellation-scopes, comment-visibilities, fulfillment-statuses,
    /// item-types, payment-statuses, return-resolutions, return-statuses,
    /// statuses. Fetch one with GET /orders/vocabularies/{name}; a client holding
    /// the qualified pair 'orders.<name>' builds that URL from the pair alone.
    /// 'title' and 'description' are locale maps wherever somebody wrote the copy
    /// and plain strings where the fallback did — read both forms.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.OrderVocabularyIndex
    ///
    open func ordersVocabulariesList(
    ) async throws -> RevenexxModels.OrderVocabularyIndex {
        let apiPath: String = "/v1/orders/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.OrderVocabularyIndex = { response in
            return RevenexxModels.OrderVocabularyIndex.from(map: response as! [String: Any])
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
    /// Everything a UI needs to render one of this app's value sets without
    /// knowing it: every permitted value, in order, each with a title and
    /// description in the locales somebody wrote and a badge tone to colour it.
    /// Fetch it once and a status filter, a status badge and a resolution picker
    /// all stay correct through a lifecycle change, because the set served IS the
    /// set enforced. It answers about values, not about rows — nothing here says
    /// how many orders are in a status. The values are read out of the column's
    /// CHECK constraint, so the served set IS the enforced set and the two cannot
    /// drift — a value added to the constraint appears here even before anyone
    /// labels it, titled from its own key. Values come back in constraint order,
    /// which is lifecycle order for a status, and 'final' marks the values that
    /// END the lifecycle (completed, cancelled) so a client can ask "is this order
    /// still open?" instead of matching names it guessed. Every set is exhaustive
    /// ('closed' is always true); 'source' says who enforces it — 'schema' for a
    /// CHECK constraint, 'app' for 'return-resolutions', whose column carries none
    /// and whose words the return routes enforce instead. Those values
    /// additionally carry 'stage' (complete | reject): the transition that accepts
    /// them. 'title' and 'description' are locale maps where the copy was written
    /// and plain strings where the key-derived fallback answered, on the
    /// vocabulary and on every value alike. Names: cancellation-scopes,
    /// comment-visibilities, fulfillment-statuses, item-types, payment-statuses,
    /// return-resolutions, return-statuses, statuses.
    ///
    /// - Parameters:
    ///   - name: RevenexxEnums.OrdersVocabulariesGetName
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersVocabulariesGet(
        name: RevenexxEnums.OrdersVocabulariesGetName
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/vocabularies/{name}"
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
    /// The single source of order information, and what an order detail screen is
    /// built from: the order row plus its positions, its shipments with the
    /// shipment_items each one booked, its returns and its cancellations — one
    /// call, no assembling five lists. A cancellation's and a return's 'positions'
    /// are ARRAYS of {order_item_id, quantity}; a return's entries additionally
    /// carry 'restock'. Two things it does not carry: the comments and the event
    /// trail, which are their own paginated routes because both grow without
    /// bound. Addressed by uuid — an order number goes through GET
    /// /orders?number=… first.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}"
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
    /// The narrow correction window a service desk needs: the customer gave the
    /// wrong delivery address, the buyer's name is misspelled, their
    /// purchase-order number was missing. Six columns and no others —
    /// customer_order_number, buyer, billing_address, shipping_address, user_data
    /// and metadata — and each is REPLACED whole, not merged, so send the entire
    /// address rather than the one line that changed. It moves nothing: status,
    /// payment_status, fulfillment_status and the quantities belong to the action
    /// routes, and a body carrying them is accepted with those keys quietly
    /// dropped. The window closes when the fulfilling system acknowledges the
    /// order, because from then on the ERP holds the copy that ships — unless
    /// the tenant set allow_modification_after_acknowledge. Every accepted change
    /// writes an order.updated event naming the columns it touched.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - billingAddress: Any (optional)
    ///   - buyer: Any (optional)
    ///   - customerOrderNumber: String (optional)
    ///   - metadata: Any (optional)
    ///   - shippingAddress: Any (optional)
    ///   - userData: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersUpdate(
        id: String,
        billingAddress: Any? = nil,
        buyer: Any? = nil,
        customerOrderNumber: String? = nil,
        metadata: Any? = nil,
        shippingAddress: Any? = nil,
        userData: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "billing_address": billingAddress,
            "buyer": buyer,
            "customer_order_number": customerOrderNumber,
            "metadata": metadata,
            "shipping_address": shippingAddress,
            "user_data": userData
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
    /// The return channel for whatever fulfils the order. An Integration Studio
    /// workflow picks up order.placed, books the order into the ERP, and calls
    /// this with the id the ERP gave it — which lands in external_ref and makes
    /// the two systems mutually findable. It stamps acknowledged_at from the
    /// server's clock, and that timestamp is what closes the correction window:
    /// PUT /orders/{id} refuses afterwards, because the copy that ships now lives
    /// elsewhere. It is a handshake and nothing more — it does not change
    /// status, payment_status or fulfillment_status, and it does not ship
    /// anything. Once only: a second call is a 422 rather than a silent overwrite
    /// of the first system's reference.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - externalRef: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersAcknowledge(
        id: String,
        externalRef: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/acknowledge"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "external_ref": externalRef
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
    /// Call the whole order off: every position's full quantity is booked as
    /// cancelled, the order moves to 'cancelled', a cancellation record is written
    /// with the reason and who gave it, and an order.cancelled event goes onto the
    /// bus. Only while NOTHING has shipped — once a single position has gone out
    /// the order is partly real and this answers 422; take the remaining
    /// quantities off with POST /orders/{id}/items/cancel instead, and handle what
    /// already shipped as a return. It refunds nothing and returns nothing to
    /// stock: payment travels through /payment-status and restocking is an
    /// explicit inventories call by the orchestrator. A tenant may require a
    /// reason (cancel_requires_reason), and a hold may block it (on_hold_blocks =
    /// 'shipping_and_cancel').
    ///
    /// - Parameters:
    ///   - id: String
    ///   - cancelledBy: String (optional)
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersCancel(
        id: String,
        cancelledBy: String? = nil,
        reason: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/cancel"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "cancelled_by": cancelledBy,
            "reason": reason
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
    /// What people have written about this order, oldest first: the service desk's
    /// own notes and the messages meant for the customer, in one list. Filter by
    /// ?visibility=customer to build the version a customer may see, and by
    /// ?visibility=internal for the desk's own — the route does NOT decide that
    /// for you, so a customer-facing surface has to ask for the customer ones.
    /// Comments are prose about the order and never move it; the lifecycle lives
    /// in the event trail. Every parameter below is an exact match on the column
    /// it names. `order_id` is deliberately absent: the route fixes it from the
    /// path AFTER the query filter is read, so sending one is accepted and then
    /// overwritten — it filters nothing. DEPRECATED KEY: the response also
    /// repeats 'items' under 'comments' for compatibility with the pre-envelope
    /// shape. It is the same array; read 'items'. The alias is removed in the next
    /// minor version.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - idQuery: String (optional)
    ///   - body: String (optional)
    ///   - visibility: RevenexxEnums.OrderCommentVisibility (optional)
    ///   - author: String (optional)
    ///   - createdAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersCommentsList(
        id: String,
        idQuery: String? = nil,
        body: String? = nil,
        visibility: RevenexxEnums.OrderCommentVisibility? = nil,
        author: String? = nil,
        createdAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/comments"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "id": idQuery,
            "body": body,
            "visibility": visibility,
            "author": author,
            "created_at": createdAt,
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
    /// Write down what happened that the state machine cannot record: what the
    /// customer said on the phone, why an exception was made, what the warehouse
    /// found in the box. `visibility` decides who the note is for — 'internal'
    /// for the service desk, 'customer' for text meant to be shown to the buyer
    /// — and it defaults to the tenant's default_comment_visibility, which is
    /// 'internal' out of the box, so a note is never accidentally customer-facing.
    /// Adding one writes an order.comment.added event, so the trail shows that a
    /// note was made and its visibility, without copying the text onto the bus. It
    /// changes nothing about the order, and it sends nothing to anybody: this
    /// stores a comment, it does not email the customer.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - body: String
    ///   - author: String (optional)
    ///   - visibility: RevenexxEnums.OrderCommentVisibility (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersCommentsCreate(
        id: String,
        body: String,
        author: String? = nil,
        visibility: RevenexxEnums.OrderCommentVisibility? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/comments"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "author": author,
            "body": body,
            "visibility": visibility
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
    /// Declare the order finished, whatever the quantities say — the service was
    /// delivered, the download was fetched, or an operator has decided the rest is
    /// not coming. status moves to 'completed' and completed_at is stamped from
    /// the server's clock. It does NOT ship anything or change the quantities, so
    /// fulfillment_status stays whatever the positions make it, and an order
    /// completed with lines still open shows exactly that. A completed order is
    /// final: modification, shipping and cancellation all refuse afterwards, and
    /// only a return may still be registered against it. The counterpart of
    /// auto_complete_on = 'payment' | 'manual': something has to close an order
    /// that shipping no longer closes by itself, and it is also the honest end for
    /// a service or digital order that never ships. Writes an order_events row
    /// 'order.completed' with via='manual'.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - completedBy: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersComplete(
        id: String,
        completedBy: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/complete"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "completed_by": completedBy
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
    /// Everything that has ever happened to this order, oldest first: placed or
    /// requested, updated, acknowledged, shipped, held, paid, returned, completed,
    /// cancelled — each with the payload the action carried. This is the audit
    /// trail an operator reads to answer "why is this order in this state", and it
    /// is the same row the platform publishes as a domain event, so what a
    /// workflow reacted to and what a person sees here cannot diverge. It is
    /// append-only and this route is read-only: rows are written by the action
    /// routes and there is no way to add, edit or remove one. An order's trail
    /// grows for as long as the order lives, so it is paginated like every other
    /// list — 'page.hasMore' says whether more of it exists. Every parameter
    /// below is an exact match on the column it names; `order_id` is deliberately
    /// absent, because the route fixes it from the path after the query filter is
    /// read and a value sent for it is overwritten rather than honoured. The jsonb
    /// column 'payload' is not offered for the same reason it is not offered on
    /// the order list: the data plane answers 400 for anything that is not a whole
    /// JSON document. DEPRECATED KEY: the response also repeats 'items' under
    /// 'events' for compatibility with the pre-envelope shape. It is the same
    /// array; read 'items'. The alias is removed in the next minor version.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - idQuery: String (optional)
    ///   - name: String (optional)
    ///   - actor: String (optional)
    ///   - createdAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersEventsList(
        id: String,
        idQuery: String? = nil,
        name: String? = nil,
        actor: String? = nil,
        createdAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/events"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "id": idQuery,
            "name": name,
            "actor": actor,
            "created_at": createdAt,
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
    /// Stop an order from moving while a human sorts something out — a credit
    /// check, a suspected fraud, an address nobody can deliver to. It sets a flag
    /// with the reason attached, and the flag is deliberately ORTHOGONAL to the
    /// lifecycle: the order keeps its status, its payment status and its
    /// quantities, and appears on a worklist as 'held' rather than being pushed
    /// into a state it will have to come back out of. How far the hold reaches is
    /// the tenant's setting on_hold_blocks: shipping only, shipping and
    /// cancellation (the credit-check case, where the order must move in neither
    /// direction), or nothing at all, which leaves the flag advisory. Holding an
    /// order twice is allowed and simply replaces the reason; releasing it is POST
    /// /orders/{id}/unhold.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersHold(
        id: String,
        reason: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/hold"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "reason": reason
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
    /// Take quantities off an order that is otherwise going ahead — three of the
    /// ten are discontinued, one line is out of stock and the customer would
    /// rather not wait. Each named quantity is booked onto its position as
    /// cancelled and guarded against the OPEN quantity (ordered − shipped −
    /// cancelled), so nothing already shipped can be cancelled away underneath a
    /// shipment. The order's fulfillment_status is re-derived afterwards, and when
    /// every position ends up fully cancelled the order itself moves to
    /// 'cancelled' — which is how this becomes a full cancel by arithmetic
    /// rather than by a second call. Positions are REQUIRED here, unlike on /ship
    /// and /return: cancelling an entire order by omitting a field is not
    /// something anybody should be able to do by accident; that is what POST
    /// /orders/{id}/cancel is for. Read GET /orders/{id}/shippable for the open
    /// quantity per position before calling.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - positions: [RevenexxModels.OrderCancelPosition]
    ///   - cancelledBy: String (optional)
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersItemsCancel(
        id: String,
        positions: [RevenexxModels.OrderCancelPosition],
        cancelledBy: String? = nil,
        reason: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/items/cancel"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "cancelled_by": cancelledBy,
            "positions": positions,
            "reason": reason
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
    /// Payment is the one status dimension this app does not decide for itself: it
    /// is FED IN from whatever took the money — the payments app, a PSP webhook
    /// relayed by a workflow, or a finance clerk marking an invoice settled. This
    /// route writes that word onto the order and records the change as an
    /// order.payment_status.changed event carrying the previous value, so the
    /// trail shows the sequence and not just the current state. Optionally attach
    /// the payment_id of the transaction it came from. It takes no money, refunds
    /// none and validates nothing about the amount — it records a fact somebody
    /// else established, and any of the seven words may follow any other. The
    /// other half of auto_complete_on = 'payment': an order that has shipped in
    /// full is completed by this call when the status becomes 'paid'.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - status: RevenexxEnums.OrderPaymentStatus
    ///   - paymentId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersPaymentStatusUpdate(
        id: String,
        status: RevenexxEnums.OrderPaymentStatus,
        paymentId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/payment-status"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "payment_id": paymentId,
            "status": status
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
    /// Open a return case: the customer has announced goods are coming back, and
    /// this is where that becomes a tracked thing with a return number of its own,
    /// drawn from the tenant's return range. Positions are guarded against what
    /// actually SHIPPED and has not already come back, so a return cannot exceed
    /// the goods that left. Each position carries a `restock` flag saying whether
    /// the item is expected to be sellable again — recorded now, acted on only
    /// when the return completes. Omitting `positions` registers everything still
    /// returnable, the 'the customer sent the whole delivery back' case. Nothing
    /// is booked yet: quantity_returned stays where it is and the order does not
    /// move — the return starts as 'registered' and travels through receive and
    /// complete or reject. Allowed on a completed order, refused on a cancelled
    /// one.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - metadata: Any (optional)
    ///   - positions: [RevenexxModels.OrderReturnPosition] (optional)
    ///   - reason: String (optional)
    ///   - restock: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersReturn(
        id: String,
        metadata: Any? = nil,
        positions: [RevenexxModels.OrderReturnPosition]? = nil,
        reason: String? = nil,
        restock: Bool? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/return"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "metadata": metadata,
            "positions": positions,
            "reason": reason,
            "restock": restock
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
    /// Accept the return and close the case: the goods are taken back on the
    /// order's books and the settlement is recorded as one of the published words
    /// — refunded, credited, replaced and so on. This is the step a refund or a
    /// credit note hangs off, and the only step that moves quantity_returned. It
    /// does not refund money and does not put stock back itself: the answer's
    /// 'restock' array names what the orchestrator should hand to
    /// inventories.restock, and payment travels through /payment-status. Once
    /// completed the return is final — receive, complete and reject all refuse
    /// afterwards. The goods accounting moves here and nowhere else:
    /// quantity_returned is booked onto each position, completed_at is stamped by
    /// the SERVER, and positions flagged restock are reported back in the answer's
    /// 'restock' array for the orchestrator's inventories.restock call.
    /// 'resolution' is validated against the settlement words this app publishes
    /// (refund, partial_refund, replacement, repair, store_credit — see GET
    /// /orders/vocabularies/return-resolutions); anything else is refused rather
    /// than stored as a word no reader knows. It is checked before the positions
    /// are booked, so a rejected value leaves nothing behind.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - rid: String
    ///   - resolution: RevenexxEnums.OrderReturnSettlement (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersReturnsComplete(
        id: String,
        rid: String,
        resolution: RevenexxEnums.OrderReturnSettlement? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/returns/{rid}/complete"
            .replacingOccurrences(of: "{id}", with: id)
            .replacingOccurrences(of: "{rid}", with: rid)

        let apiParams: [String: Any?] = [
            "resolution": resolution
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
    /// The goods-in scan: the parcel is physically back, warehouse staff have it
    /// in their hands, and nobody has decided yet whether the customer gets their
    /// money. It moves the return from 'registered' to 'received' and stamps
    /// received_at, which is what separates 'announced' from 'here' on a returns
    /// worklist. It books nothing — quantity_returned is written by the complete
    /// step and by nothing else — so a return that arrives damaged can still be
    /// rejected afterwards. Only a registered return can be received; a second
    /// call, or one against a settled return, is a 422. This step is skippable: a
    /// return may be completed straight from 'registered' where a merchant does
    /// not scan goods in.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - rid: String
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersReturnsReceive(
        id: String,
        rid: String,
        data: Any
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/returns/{rid}/receive"
            .replacingOccurrences(of: "{id}", with: id)
            .replacingOccurrences(of: "{rid}", with: rid)

        let apiParams: [String: Any?] = [
            "data": data
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
    /// Close the case against the customer: the goods came back used, outside the
    /// window, or were never covered in the first place. The return moves to
    /// 'rejected', rejected_at is stamped, and the refusal is recorded either as
    /// one of the published refusal words or as a sentence somebody wrote about
    /// this one return. The order is untouched — the quantities still count as
    /// shipped and not returned, which is the point: a rejected return must leave
    /// the books exactly as they were. Rejection is final, and it says nothing
    /// about where the physical goods go. Nothing is booked onto the positions.
    /// 'resolution' is validated against the refusal words (wear_and_tear,
    /// not_returnable); 'reason' stays free text — a sentence about this one
    /// return rather than a value out of a set — and is what is stored when no
    /// resolution is named.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - rid: String
    ///   - reason: String (optional)
    ///   - resolution: RevenexxEnums.OrderReturnRefusal (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersReturnsReject(
        id: String,
        rid: String,
        reason: String? = nil,
        resolution: RevenexxEnums.OrderReturnRefusal? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/returns/{rid}/reject"
            .replacingOccurrences(of: "{id}", with: id)
            .replacingOccurrences(of: "{rid}", with: rid)

        let apiParams: [String: Any?] = [
            "reason": reason,
            "resolution": resolution
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
    /// Book goods out: which positions and how much of each, with the carrier and
    /// the tracking code that go to the customer. It draws a delivery-note number
    /// from the tenant's delivery range, books quantity_shipped onto every named
    /// position, re-derives the order's fulfillment_status from the arithmetic
    /// (unfulfilled → partial → fulfilled) and emits order.shipment.created.
    /// Omitting `positions` means everything still open, in full, which is the
    /// ordinary 'send the rest' case and the only one a UI without a line editor
    /// can express; the answer always names the quantities that actually went out.
    /// It does not print a label, buy postage or notify anybody — a shipping
    /// workflow reacts to the event. Whether a full shipment CLOSES the order is
    /// the tenant's call (setting auto_complete_on): 'shipment' completes it here,
    /// 'payment' leaves it in_fulfillment until payment_status becomes paid,
    /// 'manual' waits for orders.complete. The order.completed event follows the
    /// order, so it is only emitted when the order actually completed.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - carrier: String (optional)
    ///   - metadata: Any (optional)
    ///   - number: String (optional)
    ///   - positions: [RevenexxModels.OrderShipmentPosition] (optional)
    ///   - shippedAt: String (optional)
    ///   - trackingCode: String (optional)
    ///   - trackingUrl: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersShip(
        id: String,
        carrier: String? = nil,
        metadata: Any? = nil,
        number: String? = nil,
        positions: [RevenexxModels.OrderShipmentPosition]? = nil,
        shippedAt: String? = nil,
        trackingCode: String? = nil,
        trackingUrl: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/ship"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "carrier": carrier,
            "metadata": metadata,
            "number": number,
            "positions": positions,
            "shipped_at": shippedAt,
            "tracking_code": trackingCode,
            "tracking_url": trackingUrl
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
    /// What a shipment dialog needs before it can offer anything: the open
    /// quantity per position, and one boolean saying whether a shipment would be
    /// accepted at all. Reach for it to fill a picking screen or to decide whether
    /// a 'create shipment' button is enabled, instead of subtracting the
    /// quantities client-side. It changes nothing and books nothing — it is the
    /// question POST /orders/{id}/ship answers with an action. The read half of
    /// orders.ship. The open quantity per position and the two guards
    /// (cancelled/completed order, hold) are the SAME code the ship route runs, so
    /// what this answers and what that accepts cannot drift — a client
    /// subtracting the quantities itself eventually offers a shipment the server
    /// refuses, or one it should have refused. 'shippable' is false with a
    /// 'blocked_reason' when the order is held, cancelled, completed or has
    /// nothing open.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersShippable(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/shippable"
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
    /// The whole of the release: the flag comes off, the reason is cleared, and an
    /// order.unheld event says the order may move again. Whatever the hold was
    /// blocking — shipping, and cancellation on tenants configured that way —
    /// is accepted from this call on. It restores nothing else and skips nothing:
    /// the order continues from exactly the status and quantities it had when it
    /// was held, and any shipping that was due meanwhile still has to be done by
    /// hand. An order that is not on hold answers 422 rather than pretending to
    /// release one, so this is safe to give to a worklist and not to a loop that
    /// calls it blindly.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func ordersUnhold(
        id: String,
        data: Any
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/orders/{id}/unhold"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "data": data
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


}