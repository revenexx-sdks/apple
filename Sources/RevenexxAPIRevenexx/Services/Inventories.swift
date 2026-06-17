import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Inventories: Service {

    ///
    /// - Parameters:
    ///   - items: [Revenexx API — revenexxModels.InventoryAdjustItem]
    ///   - reason: String
    ///   - locationCode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesAdjust(
        items: [Revenexx API — revenexxModels.InventoryAdjustItem],
        reason: String,
        locationCode: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/adjust"

        let apiParams: [String: Any?] = [
            "items": items,
            "location_code": locationCode,
            "reason": reason
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - items: [Revenexx API — revenexxModels.InventoryAvailabilityItem]
    ///   - locationCode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesAvailability(
        items: [Revenexx API — revenexxModels.InventoryAvailabilityItem],
        locationCode: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/availability"

        let apiParams: [String: Any?] = [
            "items": items,
            "location_code": locationCode
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - orderRef: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesCommit(
        orderRef: String
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/commit"

        let apiParams: [String: Any?] = [
            "order_ref": orderRef
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesLocationsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/locations"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - code: String
    ///   - name: String
    ///   - address: Any (optional)
    ///   - enabled: Bool (optional)
    ///   - labels: Any (optional)
    ///   - metadata: Any (optional)
    ///   - priority: Int (optional)
    ///   - type: Revenexx API — revenexxEnums.LocationType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Location
    ///
    open func inventoriesLocationsCreate(
        code: String,
        name: String,
        address: Any? = nil,
        enabled: Bool? = nil,
        labels: Any? = nil,
        metadata: Any? = nil,
        priority: Int? = nil,
        type: Revenexx API — revenexxEnums.LocationType? = nil
    ) async throws -> Revenexx API — revenexxModels.Location {
        let apiPath: String = "/v1/inventories/locations"

        let apiParams: [String: Any?] = [
            "address": address,
            "code": code,
            "enabled": enabled,
            "labels": labels,
            "metadata": metadata,
            "name": name,
            "priority": priority,
            "type": type
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Location = { response in
            return RevenexxAPIRevenexxModels.Location.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesLocationsDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/locations/defaults"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesLocationsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/locations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Location
    ///
    open func inventoriesLocationsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Location {
        let apiPath: String = "/v1/inventories/locations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Location = { response in
            return RevenexxAPIRevenexxModels.Location.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    ///   - address: Any (optional)
    ///   - code: String (optional)
    ///   - enabled: Bool (optional)
    ///   - labels: Any (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - priority: Int (optional)
    ///   - type: Revenexx API — revenexxEnums.LocationType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Location
    ///
    open func inventoriesLocationsUpdate(
        id: String,
        address: Any? = nil,
        code: String? = nil,
        enabled: Bool? = nil,
        labels: Any? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        priority: Int? = nil,
        type: Revenexx API — revenexxEnums.LocationType? = nil
    ) async throws -> Revenexx API — revenexxModels.Location {
        let apiPath: String = "/v1/inventories/locations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "address": address,
            "code": code,
            "enabled": enabled,
            "labels": labels,
            "metadata": metadata,
            "name": name,
            "priority": priority,
            "type": type
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Location = { response in
            return RevenexxAPIRevenexxModels.Location.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesMovementsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/movements"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.StockMovement
    ///
    open func inventoriesMovementsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.StockMovement {
        let apiPath: String = "/v1/inventories/movements/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.StockMovement = { response in
            return RevenexxAPIRevenexxModels.StockMovement.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - items: [Revenexx API — revenexxModels.InventoryStockItem]
    ///   - locationCode: String (optional)
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesReceive(
        items: [Revenexx API — revenexxModels.InventoryStockItem],
        locationCode: String? = nil,
        reason: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/receive"

        let apiParams: [String: Any?] = [
            "items": items,
            "location_code": locationCode,
            "reason": reason
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - orderRef: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesRelease(
        orderRef: String
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/release"

        let apiParams: [String: Any?] = [
            "order_ref": orderRef
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesReservationsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/reservations"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Reservation
    ///
    open func inventoriesReservationsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Reservation {
        let apiPath: String = "/v1/inventories/reservations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Reservation = { response in
            return RevenexxAPIRevenexxModels.Reservation.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - items: [Revenexx API — revenexxModels.InventoryStockItem]
    ///   - orderRef: String
    ///   - expiresAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesReserve(
        items: [Revenexx API — revenexxModels.InventoryStockItem],
        orderRef: String,
        expiresAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/reserve"

        let apiParams: [String: Any?] = [
            "expires_at": expiresAt,
            "items": items,
            "order_ref": orderRef
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - items: [Revenexx API — revenexxModels.InventoryStockItem]
    ///   - locationCode: String (optional)
    ///   - orderRef: String (optional)
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesRestock(
        items: [Revenexx API — revenexxModels.InventoryStockItem],
        locationCode: String? = nil,
        orderRef: String? = nil,
        reason: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/restock"

        let apiParams: [String: Any?] = [
            "items": items,
            "location_code": locationCode,
            "order_ref": orderRef,
            "reason": reason
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesStockList(
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/stock"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - locationId: String
    ///   - metadata: Any (optional)
    ///   - onHand: Double (optional)
    ///   - productId: String (optional)
    ///   - reorderPoint: Double (optional)
    ///   - reserved: Double (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.StockLevel
    ///
    open func inventoriesStockCreate(
        locationId: String,
        metadata: Any? = nil,
        onHand: Double? = nil,
        productId: String? = nil,
        reorderPoint: Double? = nil,
        reserved: Double? = nil,
        sku: String? = nil
    ) async throws -> Revenexx API — revenexxModels.StockLevel {
        let apiPath: String = "/v1/inventories/stock"

        let apiParams: [String: Any?] = [
            "location_id": locationId,
            "metadata": metadata,
            "on_hand": onHand,
            "product_id": productId,
            "reorder_point": reorderPoint,
            "reserved": reserved,
            "sku": sku
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.StockLevel = { response in
            return RevenexxAPIRevenexxModels.StockLevel.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func inventoriesStockDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/inventories/stock/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.StockLevel
    ///
    open func inventoriesStockGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.StockLevel {
        let apiPath: String = "/v1/inventories/stock/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.StockLevel = { response in
            return RevenexxAPIRevenexxModels.StockLevel.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    ///   - locationId: String (optional)
    ///   - metadata: Any (optional)
    ///   - onHand: Double (optional)
    ///   - productId: String (optional)
    ///   - reorderPoint: Double (optional)
    ///   - reserved: Double (optional)
    ///   - sku: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.StockLevel
    ///
    open func inventoriesStockUpdate(
        id: String,
        locationId: String? = nil,
        metadata: Any? = nil,
        onHand: Double? = nil,
        productId: String? = nil,
        reorderPoint: Double? = nil,
        reserved: Double? = nil,
        sku: String? = nil
    ) async throws -> Revenexx API — revenexxModels.StockLevel {
        let apiPath: String = "/v1/inventories/stock/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "location_id": locationId,
            "metadata": metadata,
            "on_hand": onHand,
            "product_id": productId,
            "reorder_point": reorderPoint,
            "reserved": reserved,
            "sku": sku
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.StockLevel = { response in
            return RevenexxAPIRevenexxModels.StockLevel.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}