import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// How much is there, what may still be sold, and every call that changes the number. A stock level is one item at one location and it carries two figures, neither of which is the sellable one: `on_hand` counts what is physically there INCLUDING everything already promised, `reserved` counts the promises and never reduces `on_hand`, and what a shop may sell is the difference — derived on read, never stored, so there is no `available` column to filter or order by. The balance is not editable either: every change is a booking in the movements ledger, which is why `receive` (goods in), `adjust` (a signed correction with a reason), `restock` (a return coming back) and the row-scoped adjust are the only things that move a number, and why the ledger reads sit in this same group rather than a section of their own — a movement is the receipt for the call above it, not a subject. POST /inventories/availability is the read side of all of it, and the one capability an ERP-stocked tenant replaces wholesale through the gateway override. The vocabulary routes are here because the code a caller cannot guess is a movement's `type`: it decides the SIGN of the quantity.
open class InventoriesStock: Service {

    ///
    /// The batch correction route — a stocktake, breakage, shrinkage — and the
    /// manual way `on_hand` is ever put right. Quantities are SIGNED: a positive
    /// one adds to the balance, a negative one takes it away, and neither is
    /// written onto the row directly. Each item is booked into the movements
    /// ledger as an `adjustment` and the balance follows, so a correction leaves a
    /// record of who changed what and why instead of a number that silently
    /// differs from yesterday's. A reason is mandatory unless
    /// movement_reason_required is 'none'.
    ///
    /// - Parameters:
    ///   - items: [RevenexxModels.InventoryAdjustItem] (optional)
    ///   - locationCode: String (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - reason: String (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesAdjust(
        items: [RevenexxModels.InventoryAdjustItem]? = nil,
        locationCode: String? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        reason: String? = nil,
        sku: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/adjust"

