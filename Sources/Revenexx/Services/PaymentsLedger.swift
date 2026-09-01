import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// What actually happened to one buyer's money, and everything that moves it. A payment is the record: an amount, a currency, the fee that was computed for it, the method code it was made under, the PSP it went through, and where it stands — created → requires_action → authorized → captured, with failed, cancelled and refunded as the ends. Four transitions move it and a lattice decides which is legal from where: a transition the lattice forbids answers 400, one the merchant's own window forbids (capture_expiry_days, refund_window_days) answers 422, and a provider that is configured and refuses answers 502. `next_action` is the instruction the storefront must follow next and is set exactly at requires_action. The routes with no screen of their own are here because every row they touch is a payment: the PSP webhook resolves one and moves its status, the order-reference capture collects every payment behind one shipment, and the one-off redaction rewrites `error_message` on rows written before the failure taxonomy existed. The daily dunning scan belongs here for the same reason and is not screenless at all — it writes the reminder clock onto unpaid invoice and prepayment payments, and the Cockpit fires it from the Payments list. The vocabularies sit here too — three of the four sets they publish are columns of this row.
open class PaymentsLedger: Service {

    ///
    /// The ledger, paged and filtered — the Payments screen, the reconciliation
    /// query and the way an order or a cart finds out what has been paid against
    /// it. Every column of the entity is an exact-match filter, which is what
    /// makes it useful: `?cart_id=` and `?contact_id=` are indexed,
    /// `?status=authorized&kind=self_managed` is the awaiting-payment queue the
    /// dunning scan classifies, and `?order_ref=` is the only way to resolve a
    /// payment by its external reference. Rows come back in the database's own
    /// order, so a newest-first list needs `?order=created_at.desc`.
    /// `error_message` is answered from the failure taxonomy rather than echoed
    /// out of the column, so what a driver or a PSP actually wrote is never
    /// serialized here.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - cartId: String (optional)
    ///   - contactId: String (optional)
    ///   - status: RevenexxEnums.PaymentStatus (optional)
    ///   - orderRef: String (optional)
    ///   - methodCode: String (optional)
    ///   - kind: RevenexxEnums.PaymentMethodKind (optional)
    ///   - provider: String (optional)
    ///   - dunningStage: RevenexxEnums.PaymentDunningStage (optional)
    ///   - idempotencyKey: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        cartId: String? = nil,
        contactId: String? = nil,
        status: RevenexxEnums.PaymentStatus? = nil,
        orderRef: String? = nil,
        methodCode: String? = nil,
        kind: RevenexxEnums.PaymentMethodKind? = nil,
        provider: String? = nil,
        dunningStage: RevenexxEnums.PaymentDunningStage? = nil,
        idempotencyKey: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/payments"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "cart_id": cartId,
            "contact_id": contactId,
            "status": status,
            "order_ref": orderRef,
            "method_code": methodCode,
            "kind": kind,
            "provider": provider,
            "dunning_stage": dunningStage,
            "idempotency_key": idempotencyKey
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// The checkout's write: it opens the ledger row and takes it as far as the
    /// named method allows, in one call. A create cannot omit `method_code` and
    /// `amount`; every other column is optional or defaulted by the database.
    /// Nothing else about the money is the caller's to choose: `kind`, `provider`
    /// and `fee_amount` are read off the method that `method_code` names, so a
    /// caller can neither pick an acquirer nor discount its own fee. `amount: 0`
    /// is legal (free orders); negative is 400. Eligibility is enforced HERE and
    /// not only in the checkout UI — the same country and order-value rules POST
    /// /payments/methods/eligible applies answer 422 if the method does not apply
    /// to this buyer. What comes back depends on the method: a self-managed one
    /// (invoice, prepayment) is `authorized` at once with the dunning clock
    /// already started, and a PSP one is `captured` or `authorized`, or
    /// `requires_action` with `next_action` — the instruction the storefront
    /// must carry out, typically a redirect, set at that status and at no other.
    /// Send an `idempotency_key` and a repeat of the same call answers 200 with
    /// the payment that key already named, unchanged and not re-authorized. What
    /// is never stored: the `instrument`, `token` or `card` is handed to the
    /// driver in-process and no token or PAN is written to the row.
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
    /// - Returns: RevenexxModels.Error
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
    ) async throws -> RevenexxModels.Error {
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
    /// Classifies every unpaid self-managed payment (invoice, prepayment) as on
    /// time / reminder due / overdue from payment_reminder_after_days and
    /// overdue_after_days, writes the stage and the next due date, and reports PSP
    /// payments still waiting on a callback longer than
    /// webhook_stale_after_minutes. Pure function of each payment's age, so it is
    /// idempotent — it also runs daily as the 'dunning-scan' schedule. It
    /// classifies and does not send: a stage change emits payment.updated, and
    /// what a reminder looks like is the merchant's workflow.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsDunningScan(
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/dunning/scan"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Rows written before the failure taxonomy still store the
    /// provider's/runtime's raw text in error_message. API responses never repeat
    /// it (the read path projects), but the column is also read directly through
    /// Baseline, so it needs rewriting once per tenant. Dry-run by default —
    /// reports what it would touch and changes nothing until apply:true.
    /// Idempotent: rows already carrying a taxonomy message are skipped.
    ///
    /// - Parameters:
    ///   - apply: Bool (optional)
    ///   - limit: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsErrorsRedact(
        apply: Bool? = nil,
        limit: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/errors/redact"

        let apiParams: [String: Any?] = [
            "apply": apply,
            "limit": limit
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
    /// This is the hook the tenant's `auto_capture_policy: 'on_ship'` was written
    /// for: fulfilment knows the order it shipped and not the payment ids behind
    /// it, so the shipment calls this one route with the reference it already
    /// holds and the money for that order is collected in a single request.
    /// Resolves payments by their order_ref (the same key the PSP webhooks fall
    /// back to), captures every authorized one and reports the rest instead of
    /// failing — an order whose payment was already captured is a successful
    /// no-op, and a provider that refuses one payment lands in `skipped` rather
    /// than failing the call. Note that payments.order_ref is nullable with no
    /// foreign key: this route is exactly as good as the reference the checkout
    /// writes onto the payment.
    ///
    /// - Parameters:
    ///   - orderRef: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsOrdersCapture(
        orderRef: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/orders/{order_ref}/capture"
            .replacingOccurrences(of: "{order_ref}", with: orderRef)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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
    /// The enums this app owns, four of them: statuses, method kinds, fee types
    /// and dunning stages. This is the index and carries a name and a title per
    /// set and nothing more — the values themselves, with their labels and badge
    /// tones, are one call further down at GET /payments/vocabularies/{name}, so a
    /// client that only needs to know which sets exist does not pay for all of
    /// them. Values come out of the CHECK constraints, so what is served is what
    /// the database enforces — a client renders a status this app adds without a
    /// release of its own.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func paymentsVocabulariesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/payments/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// One set in full: every value it permits, the label to show for each and the
    /// badge tone to render it in, which is what a client needs to draw a status
    /// chip without hard-coding this app's enums. The value set is parsed out of
    /// the CHECK constraint in schema.json, so what is served IS what the database
    /// enforces. Labels are curated on top and can only add words and colour — a
    /// permitted value nobody labelled still appears, titled from its own key,
    /// which is why `title` and `description` are a locale map on a labelled value
    /// and a plain string on an unlabelled one.
    ///
    /// - Parameters:
    ///   - name: RevenexxEnums.PaymentsVocabulariesGetName
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsVocabulariesGet(
        name: RevenexxEnums.PaymentsVocabulariesGetName
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/vocabularies/{name}"
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

    ///
    /// The sink a PSP callback ends up in, and an inbound ingress endpoint in the
    /// sense of ADR-0066: the provider never posts here directly, it posts to
    /// webhooks.revenexx.com, which verifies and captures the delivery and
    /// dispatches its envelope to this route through the gateway. That indirection
    /// is also what makes this the one override point for PSP callback handling
    /// — everything a callback does to the ledger happens here and nowhere else,
    /// so a deployment that needs a provider's callbacks normalized differently
    /// replaces this operation instead of touching the lifecycle routes. Consumes
    /// the dispatch envelope from webhooks.revenexx.com: normalizes the provider
    /// callback (stripe payment intents + a generic shape), resolves the payment
    /// by psp_payment_id or order_ref and moves the ledger. Facts only move
    /// forward — provider retries and redeliveries are idempotent no-ops;
    /// unverified envelopes are refused.
    ///
    /// - Parameters:
    ///   - provider: String
    ///   - id: Any (optional)
    ///   - request: Any (optional)
    ///   - verified: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsWebhooksIngest(
        provider: String,
        id: Any? = nil,
        request: Any? = nil,
        verified: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/webhooks/{provider}"
            .replacingOccurrences(of: "{provider}", with: provider)

        let apiParams: [String: Any?] = [
            "id": id,
            "request": request,
            "verified": verified
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
    /// One ledger row in full: the amount and the fee that were computed at
    /// creation, the method code and PSP it was made through, where it stands in
    /// the lifecycle, the timestamp of each transition it has been through
    /// (`authorized_at`, `captured_at`, `failed_at`, `refunded_at`), the dunning
    /// columns the daily scan maintains and, while the buyer still has something
    /// to do, `next_action`. This is the call to poll after sending a buyer to a
    /// PSP redirect. Two things it does not do: `error_message` is answered from
    /// the failure taxonomy and never carries the provider's or the runtime's own
    /// words, and there is no route that resolves a payment by `order_ref` —
    /// that column is nullable and not unique, so it is a filter on the list (`GET
    /// /payments?order_ref=…`) which may legitimately answer several rows.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/{id}"
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
    /// Drops the claim before any money has been taken — the abandoned basket,
    /// the buyer who never came back from the redirect, the invoice an operator
    /// writes off. It is the only transition that starts from three statuses
    /// rather than one, because everything short of captured can still be
    /// released. A captured payment is not cancellable at all: that is a refund,
    /// and the lattice answers 400 rather than pretending. Unlike capture and
    /// refund this transition has no time window — the merchant's
    /// `capture_expiry_days` and `refund_window_days` do not apply, so a stale
    /// authorization can always be released even once it is too old to collect. On
    /// a PSP payment the provider is called and the `reason` in the body is passed
    /// to it, so it reaches the PSP's own cancellation-reason field as well as
    /// being stored under `metadata.cancel_reason`. Cancelling stops the dunning
    /// clock: the stage goes back to `none` and the due date is cleared.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsCancel(
        id: String,
        reason: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/{id}/cancel"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
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
    /// Collects money that is currently only reserved. It starts from `authorized`
    /// and from nothing else — under `auto_capture_policy: 'immediate'` a
    /// payment is captured in the same request that created it and never passes
    /// through here, so this is the route for the 'manual' and 'on_ship' policies,
    /// and POST /payments/orders/{order_ref}/capture is the same operation
    /// addressed by the order reference a warehouse actually holds. There is no
    /// request body and no amount: the ledger carries one amount and one status,
    /// so a capture is the whole authorization or nothing. On a self-managed
    /// payment it takes no PSP anywhere near it — it records that an invoice or
    /// a prepayment was paid, and stops the dunning clock. Refused with 422 once
    /// the authorization is older than the tenant's `capture_expiry_days` (the
    /// message carries both numbers), because an expired authorization is declined
    /// by the provider anyway and a 422 here is the cheap version of finding out
    /// later.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsCapture(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/{id}/capture"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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
    /// The other half of a redirect. POST /payments answered `requires_action`
    /// with a `next_action` the storefront carried out — a 3-D Secure step, a
    /// wallet approval, a bank login — and this is the call that asks the PSP
    /// how it went and writes the answer to the ledger. It starts from
    /// `requires_action` and from nothing else, so a payment that already came
    /// back authorized needs no confirm and the lattice answers 400 rather than
    /// repeating one. `next_action` is cleared by this call whatever the outcome.
    /// Where the tenant's `auto_capture_policy` is 'immediate' the money is taken
    /// straight after the authorization, in the same request, so a successful
    /// confirm can come back `captured` rather than `authorized`; a failed
    /// auto-capture does not fail the confirm, because a good authorization is
    /// worth more than a tidy status.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsConfirm(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/{id}/confirm"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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
    /// Gives captured money back. It starts from `captured` and from nothing else
    /// — money that was only authorized is cancelled, not refunded, and the
    /// lattice answers 400 rather than guessing which was meant. All or nothing:
    /// the ledger carries one amount and one status, so there is no partial refund
    /// and no second one to express — a refunded payment is refunded in full,
    /// and a repeat is a 400 because `refunded` is not a status a refund starts
    /// from. The `reason` in the body is handed to the driver in the same call, so
    /// it reaches the PSP's own refund-reason field rather than being a note only
    /// this database ever sees, and it is stored under `metadata.refund_reason`.
    /// On a self-managed payment nothing is sent anywhere: it records that the
    /// merchant paid the buyer back by their own means. Refused with 422 once the
    /// capture is older than the tenant's `refund_window_days` (the message
    /// carries both numbers) — past that the provider stops accepting a refund
    /// against the transaction and it has to be made by bank transfer.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func paymentsRefund(
        id: String,
        reason: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/payments/{id}/refund"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
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


}