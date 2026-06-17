import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Prices: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pricesListsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/prices/lists"

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
    ///   - channelId: String (optional)
    ///   - contactId: String (optional)
    ///   - currency: String (optional)
    ///   - description: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - marketId: String (optional)
    ///   - metadata: Any (optional)
    ///   - organizationId: String (optional)
    ///   - priority: Int (optional)
    ///   - status: Revenexx API — revenexxEnums.PriceListStatus (optional)
    ///   - taxIncluded: Bool (optional)
    ///   - validFrom: String (optional)
    ///   - validUntil: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PriceList
    ///
    open func pricesListsCreate(
        code: String,
        name: String,
        channelId: String? = nil,
        contactId: String? = nil,
        currency: String? = nil,
        description: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        marketId: String? = nil,
        metadata: Any? = nil,
        organizationId: String? = nil,
        priority: Int? = nil,
        status: Revenexx API — revenexxEnums.PriceListStatus? = nil,
        taxIncluded: Bool? = nil,
        validFrom: String? = nil,
        validUntil: String? = nil
    ) async throws -> Revenexx API — revenexxModels.PriceList {
        let apiPath: String = "/v1/prices/lists"

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "code": code,
            "contact_id": contactId,
            "currency": currency,
            "description": description,
            "is_default": isDefault,
            "labels": labels,
            "market_id": marketId,
            "metadata": metadata,
            "name": name,
            "organization_id": organizationId,
            "priority": priority,
            "status": status,
            "tax_included": taxIncluded,
            "valid_from": validFrom,
            "valid_until": validUntil
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.PriceList = { response in
            return RevenexxAPIRevenexxModels.PriceList.from(map: response as! [String: Any])
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
    open func pricesListsDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/prices/lists/defaults"

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
    open func pricesListsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/prices/lists/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.PriceList
    ///
    open func pricesListsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.PriceList {
        let apiPath: String = "/v1/prices/lists/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.PriceList = { response in
            return RevenexxAPIRevenexxModels.PriceList.from(map: response as! [String: Any])
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
    ///   - channelId: String (optional)
    ///   - code: String (optional)
    ///   - contactId: String (optional)
    ///   - currency: String (optional)
    ///   - description: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - marketId: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - organizationId: String (optional)
    ///   - priority: Int (optional)
    ///   - status: Revenexx API — revenexxEnums.PriceListStatus (optional)
    ///   - taxIncluded: Bool (optional)
    ///   - validFrom: String (optional)
    ///   - validUntil: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PriceList
    ///
    open func pricesListsUpdate(
        id: String,
        channelId: String? = nil,
        code: String? = nil,
        contactId: String? = nil,
        currency: String? = nil,
        description: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        marketId: String? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        organizationId: String? = nil,
        priority: Int? = nil,
        status: Revenexx API — revenexxEnums.PriceListStatus? = nil,
        taxIncluded: Bool? = nil,
        validFrom: String? = nil,
        validUntil: String? = nil
    ) async throws -> Revenexx API — revenexxModels.PriceList {
        let apiPath: String = "/v1/prices/lists/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "code": code,
            "contact_id": contactId,
            "currency": currency,
            "description": description,
            "is_default": isDefault,
            "labels": labels,
            "market_id": marketId,
            "metadata": metadata,
            "name": name,
            "organization_id": organizationId,
            "priority": priority,
            "status": status,
            "tax_included": taxIncluded,
            "valid_from": validFrom,
            "valid_until": validUntil
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.PriceList = { response in
            return RevenexxAPIRevenexxModels.PriceList.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - listId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pricesEntriesList(
        listId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/prices/lists/{list_id}/entries"
            .replacingOccurrences(of: "{listId}", with: listId)

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
    ///   - listId: String
    ///   - metadata: Any (optional)
    ///   - priceType: Revenexx API — revenexxEnums.PriceEntryType (optional)
    ///   - productId: String (optional)
    ///   - quantityMin: Double (optional)
    ///   - sku: String (optional)
    ///   - unit: String (optional)
    ///   - unitPrice: Double (optional)
    ///   - validFrom: String (optional)
    ///   - validUntil: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PriceEntry
    ///
    open func pricesEntriesCreate(
        listId: String,
        metadata: Any? = nil,
        priceType: Revenexx API — revenexxEnums.PriceEntryType? = nil,
        productId: String? = nil,
        quantityMin: Double? = nil,
        sku: String? = nil,
        unit: String? = nil,
        unitPrice: Double? = nil,
        validFrom: String? = nil,
        validUntil: String? = nil
    ) async throws -> Revenexx API — revenexxModels.PriceEntry {
        let apiPath: String = "/v1/prices/lists/{list_id}/entries"
            .replacingOccurrences(of: "{listId}", with: listId)

        let apiParams: [String: Any?] = [
            "metadata": metadata,
            "price_type": priceType,
            "product_id": productId,
            "quantity_min": quantityMin,
            "sku": sku,
            "unit": unit,
            "unit_price": unitPrice,
            "valid_from": validFrom,
            "valid_until": validUntil
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.PriceEntry = { response in
            return RevenexxAPIRevenexxModels.PriceEntry.from(map: response as! [String: Any])
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
    ///   - listId: String
    ///   - entries: [Revenexx API — revenexxModels.PriceEntryReplaceItem]
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pricesEntriesReplace(
        listId: String,
        entries: [Revenexx API — revenexxModels.PriceEntryReplaceItem]
    ) async throws -> Any {
        let apiPath: String = "/v1/prices/lists/{list_id}/entries"
            .replacingOccurrences(of: "{listId}", with: listId)

        let apiParams: [String: Any?] = [
            "entries": entries
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - listId: String
    ///   - entries: [Revenexx API — revenexxModels.PriceEntryReplaceItem]
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pricesEntriesBulk(
        listId: String,
        entries: [Revenexx API — revenexxModels.PriceEntryReplaceItem]
    ) async throws -> Any {
        let apiPath: String = "/v1/prices/lists/{list_id}/entries/bulk"
            .replacingOccurrences(of: "{listId}", with: listId)

        let apiParams: [String: Any?] = [
            "entries": entries
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
    ///   - listId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pricesEntriesDelete(
        listId: String,
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/prices/lists/{list_id}/entries/{id}"
            .replacingOccurrences(of: "{listId}", with: listId)
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
    ///   - listId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PriceEntry
    ///
    open func pricesEntriesGet(
        listId: String,
        id: String
    ) async throws -> Revenexx API — revenexxModels.PriceEntry {
        let apiPath: String = "/v1/prices/lists/{list_id}/entries/{id}"
            .replacingOccurrences(of: "{listId}", with: listId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.PriceEntry = { response in
            return RevenexxAPIRevenexxModels.PriceEntry.from(map: response as! [String: Any])
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
    ///   - listId: String
    ///   - id: String
    ///   - metadata: Any (optional)
    ///   - priceType: Revenexx API — revenexxEnums.PriceEntryType (optional)
    ///   - productId: String (optional)
    ///   - quantityMin: Double (optional)
    ///   - sku: String (optional)
    ///   - unit: String (optional)
    ///   - unitPrice: Double (optional)
    ///   - validFrom: String (optional)
    ///   - validUntil: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PriceEntry
    ///
    open func pricesEntriesUpdate(
        listId: String,
        id: String,
        metadata: Any? = nil,
        priceType: Revenexx API — revenexxEnums.PriceEntryType? = nil,
        productId: String? = nil,
        quantityMin: Double? = nil,
        sku: String? = nil,
        unit: String? = nil,
        unitPrice: Double? = nil,
        validFrom: String? = nil,
        validUntil: String? = nil
    ) async throws -> Revenexx API — revenexxModels.PriceEntry {
        let apiPath: String = "/v1/prices/lists/{list_id}/entries/{id}"
            .replacingOccurrences(of: "{listId}", with: listId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "metadata": metadata,
            "price_type": priceType,
            "product_id": productId,
            "quantity_min": quantityMin,
            "sku": sku,
            "unit": unit,
            "unit_price": unitPrice,
            "valid_from": validFrom,
            "valid_until": validUntil
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.PriceEntry = { response in
            return RevenexxAPIRevenexxModels.PriceEntry.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - items: [Revenexx API — revenexxModels.PriceResolveItem]
    ///   - at: String (optional)
    ///   - channelId: String (optional)
    ///   - contactId: String (optional)
    ///   - currency: String (optional)
    ///   - marketId: String (optional)
    ///   - organizationId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pricesResolve(
        items: [Revenexx API — revenexxModels.PriceResolveItem],
        at: String? = nil,
        channelId: String? = nil,
        contactId: String? = nil,
        currency: String? = nil,
        marketId: String? = nil,
        organizationId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/prices/resolve"

        let apiParams: [String: Any?] = [
            "at": at,
            "channel_id": channelId,
            "contact_id": contactId,
            "currency": currency,
            "items": items,
            "market_id": marketId,
            "organization_id": organizationId
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


}