        let apiParams: [String: Any?] = [
            "items": items,
            "location_code": locationCode,
            "product_id": productId,
            "quantity": quantity,
            "reason": reason,
            "sku": sku
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
    /// THE stock call of this app, and a batch one: name any number of items and
    /// each comes back with `on_hand`, `reserved` and the derived `available`
    /// (their difference, computed on read and stored nowhere), summed across the
    /// locations in scope and broken down per location, plus `orderable` —
    /// whether this much of it can be promised at this moment. An item this app
    /// has never seen is NOT an error: it comes back tracked:false, and the
    /// storefront decides whether an untracked item sells freely. It is also the
    /// most customised surface this product has in the field. A tenant whose stock
    /// really lives in an ERP — SAP live stock is the ordinary case, not the
    /// exotic one — replaces exactly this one capability, 1:1, with a custom app
    /// through the gateway's capability override, while every other route here
    /// keeps doing the stock-keeping CRUD unchanged. That is why the request and
    /// response shapes below read as a contract to be implemented rather than as
    /// an implementation detail: whatever ends up answering this path has to
    /// answer in these terms.
    ///
    /// - Parameters:
    ///   - items: [RevenexxModels.InventoryAvailabilityItem] (optional)
    ///   - locationCode: String (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesAvailability(
        items: [RevenexxModels.InventoryAvailabilityItem]? = nil,
        locationCode: String? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        sku: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/availability"

        let apiParams: [String: Any?] = [
            "items": items,
            "location_code": locationCode,
            "product_id": productId,
            "quantity": quantity,
            "sku": sku
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
    /// The movements ledger, read end to end. Every stock change this app has ever
    /// made is a booking row in it — a receipt, a correction, a hold, a release,
    /// a shipment, a return — which is what lets one list be an audit trail and
    /// an event feed at the same time: these are the rows the
    /// `stock_movement.created` event carries, so a consumer that missed an event
    /// catches up by paging here. Append-only: the ledger has no update and no
    /// delete, because a correction is another booking. `order=created_at.desc` is
    /// the feed order.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - id: String (optional)
    ///   - locationId: String (optional)
    ///   - productId: String (optional)
    ///   - sku: String (optional)
    ///   - type: RevenexxEnums.InventoriesMovementsListType (optional)
    ///   - quantity: Double (optional)
    ///   - orderRef: String (optional)
    ///   - reason: String (optional)
    ///   - metadata: String (optional)
    ///   - createdAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesMovementsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        locationId: String? = nil,
        productId: String? = nil,
        sku: String? = nil,
        type: RevenexxEnums.InventoriesMovementsListType? = nil,
        quantity: Double? = nil,
        orderRef: String? = nil,
        reason: String? = nil,
        metadata: String? = nil,
        createdAt: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/movements"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "location_id": locationId,
            "product_id": productId,
            "sku": sku,
            "type": type,
            "quantity": quantity,
            "order_ref": orderRef,
            "reason": reason,
            "metadata": metadata,
            "created_at": createdAt
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
    /// A movement is one booking row in the ledger, and the ledger is append-only:
    /// there is no update and no delete, because a correction is another booking.
    /// `quantity` is SIGNED and its sign follows the `type` — a receipt books +5
    /// and the reserve that promises those goods books −5, even though the
    /// reservation it created carries +5 as a positive hold. GET
    /// /inventories/vocabularies/movement-types is the list of types with the
    /// words for them. A booking says what changed, not what the balance became:
    /// it carries no running total, so the row's story is read by listing the
    /// ledger for that location and item rather than by fetching one id.
    /// `location_id` is a plain uuid and not a foreign key, so a booking outlives
    /// the location it was made at and this route will happily hand back one whose
    /// location no longer resolves — that is the audit trail doing its job, not
    /// a broken row. Fixing a wrong booking is another booking (POST
    /// /inventories/adjust); nothing here can be edited or removed.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesMovementsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/movements/{id}"
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
    /// Books a delivery into the receiving location (the caller's location_code,
    /// else the default_location_code setting), creating the stock row if the item
    /// is new. A reason is optional unless movement_reason_required is 'all'.
    /// Takes a batch or one item inline.
    ///
    /// - Parameters:
    ///   - items: [RevenexxModels.InventoryStockItem] (optional)
    ///   - locationCode: String (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - reason: String (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesReceive(
        items: [RevenexxModels.InventoryStockItem]? = nil,
        locationCode: String? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        reason: String? = nil,
        sku: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/receive"

        let apiParams: [String: Any?] = [
            "items": items,
            "location_code": locationCode,
            "product_id": productId,
            "quantity": quantity,
            "reason": reason,
            "sku": sku
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
    /// The replenishment worklist: the stock rows that have run down far enough
    /// that somebody has to order more, in one list rather than as a query a
    /// caller has to build. Computed on read, so it is never stale: a row alerts
    /// when available (on_hand − reserved) has fallen to or below its own
    /// reorder_point, or the reorder_point_default setting when it carries none. A
    /// point of 0 never alerts. Answers enabled:false with an empty list when
    /// reorder_alert_enabled is off — a tenant replenishing from an ERP should
    /// not be told twice.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ReorderAlerts
    ///
    open func inventoriesReorderAlerts(
    ) async throws -> RevenexxModels.ReorderAlerts {
        let apiPath: String = "/v1/inventories/reorder-alerts"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ReorderAlerts = { response in
            return RevenexxModels.ReorderAlerts.from(map: response as! [String: Any])
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
    /// Publishes `stock_level.low` on the event bus for every row GET
    /// /inventories/reorder-alerts currently lists, so replenishment can be driven
    /// by a subscriber instead of by somebody refreshing that page. Also runs
    /// hourly as the `reorder-scan` schedule; this route is for driving it on
    /// demand. The event id is derived from the stock row and the day, so a re-run
    /// — a second click, a retried cron tick — publishes nothing new and
    /// returns the ids the first run produced. Nothing is written to the app's own
    /// data: this reads the same figures the alerts list computes and hands them
    /// to the bus. Answers enabled:false without publishing when
    /// reorder_alert_enabled is off.
    ///
    /// - Parameters:
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ReorderScan
    ///
    open func inventoriesReorderScan(
        data: Any
    ) async throws -> RevenexxModels.ReorderScan {
        let apiPath: String = "/v1/inventories/reorder-alerts/scan"

        let apiParams: [String: Any?] = [
            "data": data
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.ReorderScan = { response in
            return RevenexxModels.ReorderScan.from(map: response as! [String: Any])
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
    /// Whether a return rejoins sellable stock follows restock_on_return_default,
    /// overridable per call with 'restock'. When the answer is no the response
    /// says restocked:false and nothing moves — there is no movement to book,
    /// because no stock moved. That branch is why this route answers 200 and its
    /// sibling `receive` answers 201: a restock may legitimately create nothing.
    ///
    /// - Parameters:
    ///   - items: [RevenexxModels.InventoryStockItem] (optional)
    ///   - locationCode: String (optional)
    ///   - orderRef: String (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - reason: String (optional)
    ///   - restock: Bool (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesRestock(
        items: [RevenexxModels.InventoryStockItem]? = nil,
        locationCode: String? = nil,
        orderRef: String? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        reason: String? = nil,
        restock: Bool? = nil,
        sku: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/restock"

        let apiParams: [String: Any?] = [
            "items": items,
            "location_code": locationCode,
            "order_ref": orderRef,
            "product_id": productId,
            "quantity": quantity,
            "reason": reason,
            "restock": restock,
            "sku": sku
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
    /// A stock level is ONE item at ONE location, and it carries two numbers,
    /// neither of which is the sellable one: `on_hand` is what is physically there
    /// INCLUDING everything already promised, and `reserved` is what has been
    /// promised — it never reduces `on_hand`. What may still be sold is their
    /// difference, and it is derived on read and never stored, so there is no
    /// `available` column to read, filter or order by. This is the operator's view
    /// — the whole book, filtered by location or by item — not the shop's: a
    /// storefront asking "can I sell five of this" wants POST
    /// /inventories/availability, which sums an item across locations and answers
    /// `orderable` instead of leaving the caller to subtract. Two things this list
    /// will not do: it has no range filters, so "everything running low" is GET
    /// /inventories/reorder-alerts and not a query here; and it does not promise
    /// one row per item per location — no unique index enforces that. POST
    /// /inventories/stock refuses a duplicate with a 409, but that is a check and
    /// not a constraint, so a row written past it, or one that predates the guard,
    /// still splits an item's balance in two, and the write routes find and update
    /// whichever of them the database returns first.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - id: String (optional)
    ///   - locationId: String (optional)
    ///   - productId: String (optional)
    ///   - sku: String (optional)
    ///   - onHand: Double (optional)
    ///   - reserved: Double (optional)
    ///   - reorderPoint: Double (optional)
    ///   - metadata: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesStockList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        locationId: String? = nil,
        productId: String? = nil,
        sku: String? = nil,
        onHand: Double? = nil,
        reserved: Double? = nil,
        reorderPoint: Double? = nil,
        metadata: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/stock"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "location_id": locationId,
            "product_id": productId,
            "sku": sku,
            "on_hand": onHand,
            "reserved": reserved,
            "reorder_point": reorderPoint,
            "metadata": metadata,
            "created_at": createdAt,
            "updated_at": updatedAt
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
    /// Registers an item at a location. The row is born at ZERO and never gets a
    /// balance from this call: `on_hand` and `reserved` are NOT accepted, because
    /// they are the running total of the movements ledger, so an opening balance
    /// is a receipt (POST /inventories/receive) rather than a field here, and the
    /// only thing that ever moves either number afterwards is another booking.
    /// What this row carries is its identity (location + `product_id`/`sku`), its
    /// `reorder_point` and its metadata. `location_id` is the only field a create
    /// cannot omit; every other column is optional or defaulted by the database.
    /// The one rule that is a CHECK rather than a column is that a row has to
    /// identify its item, so `product_id` or `sku` has to be there as well. Mostly
    /// you do not need this route at all — every stock call creates the row it
    /// is missing — and a second row for an item this location already tracks is
    /// answered 409: no unique index enforces one row per item per location, so
    /// that row would split the item's balance across two rows the write routes
    /// cannot tell apart, each of them updating whichever the database returns
    /// first. That guard is a check before the insert and not a constraint, so it
    /// closes a double click or a re-run import and does not claim to close a race
    /// between two simultaneous creates.
    ///
    /// - Parameters:
    ///   - locationId: String
    ///   - metadata: Any (optional)
    ///   - productId: String (optional)
    ///   - reorderPoint: Double (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesStockCreate(
        locationId: String,
        metadata: Any? = nil,
        productId: String? = nil,
        reorderPoint: Double? = nil,
        sku: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/stock"

        let apiParams: [String: Any?] = [
            "location_id": locationId,
            "metadata": metadata,
            "product_id": productId,
            "reorder_point": reorderPoint,
            "sku": sku
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
    /// Stops tracking one item at one location. A stock level is ONE item at ONE
    /// location, and it carries two numbers, neither of which is the sellable one:
    /// `on_hand` is what is physically there INCLUDING everything already
    /// promised, and `reserved` is what has been promised — it never reduces
    /// `on_hand`. What may still be sold is their difference, and it is derived on
    /// read and never stored, so there is no `available` column to read, filter or
    /// order by. A deleted balance is not recoverable: the ledger is the audit
    /// trail, not the source of truth, and nothing in this app ever replays it to
    /// rebuild a number — so the next receipt for the same item here creates a
    /// FRESH row at zero, standing next to movements that say otherwise. That used
    /// to be a trap a caller discovered afterwards. It is a stated property now,
    /// because the route REFUSES while the row still holds anything, and answers
    /// 409 with what it holds. The two things that block are the location delete's
    /// two, asked of one row. A reservation still `active` against this item at
    /// this location is the sharper one: /release and /commit look their stock row
    /// up by (location, item) on the very next call and would find nothing, so the
    /// hold would lower no `reserved` and /commit would book the whole quantity as
    /// a shortfall — orphaned immediately rather than eventually. `on_hand`
    /// above zero is the stronger one: deleting a LOCATION at least meant "close
    /// this warehouse" and took the balances as a side effect of the cascade,
    /// while this row IS the balance, so the delete can only ever mean "no longer
    /// tracked here" — true once the number is zero and a lie while it is not.
    /// POST /inventories/stock/{id}/adjust to zero is the operation that makes it
    /// true, and it BOOKS the movement, so the stock leaves through the ledger
    /// instead of vanishing with the row. Nothing points at it by foreign key, so
    /// the database takes nothing else with it. History therefore never blocks and
    /// is never deleted — the ledger is keyed on (location, item) and never on
    /// this id, so its bookings survive a row that is gone, BY DESIGN, exactly as
    /// they survive a location that is gone.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesStockDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/stock/{id}"
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
    /// A stock level is ONE item at ONE location, and it carries two numbers,
    /// neither of which is the sellable one: `on_hand` is what is physically there
    /// INCLUDING everything already promised, and `reserved` is what has been
    /// promised — it never reduces `on_hand`. What may still be sold is their
    /// difference, and it is derived on read and never stored, so there is no
    /// `available` column to read, filter or order by. Read it to see one item's
    /// position at one place, and to get the id the two row-scoped routes take:
    /// POST /inventories/stock/{id}/adjust corrects this balance, and GET
    /// /inventories/reorder-alerts reports it by this id. What it does not answer
    /// is how the balance got here — that is GET /inventories/movements filtered
    /// by the location and item on this row, because a movement points at
    /// (location, item) and never at a stock row id.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesStockGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/stock/{id}"
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
    /// Partial update of everything on the row EXCEPT its balance: reorder_point,
    /// metadata, identity. on_hand and reserved are dropped from the body —
    /// every stock change is a movement, and a body carrying nothing else is
    /// answered 422 with the route that was meant (POST
    /// /inventories/stock/{id}/adjust).
    ///
    /// - Parameters:
    ///   - id: String
    ///   - locationId: String (optional)
    ///   - metadata: Any (optional)
    ///   - productId: String (optional)
    ///   - reorderPoint: Double (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesStockUpdate(
        id: String,
        locationId: String? = nil,
        metadata: Any? = nil,
        productId: String? = nil,
        reorderPoint: Double? = nil,
        sku: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/stock/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "location_id": locationId,
            "metadata": metadata,
            "product_id": productId,
            "reorder_point": reorderPoint,
            "sku": sku
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
    /// Corrects the balance of ONE stock row, and only that one. It is the
    /// row-scoped twin of POST /inventories/adjust: the row already knows its
    /// location and item, so a caller owes nothing but a SIGNED delta on `on_hand`
    /// — positive to add, negative to take away — and a reason for it. The
    /// delta is not written onto the balance either; it is booked into the
    /// movements ledger as an `adjustment` and the balance follows, which is why
    /// the answer hands back the row at its new value instead of an
    /// acknowledgement. This is the route that replaced the Cockpit's editable
    /// on_hand field.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - quantity: Double
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesStockAdjust(
        id: String,
        quantity: Double,
        reason: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/stock/{id}/adjust"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "quantity": quantity,
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
    /// Discovery for the vocabulary routes: the enums this app publishes, each
    /// with its name, its title and its description and deliberately WITHOUT its
    /// values, so finding out what exists costs one small call and not one per
    /// vocabulary. Names: location-types, movement-types, reservation-statuses.
    /// Fetch one with GET /inventories/vocabularies/{name}; a client holding the
    /// qualified pair 'inventories.<name>' builds that URL from the pair alone.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.InventoryVocabularyIndex
    ///
    open func inventoriesVocabulariesList(
    ) async throws -> RevenexxModels.InventoryVocabularyIndex {
        let apiPath: String = "/v1/inventories/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.InventoryVocabularyIndex = { response in
            return RevenexxModels.InventoryVocabularyIndex.from(map: response as! [String: Any])
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
    /// One vocabulary in full: every permitted value, each carrying the title and
    /// description a person reads for it and the badge tone a UI colours it with,
    /// so a client renders a status or a movement type without a hard-coded table
    /// of its own. The values are read out of the column's CHECK constraint, so
    /// the served set IS the enforced set and the two cannot drift — a value
    /// added to the constraint appears here even before anyone labels it, titled
    /// from its own key. Values come back in constraint order, which is lifecycle
    /// order for a status. 'closed' says the set is exhaustive, so a value outside
    /// it is stale data rather than a missing label. Names: location-types,
    /// movement-types, reservation-statuses.
    ///
    /// - Parameters:
    ///   - name: RevenexxEnums.InventoriesVocabulariesGetName
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesVocabulariesGet(
        name: RevenexxEnums.InventoriesVocabulariesGetName
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/vocabularies/{name}"
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


}