import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Payments: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/payments"

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
    ///   - amount: Double
    ///   - methodCode: String
    ///   - cartId: String (optional)
    ///   - contactId: String (optional)
    ///   - country: String (optional)
    ///   - currency: String (optional)
    ///   - idempotencyKey: String (optional)
    ///   - metadata: Any (optional)
    ///   - orderRef: String (optional)
    ///   - returnUrl: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Payment
    ///
    open func paymentsCreate(
        amount: Double,
        methodCode: String,
        cartId: String? = nil,
        contactId: String? = nil,
        country: String? = nil,
        currency: String? = nil,
        idempotencyKey: String? = nil,
        metadata: Any? = nil,
        orderRef: String? = nil,
        returnUrl: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Payment {
        let apiPath: String = "/v1/payments"

        let apiParams: [String: Any?] = [
            "amount": amount,
            "cart_id": cartId,
            "contact_id": contactId,
            "country": country,
            "currency": currency,
            "idempotency_key": idempotencyKey,
            "metadata": metadata,
            "method_code": methodCode,
            "order_ref": orderRef,
            "return_url": returnUrl
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Payment = { response in
            return RevenexxAPIRevenexxModels.Payment.from(map: response as! [String: Any])
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
    open func paymentsMethodsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/methods"

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
    ///   - countries: [String] (optional)
    ///   - description: String (optional)
    ///   - enabled: Bool (optional)
    ///   - feeAmount: Double (optional)
    ///   - feeCurrency: String (optional)
    ///   - feeType: Revenexx API — revenexxEnums.PaymentFeeType (optional)
    ///   - kind: Revenexx API — revenexxEnums.PaymentMethodKind (optional)
    ///   - labels: Any (optional)
    ///   - maxOrderValue: Double (optional)
    ///   - metadata: Any (optional)
    ///   - minOrderValue: Double (optional)
    ///   - position: Int (optional)
    ///   - provider: String (optional)
    ///   - providerMethod: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PaymentMethod
    ///
    open func paymentsMethodsCreate(
        code: String,
        name: String,
        countries: [String]? = nil,
        description: String? = nil,
        enabled: Bool? = nil,
        feeAmount: Double? = nil,
        feeCurrency: String? = nil,
        feeType: Revenexx API — revenexxEnums.PaymentFeeType? = nil,
        kind: Revenexx API — revenexxEnums.PaymentMethodKind? = nil,
        labels: Any? = nil,
        maxOrderValue: Double? = nil,
        metadata: Any? = nil,
        minOrderValue: Double? = nil,
        position: Int? = nil,
        provider: String? = nil,
        providerMethod: String? = nil
    ) async throws -> Revenexx API — revenexxModels.PaymentMethod {
        let apiPath: String = "/v1/payments/methods"

        let apiParams: [String: Any?] = [
            "code": code,
            "countries": countries,
            "description": description,
            "enabled": enabled,
            "fee_amount": feeAmount,
            "fee_currency": feeCurrency,
            "fee_type": feeType,
            "kind": kind,
            "labels": labels,
            "max_order_value": maxOrderValue,
            "metadata": metadata,
            "min_order_value": minOrderValue,
            "name": name,
            "position": position,
            "provider": provider,
            "provider_method": providerMethod
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.PaymentMethod = { response in
            return RevenexxAPIRevenexxModels.PaymentMethod.from(map: response as! [String: Any])
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
    open func paymentsMethodsDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/methods/defaults"

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
    ///   - amount: Double (optional)
    ///   - country: String (optional)
    ///   - currency: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsMethodsEligible(
        amount: Double? = nil,
        country: String? = nil,
        currency: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/methods/eligible"

        let apiParams: [String: Any?] = [
            "amount": amount,
            "country": country,
            "currency": currency
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsMethodsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/methods/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.PaymentMethod
    ///
    open func paymentsMethodsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.PaymentMethod {
        let apiPath: String = "/v1/payments/methods/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.PaymentMethod = { response in
            return RevenexxAPIRevenexxModels.PaymentMethod.from(map: response as! [String: Any])
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
    ///   - countries: [String] (optional)
    ///   - description: String (optional)
    ///   - enabled: Bool (optional)
    ///   - feeAmount: Double (optional)
    ///   - feeCurrency: String (optional)
    ///   - feeType: Revenexx API — revenexxEnums.PaymentFeeType (optional)
    ///   - kind: Revenexx API — revenexxEnums.PaymentMethodKind (optional)
    ///   - labels: Any (optional)
    ///   - maxOrderValue: Double (optional)
    ///   - metadata: Any (optional)
    ///   - minOrderValue: Double (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - provider: String (optional)
    ///   - providerMethod: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PaymentMethod
    ///
    open func paymentsMethodsUpdate(
        id: String,
        code: String? = nil,
        countries: [String]? = nil,
        description: String? = nil,
        enabled: Bool? = nil,
        feeAmount: Double? = nil,
        feeCurrency: String? = nil,
        feeType: Revenexx API — revenexxEnums.PaymentFeeType? = nil,
        kind: Revenexx API — revenexxEnums.PaymentMethodKind? = nil,
        labels: Any? = nil,
        maxOrderValue: Double? = nil,
        metadata: Any? = nil,
        minOrderValue: Double? = nil,
        name: String? = nil,
        position: Int? = nil,
        provider: String? = nil,
        providerMethod: String? = nil
    ) async throws -> Revenexx API — revenexxModels.PaymentMethod {
        let apiPath: String = "/v1/payments/methods/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "countries": countries,
            "description": description,
            "enabled": enabled,
            "fee_amount": feeAmount,
            "fee_currency": feeCurrency,
            "fee_type": feeType,
            "kind": kind,
            "labels": labels,
            "max_order_value": maxOrderValue,
            "metadata": metadata,
            "min_order_value": minOrderValue,
            "name": name,
            "position": position,
            "provider": provider,
            "provider_method": providerMethod
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.PaymentMethod = { response in
            return RevenexxAPIRevenexxModels.PaymentMethod.from(map: response as! [String: Any])
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
    open func paymentsProvidersList(
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/providers"

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
    ///   - provider: String
    ///   - credentials: Any (optional)
    ///   - enabled: Bool (optional)
    ///   - name: String (optional)
    ///   - options: Any (optional)
    ///   - testMode: Bool (optional)
    ///   - webhookSecret: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PaymentProvider
    ///
    open func paymentsProvidersCreate(
        provider: String,
        credentials: Any? = nil,
        enabled: Bool? = nil,
        name: String? = nil,
        options: Any? = nil,
        testMode: Bool? = nil,
        webhookSecret: String? = nil
    ) async throws -> Revenexx API — revenexxModels.PaymentProvider {
        let apiPath: String = "/v1/payments/providers"

        let apiParams: [String: Any?] = [
            "credentials": credentials,
            "enabled": enabled,
            "name": name,
            "options": options,
            "provider": provider,
            "test_mode": testMode,
            "webhook_secret": webhookSecret
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.PaymentProvider = { response in
            return RevenexxAPIRevenexxModels.PaymentProvider.from(map: response as! [String: Any])
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
    open func paymentsProvidersCatalog(
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/providers/catalog"

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
    /// - Returns: Any
    ///
    open func paymentsProvidersDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/providers/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.PaymentProvider
    ///
    open func paymentsProvidersGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.PaymentProvider {
        let apiPath: String = "/v1/payments/providers/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.PaymentProvider = { response in
            return RevenexxAPIRevenexxModels.PaymentProvider.from(map: response as! [String: Any])
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
    ///   - credentials: Any (optional)
    ///   - enabled: Bool (optional)
    ///   - name: String (optional)
    ///   - options: Any (optional)
    ///   - provider: String (optional)
    ///   - testMode: Bool (optional)
    ///   - webhookSecret: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.PaymentProvider
    ///
    open func paymentsProvidersUpdate(
        id: String,
        credentials: Any? = nil,
        enabled: Bool? = nil,
        name: String? = nil,
        options: Any? = nil,
        provider: String? = nil,
        testMode: Bool? = nil,
        webhookSecret: String? = nil
    ) async throws -> Revenexx API — revenexxModels.PaymentProvider {
        let apiPath: String = "/v1/payments/providers/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "credentials": credentials,
            "enabled": enabled,
            "name": name,
            "options": options,
            "provider": provider,
            "test_mode": testMode,
            "webhook_secret": webhookSecret
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.PaymentProvider = { response in
            return RevenexxAPIRevenexxModels.PaymentProvider.from(map: response as! [String: Any])
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
    /// Consumes the dispatch envelope from webhooks.revenexx.com: normalizes the
    /// provider callback (stripe payment intents + a generic shape), resolves the
    /// payment by psp_payment_id or order_ref and moves the ledger. Facts only
    /// move forward — provider retries and redeliveries are idempotent no-ops;
    /// unverified envelopes are refused.
    ///
    /// - Parameters:
    ///   - provider: String
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsWebhooksIngest(
        provider: String,
        data: Any
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/webhooks/{provider}"
            .replacingOccurrences(of: "{provider}", with: provider)

        let apiParams: [String: Any?] = [
            "data": data
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
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Payment
    ///
    open func paymentsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Payment {
        let apiPath: String = "/v1/payments/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Payment = { response in
            return RevenexxAPIRevenexxModels.Payment.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Payment
    ///
    open func paymentsCancel(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Payment {
        let apiPath: String = "/v1/payments/{id}/cancel"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Payment = { response in
            return RevenexxAPIRevenexxModels.Payment.from(map: response as! [String: Any])
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
    /// - Returns: Revenexx API — revenexxModels.Payment
    ///
    open func paymentsCapture(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Payment {
        let apiPath: String = "/v1/payments/{id}/capture"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Payment = { response in
            return RevenexxAPIRevenexxModels.Payment.from(map: response as! [String: Any])
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
    /// - Returns: Revenexx API — revenexxModels.Payment
    ///
    open func paymentsConfirm(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Payment {
        let apiPath: String = "/v1/payments/{id}/confirm"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Payment = { response in
            return RevenexxAPIRevenexxModels.Payment.from(map: response as! [String: Any])
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
    /// - Returns: Revenexx API — revenexxModels.Payment
    ///
    open func paymentsRefund(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Payment {
        let apiPath: String = "/v1/payments/{id}/refund"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Payment = { response in
            return RevenexxAPIRevenexxModels.Payment.from(map: response as! [String: Any])
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