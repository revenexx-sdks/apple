import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Stock promised to an order, and the three ways that promise ends. A reservation is order-scoped: POST /inventories/reserve creates it against an `order_ref`, and nothing else does — there is no create, update or delete route here, because the lifecycle IS the API. Reserving raises `reserved` on a stock row and leaves `on_hand` alone (the goods are still in the building); committing ships them and takes them out of both; releasing gives them back; and the sweep is a release on a timer, for the checkouts nobody finished. `reserved` is the only reason a stock row's two numbers ever differ, which is what makes this a group and not a footnote to the stock one. Which location a hold lands at is not decided here — that is the tenant's allocation strategy choosing between locations, and it is described with them.
open class InventoriesReservations: Service {

    ///
    /// Call this when the goods leave the building, and not before. Reserving only
    /// promised them — `reserved` went up and `on_hand` did not move, because
    /// the stock was still on the shelf; committing is the moment they are gone,
    /// so it lowers BOTH on each stock row and writes one `shipment` booking per
    /// hold, with a SIGNED negative quantity, as the ledger's record that they
    /// left. It takes the whole `order_ref` and every hold still active on it:
    /// there is no partial commit and no per-line id, so a part shipment means
    /// reserving the parts separately in the first place. It is also final —
    /// 'committed' ends the lifecycle and nothing moves a hold out of it, so goods
    /// coming back are POST /inventories/restock (a new receipt), never an undo of
    /// this. An order with nothing active is a 422 rather than a quiet zero,
    /// because it means the hold was already released or already shipped; /release
    /// answers the same situation with a 200 on purpose, since cancelling twice is
    /// harmless and shipping twice is not.
    ///
    /// - Parameters:
    ///   - orderRef: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesCommit(
        orderRef: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/commit"

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
    /// The cancellation end of the reserve → commit | release lifecycle: it
    /// takes an `order_ref`, ends every hold still active on it, gives the stock
    /// back and writes a 'release' booking for each one, exactly like the expiry
    /// sweeper. Idempotent: an order with nothing active answers released:0 —
    /// which is why it is a 200 and not the 422 commit answers.
    ///
    /// - Parameters:
    ///   - orderRef: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesRelease(
        orderRef: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/release"

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
    /// A reservation is stock promised to an `order_ref`. It is created only by
    /// POST /inventories/reserve and moved only by /commit, /release and the
    /// expiry sweep — there is no create, update or delete route, because the
    /// lifecycle IS the API. Only an 'active' hold counts towards a stock row's
    /// `reserved`; 'released' and 'committed' rows stay for the audit trail and
    /// hold nothing. This is the answer to "what is this order actually holding"
    /// (`?order_ref=…`) and to "what is holding this stock"
    /// (`?status=active&location_id=…`) — the second is the only way to see
    /// WHY a row's `reserved` is what it is, since a stock row reports the total
    /// and never who asked for it. `expires_at` filters on an exact timestamp and
    /// not a range, so this cannot answer "what expires today"; the deadline is
    /// acted on by POST /inventories/reservations/sweep, not by reading it here.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - id: String (optional)
    ///   - locationId: String (optional)
    ///   - productId: String (optional)
    ///   - sku: String (optional)
    ///   - quantity: Double (optional)
    ///   - orderRef: String (optional)
    ///   - status: RevenexxEnums.InventoriesReservationsListStatus (optional)
    ///   - expiresAt: String (optional)
    ///   - metadata: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesReservationsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        locationId: String? = nil,
        productId: String? = nil,
        sku: String? = nil,
        quantity: Double? = nil,
        orderRef: String? = nil,
        status: RevenexxEnums.InventoriesReservationsListStatus? = nil,
        expiresAt: String? = nil,
        metadata: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/reservations"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "location_id": locationId,
            "product_id": productId,
            "sku": sku,
            "quantity": quantity,
            "order_ref": orderRef,
            "status": status,
            "expires_at": expiresAt,
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
    /// The expiry sweeper, also run by the 'expire-reservations' schedule every 15
    /// minutes. Releases reservations past their own expires_at and — once
    /// reservation_ttl_minutes is above 0 — reservations older than that
    /// lifetime which never carried a deadline. Each release gives the stock back
    /// and writes a 'release' booking, exactly like a cancellation. Idempotent: a
    /// second run finds nothing.
    ///
    /// - Parameters:
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ReservationSweepResult
    ///
    open func inventoriesReservationsSweep(
        data: Any
    ) async throws -> RevenexxModels.ReservationSweepResult {
        let apiPath: String = "/v1/inventories/reservations/sweep"

        let apiParams: [String: Any?] = [
            "data": data
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.ReservationSweepResult = { response in
            return RevenexxModels.ReservationSweepResult.from(map: response as! [String: Any])
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
    /// A reservation is stock promised to an `order_ref`. It is created only by
    /// POST /inventories/reserve and moved only by /commit, /release and the
    /// expiry sweep — there is no create, update or delete route, because the
    /// lifecycle IS the API. Only an 'active' hold counts towards a stock row's
    /// `reserved`; 'released' and 'committed' rows stay for the audit trail and
    /// hold nothing. One hold, with the three facts that are not on the order it
    /// belongs to: which location it was allocated to, when it expires, and — in
    /// `metadata.backordered` — how much of it was never covered by stock, which
    /// is how a promise made under a permissive backorder policy stays visible
    /// afterwards. The id is for reading only. Every transition acts on the whole
    /// `order_ref` (/commit, /release, the sweep), so there is no route that takes
    /// this id and no way to release one line of an order on its own.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesReservationsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/reservations/{id}"
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
    /// Takes a hold against an `order_ref`, and plans the whole call before
    /// writing anything, so a reservation that cannot be satisfied changes
    /// nothing. WHICH location serves an item is not the caller's to choose: the
    /// tenant's allocation_strategy decides it ('priority', walking the enabled
    /// locations by their priority; 'nearest', matching ship_to against a
    /// location's country; or 'single_location' for the whole order);
    /// backorder_policy decides what happens when none can — refuse (422), or
    /// reserve anyway and let availability go negative. expires_at defaults from
    /// reservation_ttl_minutes and the sweeper enforces it.
    ///
    /// - Parameters:
    ///   - orderRef: String
    ///   - expiresAt: String (optional)
    ///   - items: [RevenexxModels.InventoryStockItem] (optional)
    ///   - locationCode: String (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - shipTo: Any (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func inventoriesReserve(
        orderRef: String,
        expiresAt: String? = nil,
        items: [RevenexxModels.InventoryStockItem]? = nil,
        locationCode: String? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        shipTo: Any? = nil,
        sku: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/inventories/reserve"

        let apiParams: [String: Any?] = [
            "expires_at": expiresAt,
            "items": items,
            "location_code": locationCode,
            "order_ref": orderRef,
            "product_id": productId,
            "quantity": quantity,
            "ship_to": shipTo,
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


}