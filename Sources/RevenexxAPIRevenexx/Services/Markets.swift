import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Markets: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func marketsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/markets"

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
    ///   - currency: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - status: Revenexx API — revenexxEnums.MarketStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Market
    ///
    open func marketsCreate(
        code: String,
        name: String,
        currency: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        status: Revenexx API — revenexxEnums.MarketStatus? = nil
    ) async throws -> Revenexx API — revenexxModels.Market {
        let apiPath: String = "/v1/markets"

        let apiParams: [String: Any?] = [
            "code": code,
            "currency": currency,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "status": status
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Market = { response in
            return RevenexxAPIRevenexxModels.Market.from(map: response as! [String: Any])
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
    open func marketsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/markets/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Market
    ///
    open func marketsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Market {
        let apiPath: String = "/v1/markets/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Market = { response in
            return RevenexxAPIRevenexxModels.Market.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - currency: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - status: Revenexx API — revenexxEnums.MarketStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Market
    ///
    open func marketsUpdate(
        id: String,
        code: String? = nil,
        currency: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        status: Revenexx API — revenexxEnums.MarketStatus? = nil
    ) async throws -> Revenexx API — revenexxModels.Market {
        let apiPath: String = "/v1/markets/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "currency": currency,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "status": status
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Market = { response in
            return RevenexxAPIRevenexxModels.Market.from(map: response as! [String: Any])
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
    /// - Returns: Revenexx API — revenexxModels.MarketContext
    ///
    open func marketsContext(
        id: String
    ) async throws -> Revenexx API — revenexxModels.MarketContext {
        let apiPath: String = "/v1/markets/{id}/context"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketContext = { response in
            return RevenexxAPIRevenexxModels.MarketContext.from(map: response as! [String: Any])
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
    ///   - marketId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func marketsCurrenciesList(
        marketId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/markets/{market_id}/currencies"
            .replacingOccurrences(of: "{marketId}", with: marketId)

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
    ///   - marketId: String
    ///   - code: String
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketCurrency
    ///
    open func marketsCurrenciesCreate(
        marketId: String,
        code: String,
        isDefault: Bool? = nil,
        position: Int? = nil
    ) async throws -> Revenexx API — revenexxModels.MarketCurrency {
        let apiPath: String = "/v1/markets/{market_id}/currencies"
            .replacingOccurrences(of: "{marketId}", with: marketId)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
            "position": position
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketCurrency = { response in
            return RevenexxAPIRevenexxModels.MarketCurrency.from(map: response as! [String: Any])
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
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func marketsCurrenciesDelete(
        marketId: String,
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/markets/{market_id}/currencies/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
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
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketCurrency
    ///
    open func marketsCurrenciesGet(
        marketId: String,
        id: String
    ) async throws -> Revenexx API — revenexxModels.MarketCurrency {
        let apiPath: String = "/v1/markets/{market_id}/currencies/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketCurrency = { response in
            return RevenexxAPIRevenexxModels.MarketCurrency.from(map: response as! [String: Any])
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
    ///   - marketId: String
    ///   - id: String
    ///   - code: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketCurrency
    ///
    open func marketsCurrenciesUpdate(
        marketId: String,
        id: String,
        code: String? = nil,
        isDefault: Bool? = nil,
        position: Int? = nil
    ) async throws -> Revenexx API — revenexxModels.MarketCurrency {
        let apiPath: String = "/v1/markets/{market_id}/currencies/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
            "position": position
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketCurrency = { response in
            return RevenexxAPIRevenexxModels.MarketCurrency.from(map: response as! [String: Any])
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
    ///   - marketId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func marketsLocalesList(
        marketId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/markets/{market_id}/locales"
            .replacingOccurrences(of: "{marketId}", with: marketId)

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
    ///   - marketId: String
    ///   - code: String
    ///   - country: String
    ///   - language: String
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketLocale
    ///
    open func marketsLocalesCreate(
        marketId: String,
        code: String,
        country: String,
        language: String,
        isDefault: Bool? = nil,
        position: Int? = nil
    ) async throws -> Revenexx API — revenexxModels.MarketLocale {
        let apiPath: String = "/v1/markets/{market_id}/locales"
            .replacingOccurrences(of: "{marketId}", with: marketId)

        let apiParams: [String: Any?] = [
            "code": code,
            "country": country,
            "is_default": isDefault,
            "language": language,
            "position": position
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketLocale = { response in
            return RevenexxAPIRevenexxModels.MarketLocale.from(map: response as! [String: Any])
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
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func marketsLocalesDelete(
        marketId: String,
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/markets/{market_id}/locales/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
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
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketLocale
    ///
    open func marketsLocalesGet(
        marketId: String,
        id: String
    ) async throws -> Revenexx API — revenexxModels.MarketLocale {
        let apiPath: String = "/v1/markets/{market_id}/locales/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketLocale = { response in
            return RevenexxAPIRevenexxModels.MarketLocale.from(map: response as! [String: Any])
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
    ///   - marketId: String
    ///   - id: String
    ///   - code: String (optional)
    ///   - country: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - language: String (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketLocale
    ///
    open func marketsLocalesUpdate(
        marketId: String,
        id: String,
        code: String? = nil,
        country: String? = nil,
        isDefault: Bool? = nil,
        language: String? = nil,
        position: Int? = nil
    ) async throws -> Revenexx API — revenexxModels.MarketLocale {
        let apiPath: String = "/v1/markets/{market_id}/locales/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "country": country,
            "is_default": isDefault,
            "language": language,
            "position": position
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketLocale = { response in
            return RevenexxAPIRevenexxModels.MarketLocale.from(map: response as! [String: Any])
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
    ///   - marketId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func marketsTaxClassesList(
        marketId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes"
            .replacingOccurrences(of: "{marketId}", with: marketId)

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
    ///   - marketId: String
    ///   - code: String
    ///   - name: String
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - rate: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketTaxClass
    ///
    open func marketsTaxClassesCreate(
        marketId: String,
        code: String,
        name: String,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        rate: Double? = nil
    ) async throws -> Revenexx API — revenexxModels.MarketTaxClass {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes"
            .replacingOccurrences(of: "{marketId}", with: marketId)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "rate": rate
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketTaxClass = { response in
            return RevenexxAPIRevenexxModels.MarketTaxClass.from(map: response as! [String: Any])
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
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func marketsTaxClassesDelete(
        marketId: String,
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
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
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketTaxClass
    ///
    open func marketsTaxClassesGet(
        marketId: String,
        id: String
    ) async throws -> Revenexx API — revenexxModels.MarketTaxClass {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketTaxClass = { response in
            return RevenexxAPIRevenexxModels.MarketTaxClass.from(map: response as! [String: Any])
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
    ///   - marketId: String
    ///   - id: String
    ///   - code: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - rate: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MarketTaxClass
    ///
    open func marketsTaxClassesUpdate(
        marketId: String,
        id: String,
        code: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        rate: Double? = nil
    ) async throws -> Revenexx API — revenexxModels.MarketTaxClass {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes/{id}"
            .replacingOccurrences(of: "{marketId}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "rate": rate
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MarketTaxClass = { response in
            return RevenexxAPIRevenexxModels.MarketTaxClass.from(map: response as! [String: Any])
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