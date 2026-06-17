import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Shipping: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func shippingMethodsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/methods"

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
    ///   - carrier: String (optional)
    ///   - countries: [String] (optional)
    ///   - currency: String (optional)
    ///   - description: String (optional)
    ///   - enabled: Bool (optional)
    ///   - etaDaysMax: Int (optional)
    ///   - etaDaysMin: Int (optional)
    ///   - freeAbove: Double (optional)
    ///   - labels: Any (optional)
    ///   - matrixAttribute: String (optional)
    ///   - matrixBasis: Revenexx API — revenexxEnums.ShippingMethodMatrixBasis (optional)
    ///   - metadata: Any (optional)
    ///   - position: Int (optional)
    ///   - price: Double (optional)
    ///   - pricingType: Revenexx API — revenexxEnums.ShippingMethodPricingType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ShippingMethod
    ///
    open func shippingMethodsCreate(
        code: String,
        name: String,
        carrier: String? = nil,
        countries: [String]? = nil,
        currency: String? = nil,
        description: String? = nil,
        enabled: Bool? = nil,
        etaDaysMax: Int? = nil,
        etaDaysMin: Int? = nil,
        freeAbove: Double? = nil,
        labels: Any? = nil,
        matrixAttribute: String? = nil,
        matrixBasis: Revenexx API — revenexxEnums.ShippingMethodMatrixBasis? = nil,
        metadata: Any? = nil,
        position: Int? = nil,
        price: Double? = nil,
        pricingType: Revenexx API — revenexxEnums.ShippingMethodPricingType? = nil
    ) async throws -> Revenexx API — revenexxModels.ShippingMethod {
        let apiPath: String = "/v1/shipping/methods"

        let apiParams: [String: Any?] = [
            "carrier": carrier,
            "code": code,
            "countries": countries,
            "currency": currency,
            "description": description,
            "enabled": enabled,
            "eta_days_max": etaDaysMax,
            "eta_days_min": etaDaysMin,
            "free_above": freeAbove,
            "labels": labels,
            "matrix_attribute": matrixAttribute,
            "matrix_basis": matrixBasis,
            "metadata": metadata,
            "name": name,
            "position": position,
            "price": price,
            "pricing_type": pricingType
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ShippingMethod = { response in
            return RevenexxAPIRevenexxModels.ShippingMethod.from(map: response as! [String: Any])
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
    open func shippingMethodsDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/methods/defaults"

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
    open func shippingMethodsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/methods/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.ShippingMethod
    ///
    open func shippingMethodsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.ShippingMethod {
        let apiPath: String = "/v1/shipping/methods/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ShippingMethod = { response in
            return RevenexxAPIRevenexxModels.ShippingMethod.from(map: response as! [String: Any])
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
    ///   - carrier: String (optional)
    ///   - code: String (optional)
    ///   - countries: [String] (optional)
    ///   - currency: String (optional)
    ///   - description: String (optional)
    ///   - enabled: Bool (optional)
    ///   - etaDaysMax: Int (optional)
    ///   - etaDaysMin: Int (optional)
    ///   - freeAbove: Double (optional)
    ///   - labels: Any (optional)
    ///   - matrixAttribute: String (optional)
    ///   - matrixBasis: Revenexx API — revenexxEnums.ShippingMethodMatrixBasis (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - price: Double (optional)
    ///   - pricingType: Revenexx API — revenexxEnums.ShippingMethodPricingType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ShippingMethod
    ///
    open func shippingMethodsUpdate(
        id: String,
        carrier: String? = nil,
        code: String? = nil,
        countries: [String]? = nil,
        currency: String? = nil,
        description: String? = nil,
        enabled: Bool? = nil,
        etaDaysMax: Int? = nil,
        etaDaysMin: Int? = nil,
        freeAbove: Double? = nil,
        labels: Any? = nil,
        matrixAttribute: String? = nil,
        matrixBasis: Revenexx API — revenexxEnums.ShippingMethodMatrixBasis? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        price: Double? = nil,
        pricingType: Revenexx API — revenexxEnums.ShippingMethodPricingType? = nil
    ) async throws -> Revenexx API — revenexxModels.ShippingMethod {
        let apiPath: String = "/v1/shipping/methods/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "carrier": carrier,
            "code": code,
            "countries": countries,
            "currency": currency,
            "description": description,
            "enabled": enabled,
            "eta_days_max": etaDaysMax,
            "eta_days_min": etaDaysMin,
            "free_above": freeAbove,
            "labels": labels,
            "matrix_attribute": matrixAttribute,
            "matrix_basis": matrixBasis,
            "metadata": metadata,
            "name": name,
            "position": position,
            "price": price,
            "pricing_type": pricingType
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ShippingMethod = { response in
            return RevenexxAPIRevenexxModels.ShippingMethod.from(map: response as! [String: Any])
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
    ///   - methodId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func shippingTiersList(
        methodId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers"
            .replacingOccurrences(of: "{methodId}", with: methodId)

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
    ///   - methodId: String
    ///   - fromValue: Double (optional)
    ///   - position: Int (optional)
    ///   - price: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ShippingRateTier
    ///
    open func shippingTiersCreate(
        methodId: String,
        fromValue: Double? = nil,
        position: Int? = nil,
        price: Double? = nil
    ) async throws -> Revenexx API — revenexxModels.ShippingRateTier {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers"
            .replacingOccurrences(of: "{methodId}", with: methodId)

        let apiParams: [String: Any?] = [
            "from_value": fromValue,
            "position": position,
            "price": price
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ShippingRateTier = { response in
            return RevenexxAPIRevenexxModels.ShippingRateTier.from(map: response as! [String: Any])
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
    ///   - methodId: String
    ///   - tiers: [Revenexx API — revenexxModels.ShippingRateTierReplaceItem]
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func shippingTiersReplace(
        methodId: String,
        tiers: [Revenexx API — revenexxModels.ShippingRateTierReplaceItem]
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers"
            .replacingOccurrences(of: "{methodId}", with: methodId)

        let apiParams: [String: Any?] = [
            "tiers": tiers
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
    ///   - methodId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func shippingTiersDelete(
        methodId: String,
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers/{id}"
            .replacingOccurrences(of: "{methodId}", with: methodId)
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
    ///   - methodId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ShippingRateTier
    ///
    open func shippingTiersGet(
        methodId: String,
        id: String
    ) async throws -> Revenexx API — revenexxModels.ShippingRateTier {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers/{id}"
            .replacingOccurrences(of: "{methodId}", with: methodId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ShippingRateTier = { response in
            return RevenexxAPIRevenexxModels.ShippingRateTier.from(map: response as! [String: Any])
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
    ///   - methodId: String
    ///   - id: String
    ///   - fromValue: Double (optional)
    ///   - position: Int (optional)
    ///   - price: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ShippingRateTier
    ///
    open func shippingTiersUpdate(
        methodId: String,
        id: String,
        fromValue: Double? = nil,
        position: Int? = nil,
        price: Double? = nil
    ) async throws -> Revenexx API — revenexxModels.ShippingRateTier {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers/{id}"
            .replacingOccurrences(of: "{methodId}", with: methodId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "from_value": fromValue,
            "position": position,
            "price": price
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ShippingRateTier = { response in
            return RevenexxAPIRevenexxModels.ShippingRateTier.from(map: response as! [String: Any])
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
    ///   - attributes: Any (optional)
    ///   - country: String (optional)
    ///   - currency: String (optional)
    ///   - marketId: String (optional)
    ///   - orderValue: Double (optional)
    ///   - quantity: Double (optional)
    ///   - weight: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func shippingRates(
        attributes: Any? = nil,
        country: String? = nil,
        currency: String? = nil,
        marketId: String? = nil,
        orderValue: Double? = nil,
        quantity: Double? = nil,
        weight: Double? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/rates"

        let apiParams: [String: Any?] = [
            "attributes": attributes,
            "country": country,
            "currency": currency,
            "market_id": marketId,
            "order_value": orderValue,
            "quantity": quantity,
            "weight": weight
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