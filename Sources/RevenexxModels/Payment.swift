import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class Payment: Codable {

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case authorized_at = "authorized_at"
        case captured_at = "captured_at"
        case cart_id = "cart_id"
        case contact_id = "contact_id"
        case created_at = "created_at"
        case currency = "currency"
        case dunning_due_at = "dunning_due_at"
        case dunning_stage = "dunning_stage"
        case error_code = "error_code"
        case error_message = "error_message"
        case failed_at = "failed_at"
        case fee_amount = "fee_amount"
        case id = "id"
        case idempotency_key = "idempotency_key"
        case kind = "kind"
        case metadata = "metadata"
        case method_code = "method_code"
        case next_action = "next_action"
        case order_ref = "order_ref"
        case provider = "provider"
        case psp_payment_id = "psp_payment_id"
        case refunded_at = "refunded_at"
        case status = "status"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// What the provider is asked to authorize, in `currency`. 0 is legal (a free order) and negative is refused by the handler and by the CHECK behind it. `fee_amount` is recorded beside this and is NOT added to it — a checkout that charges its payment surcharge sends a total that already includes it.
    public let amount: Double?
    /// When the money was reserved — or, for invoice and prepayment, when it became owed. The clock the capture window and the dunning stages are measured from.
    public let authorized_at: String?
    /// When the money was actually taken. The refund window is measured from here.
    public let captured_at: String?
    /// The cart this payment pays for. Not a foreign key: the payment is a record of what happened and outlives the cart. Indexed, so it is the cheap way to find the payment behind a checkout.
    public let cart_id: String?
    /// The paying customer contact. Not a foreign key — a payment must survive a contact being merged or erased. Indexed.
    public let contact_id: String?
    /// When the payment was created. The dunning clock for invoice and prepayment runs from here.
    public let created_at: String?
    /// ISO 4217 code the amount and the fee are in. The database bounds the length at three characters and nothing else, so lower case is stored as written.
    public let currency: String?
    /// When the NEXT dunning stage falls due — the moment a reminder becomes due, then the moment it becomes overdue. null once nothing further is pending, which includes an already overdue payment and every paid, cancelled or refunded one.
    public let dunning_due_at: String?
    /// How overdue an unpaid self-managed payment is: 'none', 'reminder' or 'overdue'. Written by the daily dunning scan from the merchant's two thresholds, and reset the moment the money arrives or the claim is dropped. It classifies and never sends: what a reminder looks like is the merchant's own workflow.
    public let dunning_stage: RevenexxEnums.PaymentDunningStage?
    /// The class of failure, out of a fixed taxonomy — the value to branch on. null unless the payment failed. The five classes say what a caller can DO: 'provider_unavailable', 'provider_unreachable', 'provider_not_configured', 'provider_declined', 'provider_error' — a provider that is unreachable or unavailable is worth a retry, a declined payment needs a different method from the buyer, and a provider that is not configured needs an operator.
    public let error_code: RevenexxEnums.PaymentFailureCode?
    /// One operator-facing sentence, fixed per `error_code`. Never the provider's or the runtime's own wording: that is unbounded internal text and it stays in the app log.
    public let error_message: String?
    /// When the payment failed. `error_code` says which class of failure.
    public let failed_at: String?
    /// The method surcharge as it was computed at creation, in `currency`. Kept so the fee that was quoted stays readable after the method's fee configuration changes.
    public let fee_amount: Double?
    /// Id of the payment. Every lifecycle route addresses it, and it is what the drivers send the provider as their merchant transaction reference.
    public let id: String?
    /// The caller's own key for this creation attempt. Sending it again answers the SAME payment with 200 instead of creating a second one — which is what makes a retried checkout safe. Unique per tenant, so a filter on it answers at most one row.
    public let idempotency_key: String?
    /// Copied from the method at creation. 'self_managed' payments move through the lifecycle without a PSP; 'psp' payments are driven by `provider`.
    public let kind: RevenexxEnums.PaymentMethodKind?
    /// Whatever the creating call sent, plus the keys this app writes onto it. The app's own: `provider_method` (the method's provider-side id, copied at creation), `return_url` (where the PSP sends the buyer back), `cancel_reason` / `refund_reason` (the operator's words from the cancel and refund routes, also handed to the provider) and `provider_fallback_from` (the provider that was WANTED, written when the tenant's fallback_provider stood in — the only record of why the money went through a different acquirer). Free jsonb; a caller's own keys are kept untouched beside these.
    public let metadata: [String: AnyCodable]?
    /// The `code` of the payment method this payment was made with, copied at creation. Deliberately a code and not a foreign key: the ledger records what happened and has to outlive the configuration it happened under.
    public let method_code: String?
    /// What the storefront must do before this payment can go any further, or null when there is nothing to do. It is set exactly when `status` is `requires_action`, and every transition clears it. One shape exists today: `{ "type": "redirect", "url": … }` — send the buyer to `url` (that is also where a 3-D Secure challenge is presented, because the connector hands it back as a redirect), and when they come back call POST /payments/{id}/confirm. `type` is what to branch on; a client that does not recognise it must not guess.
    public let next_action: [String: AnyCodable]?
    /// The external order reference the checkout wrote onto the payment. It is what POST /payments/orders/{order_ref}/capture resolves and the fallback key a PSP webhook is matched on when it carries no transaction id — so an integration that leaves it null gives up both. Free text with no uniqueness: several payments may share one reference.
    public let order_ref: String?
    /// The PSP the money really went through — resolved at creation and rewritten if the tenant's fallback provider stood in, in which case `metadata.provider_fallback_from` records what was meant. null for self-managed payments.
    public let provider: String?
    /// The provider's own transaction id, as it answered — the value to quote in a PSP support case, and the primary key a webhook is matched on. Shaped by the provider, so nothing here constrains it; null until a provider has answered, and always null for self-managed payments.
    public let psp_payment_id: String?
    /// When the payment was refunded in full — this app has no partial refund to record.
    public let refunded_at: String?
    /// Where the payment stands. 'created' → 'requires_action' → 'authorized' → 'captured' → 'refunded', with 'failed' and 'cancelled' ending it. GET /payments/vocabularies/statuses serves the same set with labels, badge tones and which of them are final.
    public let status: RevenexxEnums.PaymentStatus?
    /// The tenant the row belongs to — the same slug the request carried in `X-Revenexx-Tenant`. Added by the platform rather than by this app, and echoed so a caller that fans several tenants into one store can tell the rows apart.
    public let tenant_id: String?
    /// When the row last moved. For a PSP payment still waiting on a callback this is what the webhook-staleness check measures against, so an old payment that changed a minute ago counts as progressing.
    public let updated_at: String?

    init(
        amount: Double?,
        authorized_at: String?,
        captured_at: String?,
        cart_id: String?,
        contact_id: String?,
        created_at: String?,
        currency: String?,
        dunning_due_at: String?,
        dunning_stage: RevenexxEnums.PaymentDunningStage?,
        error_code: RevenexxEnums.PaymentFailureCode?,
        error_message: String?,
        failed_at: String?,
        fee_amount: Double?,
        id: String?,
        idempotency_key: String?,
        kind: RevenexxEnums.PaymentMethodKind?,
        metadata: [String: AnyCodable]?,
        method_code: String?,
        next_action: [String: AnyCodable]?,
        order_ref: String?,
        provider: String?,
        psp_payment_id: String?,
        refunded_at: String?,
        status: RevenexxEnums.PaymentStatus?,
        tenant_id: String?,
        updated_at: String?
    ) {
        self.amount = amount
        self.authorized_at = authorized_at
        self.captured_at = captured_at
        self.cart_id = cart_id
        self.contact_id = contact_id
        self.created_at = created_at
        self.currency = currency
        self.dunning_due_at = dunning_due_at
        self.dunning_stage = dunning_stage
        self.error_code = error_code
        self.error_message = error_message
        self.failed_at = failed_at
        self.fee_amount = fee_amount
        self.id = id
        self.idempotency_key = idempotency_key
        self.kind = kind
        self.metadata = metadata
        self.method_code = method_code
        self.next_action = next_action
        self.order_ref = order_ref
        self.provider = provider
        self.psp_payment_id = psp_payment_id
        self.refunded_at = refunded_at
        self.status = status
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        self.authorized_at = try container.decodeIfPresent(String.self, forKey: .authorized_at)
        self.captured_at = try container.decodeIfPresent(String.self, forKey: .captured_at)
        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.dunning_due_at = try container.decodeIfPresent(String.self, forKey: .dunning_due_at)
        if let dunning_stageString = try container.decodeIfPresent(String.self, forKey: .dunning_stage) {
            self.dunning_stage = RevenexxEnums.PaymentDunningStage(rawValue: dunning_stageString)
        } else {
            self.dunning_stage = nil
        }
        if let error_codeString = try container.decodeIfPresent(String.self, forKey: .error_code) {
            self.error_code = RevenexxEnums.PaymentFailureCode(rawValue: error_codeString)
        } else {
            self.error_code = nil
        }
        self.error_message = try container.decodeIfPresent(String.self, forKey: .error_message)
        self.failed_at = try container.decodeIfPresent(String.self, forKey: .failed_at)
        self.fee_amount = try container.decodeIfPresent(Double.self, forKey: .fee_amount)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.idempotency_key = try container.decodeIfPresent(String.self, forKey: .idempotency_key)
        if let kindString = try container.decodeIfPresent(String.self, forKey: .kind) {
            self.kind = RevenexxEnums.PaymentMethodKind(rawValue: kindString)
        } else {
            self.kind = nil
        }
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.method_code = try container.decodeIfPresent(String.self, forKey: .method_code)
        self.next_action = try container.decodeIfPresent([String: AnyCodable].self, forKey: .next_action)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.psp_payment_id = try container.decodeIfPresent(String.self, forKey: .psp_payment_id)
        self.refunded_at = try container.decodeIfPresent(String.self, forKey: .refunded_at)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.PaymentStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(authorized_at, forKey: .authorized_at)
        try container.encodeIfPresent(captured_at, forKey: .captured_at)
        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(dunning_due_at, forKey: .dunning_due_at)
        try container.encodeIfPresent(dunning_stage?.rawValue, forKey: .dunning_stage)
        try container.encodeIfPresent(error_code?.rawValue, forKey: .error_code)
        try container.encodeIfPresent(error_message, forKey: .error_message)
        try container.encodeIfPresent(failed_at, forKey: .failed_at)
        try container.encodeIfPresent(fee_amount, forKey: .fee_amount)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(idempotency_key, forKey: .idempotency_key)
        try container.encodeIfPresent(kind?.rawValue, forKey: .kind)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(method_code, forKey: .method_code)
        try container.encodeIfPresent(next_action, forKey: .next_action)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(psp_payment_id, forKey: .psp_payment_id)
        try container.encodeIfPresent(refunded_at, forKey: .refunded_at)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "amount": amount as Any,
            "authorized_at": authorized_at as Any,
            "captured_at": captured_at as Any,
            "cart_id": cart_id as Any,
            "contact_id": contact_id as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "dunning_due_at": dunning_due_at as Any,
            "dunning_stage": dunning_stage?.rawValue as Any,
            "error_code": error_code?.rawValue as Any,
            "error_message": error_message as Any,
            "failed_at": failed_at as Any,
            "fee_amount": fee_amount as Any,
            "id": id as Any,
            "idempotency_key": idempotency_key as Any,
            "kind": kind?.rawValue as Any,
            "metadata": metadata as Any,
            "method_code": method_code as Any,
            "next_action": next_action as Any,
            "order_ref": order_ref as Any,
            "provider": provider as Any,
            "psp_payment_id": psp_payment_id as Any,
            "refunded_at": refunded_at as Any,
            "status": status?.rawValue as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Payment {
        return Payment(
            amount: map["amount"] as? Double,
            authorized_at: map["authorized_at"] as? String,
            captured_at: map["captured_at"] as? String,
            cart_id: map["cart_id"] as? String,
            contact_id: map["contact_id"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            dunning_due_at: map["dunning_due_at"] as? String,
            dunning_stage: map["dunning_stage"] as? String != nil ? PaymentDunningStage(rawValue: map["dunning_stage"] as! String) : nil,
            error_code: map["error_code"] as? String != nil ? PaymentFailureCode(rawValue: map["error_code"] as! String) : nil,
            error_message: map["error_message"] as? String,
            failed_at: map["failed_at"] as? String,
            fee_amount: map["fee_amount"] as? Double,
            id: map["id"] as? String,
            idempotency_key: map["idempotency_key"] as? String,
            kind: map["kind"] as? String != nil ? PaymentMethodKind(rawValue: map["kind"] as! String) : nil,
            metadata: map["metadata"] as? [String: AnyCodable],
            method_code: map["method_code"] as? String,
            next_action: map["next_action"] as? [String: AnyCodable],
            order_ref: map["order_ref"] as? String,
            provider: map["provider"] as? String,
            psp_payment_id: map["psp_payment_id"] as? String,
            refunded_at: map["refunded_at"] as? String,
            status: map["status"] as? String != nil ? PaymentStatus(rawValue: map["status"] as! String) : nil,
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
