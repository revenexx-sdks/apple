import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// WHO moves the money, and what this app needs in order to talk to it. A provider row is one PSP account of this tenant: a catalog code, the credentials its auth scheme expects, whether it is live or in sandbox, and the switches the driver reads. GET /payments/providers/catalog is the closed set of codes a create accepts — roughly thirty connectors, shipped with the app and identical for every tenant, each saying which auth scheme and which credential FIELD NAMES it wants; the logo route serves the SVG that catalog entry's `logo_url` points at, which is why it is the one route in this app that needs no tenant identity. Nothing configured here is ever read back: `credentials` and `webhook_secret` are write-only, so rotating a secret means writing the new value. What a payment method COSTS or when it is offered is never here — that belongs to the method.
open class PaymentsProviders: Service {

    ///
    /// Answers the SVG document for a catalog provider code (a shipped
    /// assets/logos/{code}.svg, otherwise a generated monogram tile), with
    /// content-type image/svg+xml and a one-day cache. It is the one route in this
    /// app that needs no tenant identity: the logos are bundled with the app
    /// rather than owned by anyone, so nothing here is tenant data and no key or
    /// tenant header is required to fetch one — which is what lets a storefront
    /// or a Cockpit screen point an <img> straight at it. Called directly on the
    /// app domain
    /// (https://revenexx-payments.apps.revenexx.io/payments/logos/stripe) the
    /// response carries its real content-type; through the gateway the body is
    /// passed through but labelled application/json, so use the app domain for
    /// <img> sources.
    ///
    /// - Parameters:
    ///   - slug: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsLogosGet(
        slug: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/logos/{slug}"
            .replacingOccurrences(of: "{slug}", with: slug)

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
    /// PSP secrets are write-only: 'credentials' and 'webhook_secret' are accepted
    /// on create/update, stored for the drivers, and never returned by any route
    /// — the responses carry the public columns only (id, provider, name,
    /// enabled, test_mode, options, timestamps). To rotate a secret, write the new
    /// value; there is no way to read the current one back.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - provider: String (optional)
    ///   - enabled: Bool (optional)
    ///   - testMode: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsProvidersList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        provider: String? = nil,
        enabled: Bool? = nil,
        testMode: Bool? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/providers"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "provider": provider,
            "enabled": enabled,
            "test_mode": testMode
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Activates one PSP account of this tenant. The `provider` code is not free
    /// text: it has to be one the catalog carries, and anything else is refused
    /// with 400 and a message listing the codes that are — so GET
    /// /payments/providers/catalog is the call that comes first, both for the code
    /// itself and for the credential field names this provider expects. PSP
    /// secrets are write-only: 'credentials' and 'webhook_secret' are accepted on
    /// create/update, stored for the drivers, and never returned by any route —
    /// the responses carry the public columns only (id, provider, name, enabled,
    /// test_mode, options, timestamps). To rotate a secret, write the new value;
    /// there is no way to read the current one back.
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
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsProvidersCreate(
        provider: String,
        credentials: Any? = nil,
        enabled: Bool? = nil,
        name: String? = nil,
        options: Any? = nil,
        testMode: Bool? = nil,
        webhookSecret: String? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// The closed set of `provider` codes POST /payments/providers accepts —
    /// anything else is refused with 400 and a message listing these. It runs to
    /// roughly thirty connectors, and each entry says which `driver` moves the
    /// money for it: nearly all of them go through the one connector layer this
    /// app embeds, hyperswitch-prism, with the built-in mock PSP alongside for
    /// demos and E2E. Read it to build the picker on an "add provider" form and to
    /// know what a credentials form has to ask for: `auth_type` is the scheme the
    /// connector authenticates with and `credential_fields` are the KEY NAMES to
    /// put inside `credentials` (never values, which come from the PSP's own
    /// dashboard). It says nothing about this tenant: no credential, no enabled
    /// flag, no test mode — that is GET /payments/providers. Watch `available`:
    /// a code with `false` has no driver in this deployment yet, so it can be
    /// created and stored and every transaction through it fails with
    /// `provider_unavailable`. The list is app-shipped and identical for everyone,
    /// so it is safe to cache hard and it changes only with a release of this app.
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
    /// Removes the PSP account row and its stored secrets, once nothing depends on
    /// it any more. The three tables of this app carry no foreign keys at all: a
    /// payment names its method by `method_code` and its acquirer by `provider`,
    /// both plain text, because a payment records what happened and has to survive
    /// the configuration it was made with. So the database will not stop this —
    /// whatever the ledger still names, it goes on naming. So the database will
    /// not stop this and the count is taken HERE, exactly as DELETE
    /// /payments/methods/{id} takes it, and answered as one 409 carrying both
    /// numbers. Counted first: every payment still in a status a transition starts
    /// from — created, requires_action, authorized or captured — because
    /// capture, cancel and refund all resolve the provider BY CODE and would
    /// answer 422 `provider_not_configured` with the row gone, leaving an
    /// authorization that can neither be collected nor released and a captured
    /// payment that can no longer be refunded here at all. Counted second: every
    /// payment method naming this provider, because POST
    /// /payments/methods/eligible does not check providers, so a checkout would go
    /// on offering a method whose next POST /payments fails at authorization
    /// unless the tenant's `fallback_provider` names one that is still configured.
    /// What is deliberately NOT counted is a settled payment — failed, cancelled
    /// or refunded: no transition starts there, so nothing will ask this provider
    /// about it again, and a `provider` code is closed catalog data that goes on
    /// meaning Stripe or PayPal with no configuration behind it. The refusal names
    /// `enabled: false` because that is usually what was meant: a disabled
    /// provider stops taking NEW payments exactly as a deleted one does, and every
    /// transition on the payments it already holds keeps working, since only the
    /// create path asks whether it is enabled.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsProvidersDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/providers/{id}"
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
    /// PSP secrets are write-only: 'credentials' and 'webhook_secret' are accepted
    /// on create/update, stored for the drivers, and never returned by any route
    /// — the responses carry the public columns only (id, provider, name,
    /// enabled, test_mode, options, timestamps). To rotate a secret, write the new
    /// value; there is no way to read the current one back.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsProvidersGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/providers/{id}"
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
    /// A partial write: omitted fields keep their value. Three things are changed
    /// here in practice — the `credentials` (and `webhook_secret`) when a key is
    /// rotated, `test_mode` when an account moves from the PSP's sandbox to live,
    /// and `enabled` when it is switched on or taken out of service. PSP secrets
    /// are write-only: 'credentials' and 'webhook_secret' are accepted on
    /// create/update, stored for the drivers, and never returned by any route —
    /// the responses carry the public columns only (id, provider, name, enabled,
    /// test_mode, options, timestamps). To rotate a secret, write the new value;
    /// there is no way to read the current one back. One field is not like the
    /// others: `provider` is the CODE every payment and every method resolves this
    /// PSP by, so writing a different one is the delete through another door and
    /// is refused with the same 409 while anything still names the current code.
    /// Switching acquirer is a second configuration plus `enabled: false` on this
    /// one, never a rename.
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
    /// - Returns: RevenexxModels.Error
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
    ) async throws -> RevenexxModels.Error {
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


}