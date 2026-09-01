import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// WHAT a buyer may pay with, and what it costs them. A payment method is the line a checkout offers: a `code`, buyer-facing `labels`, a kind ('self_managed' for invoice and prepayment, 'psp' for anything an acquirer moves), a fee ('none', 'fixed' or 'percent' of the order), the countries it may be offered into and the order-value bounds it applies between. POST /payments/methods/eligible is the read side of everything in here — it takes the buyer context and answers only the methods that apply, with their computed fees, plus an `excluded` list naming the ones that did not and why. Note what eligibility does NOT ask: whether the method's PSP is configured and enabled. A method is joined to the ledger by CODE and not by a foreign key, which is why both deleting one and renaming its `code` are refused while a payment still names it.
open class PaymentsMethods: Service {

    ///
    /// Every method this tenant has configured, enabled or not — what the
    /// Cockpit's Payment methods screen shows and how an integration finds out
    /// which codes exist. It answers CONFIGURATION, never an offer: nothing here
    /// is evaluated against a buyer, so a method restricted to Germany, one whose
    /// order-value bounds exclude this basket and one whose PSP was never set up
    /// all come back the same way. The call a checkout makes is POST
    /// /payments/methods/eligible. Rows come back in whatever order the database
    /// returns them, so a storefront-shaped list needs `?order=position.asc` —
    /// `position` is the merchant's intended sequence and nothing sorts by it here
    /// on its own.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - code: String (optional)
    ///   - kind: RevenexxEnums.PaymentMethodKind (optional)
    ///   - enabled: Bool (optional)
    ///   - provider: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsMethodsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        code: String? = nil,
        kind: RevenexxEnums.PaymentMethodKind? = nil,
        enabled: Bool? = nil,
        provider: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/methods"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "code": code,
            "kind": kind,
            "enabled": enabled,
            "provider": provider
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Adds a line a checkout can offer. A create cannot omit `code` and `name`;
    /// every other column is optional or defaulted by the database. Two rows of
    /// this tenant may not share `code` — that is the 409. Two defaults are
    /// worth knowing before the first call: `enabled` is false, so a new method
    /// reaches no checkout until it is switched on, and `kind` is 'self_managed'
    /// — a card or wallet method needs `kind: "psp"` plus a `provider` the
    /// catalog carries, or it falls back to the tenant's `default_provider` at
    /// payment time and fails there if none is set. The `code` is the value every
    /// payment, every checkout and every ERP will name this method by from now on,
    /// and once a single payment has been made under it a rename is refused with
    /// 409: choose it once.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - name: String
    ///   - countries: [String] (optional)
    ///   - description: String (optional)
    ///   - enabled: Bool (optional)
    ///   - feeAmount: Double (optional)
    ///   - feeCurrency: String (optional)
    ///   - feeType: RevenexxEnums.PaymentFeeType (optional)
    ///   - kind: RevenexxEnums.PaymentMethodKind (optional)
    ///   - labels: Any (optional)
    ///   - maxOrderValue: Double (optional)
    ///   - metadata: Any (optional)
    ///   - minOrderValue: Double (optional)
    ///   - position: Int (optional)
    ///   - provider: String (optional)
    ///   - providerMethod: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsMethodsCreate(
        code: String,
        name: String,
        countries: [String]? = nil,
        description: String? = nil,
        enabled: Bool? = nil,
        feeAmount: Double? = nil,
        feeCurrency: String? = nil,
        feeType: RevenexxEnums.PaymentFeeType? = nil,
        kind: RevenexxEnums.PaymentMethodKind? = nil,
        labels: Any? = nil,
        maxOrderValue: Double? = nil,
        metadata: Any? = nil,
        minOrderValue: Double? = nil,
        position: Int? = nil,
        provider: String? = nil,
        providerMethod: String? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Writes the four methods a shop starts with — invoice and prepayment as
    /// self-managed, card and PayPal routed at the mock PSP so a fresh install can
    /// complete a checkout end to end — together with the four provider rows
    /// behind them: the built-in mock plus Stripe, PayPal and Novalnet, the three
    /// connectors this app opens outbound. The app already runs this for itself
    /// when it is installed (it listens on app.installed), so calling the route is
    /// for the second time and after: a method someone deleted, or a row a later
    /// release added that an existing install never got. Stripe, PayPal and
    /// Novalnet arrive disabled, in test mode and without credentials — the
    /// operator fills those in — while the mock arrives enabled, because it
    /// moves no money. Re-running is safe by design: it never duplicates a row and
    /// never overwrites an existing one, so nothing an operator has set can be
    /// undone by calling it again. Only genuinely missing option keys (a logo
    /// added after the first install) are filled, and those rows are reported as
    /// "updated" rather than created.
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
    /// The checkout's question — "what can THIS buyer pay with?" — answered
    /// server-side before any PSP is involved, so the storefront never renders a
    /// method the create would then refuse with 422. It evaluates the buyer
    /// context against every configured method: disabled, a country outside
    /// `countries`, an amount outside `min_order_value`/`max_order_value`.
    /// Restriction dimensions are ANDed and entries within one are ORed, and an
    /// empty dimension means unrestricted. Eligible methods come back sorted by
    /// `position` with their fee already computed for this amount; everything else
    /// lands in `excluded` with the reason in words, which is what makes a support
    /// question answerable. It reads only — nothing is written and no provider
    /// is called. Two things it does NOT check: whether the method's PSP is
    /// configured and enabled (a method whose provider is switched off is still
    /// offered here and fails at POST /payments — a provider a method names can
    /// no longer be deleted, which closes the other half of the same gap), and
    /// anything about the buyer beyond country and amount. A context that matches
    /// nothing is 200 with an empty `methods` list, never 404.
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
    /// payments.method_code is a CODE, not a foreign key: a payment records what
    /// happened and has to survive the configuration it was made with. The cost of
    /// that looseness is that deleting a method turns every payment made with it
    /// into a row naming something that no longer exists. So the count is taken
    /// HERE and answered as 409 with the number, rather than left to whoever is
    /// about to click delete — a client that pre-counts asks a second question
    /// whose answer disagrees the moment a payment lands between the two calls.
    /// Disabling the method (enabled: false) is what an operator usually meant and
    /// stays available.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsMethodsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/methods/{id}"
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
    /// One configuration, every column, addressed by its row id — the edit
    /// form's read. It is addressed by ID and there is no route that takes a
    /// `code`, which matters because the CODE is what a checkout, a payment and an
    /// ERP name a method by: to resolve one, filter the list (`GET
    /// /payments/methods?code=invoice`), which answers a page of at most one row
    /// because (tenant_id, code) is unique. Reading a method says nothing about
    /// whether a buyer may use it — that is POST /payments/methods/eligible —
    /// and nothing about whether its PSP can transact, which is under the provider
    /// configuration.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsMethodsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/methods/{id}"
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
    /// A PUT that PATCHES: only the keys in the body are written and every omitted
    /// column keeps its value, so `{"enabled": false}` is the whole request for
    /// taking a method out of checkout. A body with no writable key is refused
    /// with 400 rather than treated as a no-op. This is the route for all three
    /// things an operator changes about a method after it exists — the `enabled`
    /// switch that puts it in or out of checkout, the fee it charges (`fee_type`,
    /// `fee_amount`, `fee_currency`) and the restrictions that decide who is
    /// offered it (`countries`, `min_order_value`, `max_order_value`) —
    /// alongside its labels, description and `position`. `enabled: false` is the
    /// safe way to retire one — it disappears from POST
    /// /payments/methods/eligible immediately and stays on every payment ever made
    /// with it. The one write this route refuses is a rename of `code` while the
    /// ledger still names the old one. The three tables of this app carry no
    /// foreign keys at all: a payment names its method by `method_code` and its
    /// acquirer by `provider`, both plain text, because a payment records what
    /// happened and has to survive the configuration it was made with. So the
    /// database will not stop this — whatever the ledger still names, it goes on
    /// naming. A rename would therefore leave every recorded payment pointing at a
    /// code no configuration carries, which is the same harm DELETE on this row
    /// answers 409 for — so it answers the same 409, with the same
    /// `method_in_use` code and the same count. Renaming a method nothing has been
    /// paid with is still free, and so is every other column at any time.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - countries: [String] (optional)
    ///   - description: String (optional)
    ///   - enabled: Bool (optional)
    ///   - feeAmount: Double (optional)
    ///   - feeCurrency: String (optional)
    ///   - feeType: RevenexxEnums.PaymentFeeType (optional)
    ///   - kind: RevenexxEnums.PaymentMethodKind (optional)
    ///   - labels: Any (optional)
    ///   - maxOrderValue: Double (optional)
    ///   - metadata: Any (optional)
    ///   - minOrderValue: Double (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - provider: String (optional)
    ///   - providerMethod: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsMethodsUpdate(
        id: String,
        code: String? = nil,
        countries: [String]? = nil,
        description: String? = nil,
        enabled: Bool? = nil,
        feeAmount: Double? = nil,
        feeCurrency: String? = nil,
        feeType: RevenexxEnums.PaymentFeeType? = nil,
        kind: RevenexxEnums.PaymentMethodKind? = nil,
        labels: Any? = nil,
        maxOrderValue: Double? = nil,
        metadata: Any? = nil,
        minOrderValue: Double? = nil,
        name: String? = nil,
        position: Int? = nil,
        provider: String? = nil,
        providerMethod: String? = nil
    ) async throws -> RevenexxModels.Error {
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