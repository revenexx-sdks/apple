import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Carts: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/carts"

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
    ///   - channelId: String (optional)
    ///   - contactId: String (optional)
    ///   - currency: String (optional)
    ///   - isCurrent: Bool (optional)
    ///   - marketId: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - sessionKey: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Cart
    ///
    open func cartsCreate(
        channelId: String? = nil,
        contactId: String? = nil,
        currency: String? = nil,
        isCurrent: Bool? = nil,
        marketId: String? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        sessionKey: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Cart {
        let apiPath: String = "/v1/carts"

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "contact_id": contactId,
            "currency": currency,
            "is_current": isCurrent,
            "market_id": marketId,
            "metadata": metadata,
            "name": name,
            "session_key": sessionKey
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Cart = { response in
            return RevenexxAPIRevenexxModels.Cart.from(map: response as! [String: Any])
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
    ///   - contactId: String
    ///   - sessionKey: String
    ///   - targetCartId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsClaim(
        contactId: String,
        sessionKey: String,
        targetCartId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/claim"

        let apiParams: [String: Any?] = [
            "contact_id": contactId,
            "session_key": sessionKey,
            "target_cart_id": targetCartId
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
    ///   - contactId: String (optional)
    ///   - csv: String (optional)
    ///   - name: String (optional)
    ///   - payload: Any (optional)
    ///   - profileId: String (optional)
    ///   - sessionKey: String (optional)
    ///   - targetCartId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsImport(
        contactId: String? = nil,
        csv: String? = nil,
        name: String? = nil,
        payload: Any? = nil,
        profileId: String? = nil,
        sessionKey: String? = nil,
        targetCartId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/import"

        let apiParams: [String: Any?] = [
            "contact_id": contactId,
            "csv": csv,
            "name": name,
            "payload": payload,
            "profile_id": profileId,
            "session_key": sessionKey,
            "target_cart_id": targetCartId
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
    open func cartsIoProfilesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/io/profiles"

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
    ///   - direction: Revenexx API — revenexxEnums.CartIoDirection
    ///   - name: String
    ///   - applyMode: Revenexx API — revenexxEnums.CartIoApplyMode (optional)
    ///   - entity: Revenexx API — revenexxEnums.CartIoEntity (optional)
    ///   - format: Revenexx API — revenexxEnums.CartIoFormat (optional)
    ///   - isTemplate: Bool (optional)
    ///   - mapping: Any (optional)
    ///   - options: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.IoProfile
    ///
    open func cartsIoProfilesCreate(
        direction: Revenexx API — revenexxEnums.CartIoDirection,
        name: String,
        applyMode: Revenexx API — revenexxEnums.CartIoApplyMode? = nil,
        entity: Revenexx API — revenexxEnums.CartIoEntity? = nil,
        format: Revenexx API — revenexxEnums.CartIoFormat? = nil,
        isTemplate: Bool? = nil,
        mapping: Any? = nil,
        options: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.IoProfile {
        let apiPath: String = "/v1/carts/io/profiles"

        let apiParams: [String: Any?] = [
            "apply_mode": applyMode,
            "direction": direction,
            "entity": entity,
            "format": format,
            "is_template": isTemplate,
            "mapping": mapping,
            "name": name,
            "options": options
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.IoProfile = { response in
            return RevenexxAPIRevenexxModels.IoProfile.from(map: response as! [String: Any])
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
    open func cartsIoProfilesDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/io/profiles/defaults"

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
    open func cartsIoProfilesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/io/profiles/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.IoProfile
    ///
    open func cartsIoProfilesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.IoProfile {
        let apiPath: String = "/v1/carts/io/profiles/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.IoProfile = { response in
            return RevenexxAPIRevenexxModels.IoProfile.from(map: response as! [String: Any])
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
    ///   - applyMode: Revenexx API — revenexxEnums.CartIoApplyMode (optional)
    ///   - direction: Revenexx API — revenexxEnums.CartIoDirection (optional)
    ///   - entity: Revenexx API — revenexxEnums.CartIoEntity (optional)
    ///   - format: Revenexx API — revenexxEnums.CartIoFormat (optional)
    ///   - isTemplate: Bool (optional)
    ///   - mapping: Any (optional)
    ///   - name: String (optional)
    ///   - options: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.IoProfile
    ///
    open func cartsIoProfilesUpdate(
        id: String,
        applyMode: Revenexx API — revenexxEnums.CartIoApplyMode? = nil,
        direction: Revenexx API — revenexxEnums.CartIoDirection? = nil,
        entity: Revenexx API — revenexxEnums.CartIoEntity? = nil,
        format: Revenexx API — revenexxEnums.CartIoFormat? = nil,
        isTemplate: Bool? = nil,
        mapping: Any? = nil,
        name: String? = nil,
        options: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.IoProfile {
        let apiPath: String = "/v1/carts/io/profiles/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "apply_mode": applyMode,
            "direction": direction,
            "entity": entity,
            "format": format,
            "is_template": isTemplate,
            "mapping": mapping,
            "name": name,
            "options": options
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.IoProfile = { response in
            return RevenexxAPIRevenexxModels.IoProfile.from(map: response as! [String: Any])
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
    ///   - sourceCartId: String
    ///   - targetCartId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsMerge(
        sourceCartId: String,
        targetCartId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/merge"

        let apiParams: [String: Any?] = [
            "source_cart_id": sourceCartId,
            "target_cart_id": targetCartId
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
    ///   - cartId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsItemsList(
        cartId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/{cart_id}/items"
            .replacingOccurrences(of: "{cartId}", with: cartId)

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
    ///   - cartId: String
    ///   - configuration: Any (optional)
    ///   - currency: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - sku: String (optional)
    ///   - snapshot: Any (optional)
    ///   - taxRate: Double (optional)
    ///   - type: Revenexx API — revenexxEnums.CartItemType (optional)
    ///   - unit: String (optional)
    ///   - unitPrice: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.CartItem
    ///
    open func cartsItemsCreate(
        cartId: String,
        configuration: Any? = nil,
        currency: String? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        sku: String? = nil,
        snapshot: Any? = nil,
        taxRate: Double? = nil,
        type: Revenexx API — revenexxEnums.CartItemType? = nil,
        unit: String? = nil,
        unitPrice: Double? = nil
    ) async throws -> Revenexx API — revenexxModels.CartItem {
        let apiPath: String = "/v1/carts/{cart_id}/items"
            .replacingOccurrences(of: "{cartId}", with: cartId)

        let apiParams: [String: Any?] = [
            "configuration": configuration,
            "currency": currency,
            "metadata": metadata,
            "name": name,
            "position": position,
            "product_id": productId,
            "quantity": quantity,
            "sku": sku,
            "snapshot": snapshot,
            "tax_rate": taxRate,
            "type": type,
            "unit": unit,
            "unit_price": unitPrice
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.CartItem = { response in
            return RevenexxAPIRevenexxModels.CartItem.from(map: response as! [String: Any])
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
    ///   - cartId: String
    ///   - items: [Revenexx API — revenexxModels.CartItemCreateRequest]
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsItemsReplace(
        cartId: String,
        items: [Revenexx API — revenexxModels.CartItemCreateRequest]
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/{cart_id}/items"
            .replacingOccurrences(of: "{cartId}", with: cartId)

        let apiParams: [String: Any?] = [
            "items": items
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
    ///   - cartId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsItemsDelete(
        cartId: String,
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/{cart_id}/items/{id}"
            .replacingOccurrences(of: "{cartId}", with: cartId)
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
    ///   - cartId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.CartItem
    ///
    open func cartsItemsGet(
        cartId: String,
        id: String
    ) async throws -> Revenexx API — revenexxModels.CartItem {
        let apiPath: String = "/v1/carts/{cart_id}/items/{id}"
            .replacingOccurrences(of: "{cartId}", with: cartId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.CartItem = { response in
            return RevenexxAPIRevenexxModels.CartItem.from(map: response as! [String: Any])
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
    ///   - cartId: String
    ///   - id: String
    ///   - configuration: Any (optional)
    ///   - currency: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - sku: String (optional)
    ///   - snapshot: Any (optional)
    ///   - taxRate: Double (optional)
    ///   - type: Revenexx API — revenexxEnums.CartItemType (optional)
    ///   - unit: String (optional)
    ///   - unitPrice: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.CartItem
    ///
    open func cartsItemsUpdate(
        cartId: String,
        id: String,
        configuration: Any? = nil,
        currency: String? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        sku: String? = nil,
        snapshot: Any? = nil,
        taxRate: Double? = nil,
        type: Revenexx API — revenexxEnums.CartItemType? = nil,
        unit: String? = nil,
        unitPrice: Double? = nil
    ) async throws -> Revenexx API — revenexxModels.CartItem {
        let apiPath: String = "/v1/carts/{cart_id}/items/{id}"
            .replacingOccurrences(of: "{cartId}", with: cartId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "configuration": configuration,
            "currency": currency,
            "metadata": metadata,
            "name": name,
            "position": position,
            "product_id": productId,
            "quantity": quantity,
            "sku": sku,
            "snapshot": snapshot,
            "tax_rate": taxRate,
            "type": type,
            "unit": unit,
            "unit_price": unitPrice
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.CartItem = { response in
            return RevenexxAPIRevenexxModels.CartItem.from(map: response as! [String: Any])
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
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Cart
    ///
    open func cartsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Cart {
        let apiPath: String = "/v1/carts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Cart = { response in
            return RevenexxAPIRevenexxModels.Cart.from(map: response as! [String: Any])
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
    ///   - currency: String (optional)
    ///   - marketId: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Cart
    ///
    open func cartsUpdate(
        id: String,
        channelId: String? = nil,
        currency: String? = nil,
        marketId: String? = nil,
        metadata: Any? = nil,
        name: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Cart {
        let apiPath: String = "/v1/carts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "currency": currency,
            "market_id": marketId,
            "metadata": metadata,
            "name": name
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Cart = { response in
            return RevenexxAPIRevenexxModels.Cart.from(map: response as! [String: Any])
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
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Cart
    ///
    open func cartsAbandon(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Cart {
        let apiPath: String = "/v1/carts/{id}/abandon"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Cart = { response in
            return RevenexxAPIRevenexxModels.Cart.from(map: response as! [String: Any])
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
    /// - Returns: Revenexx API — revenexxModels.Cart
    ///
    open func cartsActivate(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Cart {
        let apiPath: String = "/v1/carts/{id}/activate"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Cart = { response in
            return RevenexxAPIRevenexxModels.Cart.from(map: response as! [String: Any])
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
    ///   - format: Revenexx API — revenexxEnums.CartExportFormat (optional)
    ///   - profileId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsExport(
        id: String,
        format: Revenexx API — revenexxEnums.CartExportFormat? = nil,
        profileId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/{id}/export"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "format": format,
            "profile_id": profileId
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
    ///   - id: String
    ///   - orderRef: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Cart
    ///
    open func cartsOrder(
        id: String,
        orderRef: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Cart {
        let apiPath: String = "/v1/carts/{id}/order"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "order_ref": orderRef
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Cart = { response in
            return RevenexxAPIRevenexxModels.Cart.from(map: response as! [String: Any])
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
    /// - Returns: Revenexx API — revenexxModels.Cart
    ///
    open func cartsReopen(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Cart {
        let apiPath: String = "/v1/carts/{id}/reopen"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Cart = { response in
            return RevenexxAPIRevenexxModels.Cart.from(map: response as! [String: Any])
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