import Foundation
import JSONCodable

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
        case updated_at = "updated_at"
    }

    /// 
    public let amount: Double?
    /// 
    public let authorized_at: String?
    /// 
    public let captured_at: String?
    /// 
    public let cart_id: String?
    /// 
    public let contact_id: String?
    /// 
    public let created_at: String?
    /// 
    public let currency: String?
    /// 
    public let error_message: String?
    /// 
    public let failed_at: String?
    /// 
    public let fee_amount: Double?
    /// 
    public let id: String?
    /// 
    public let idempotency_key: String?
    /// 
    public let kind: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let method_code: String?
    /// 
    public let next_action: [String: AnyCodable]?
    /// 
    public let order_ref: String?
    /// 
    public let provider: String?
    /// 
    public let psp_payment_id: String?
    /// 
    public let refunded_at: String?
    /// 
    public let status: String?
    /// 
    public let updated_at: String?

    init(
        amount: Double?,
        authorized_at: String?,
        captured_at: String?,
        cart_id: String?,
        contact_id: String?,
        created_at: String?,
        currency: String?,
        error_message: String?,
        failed_at: String?,
        fee_amount: Double?,
        id: String?,
        idempotency_key: String?,
        kind: String?,
        metadata: [String: AnyCodable]?,
        method_code: String?,
        next_action: [String: AnyCodable]?,
        order_ref: String?,
        provider: String?,
        psp_payment_id: String?,
        refunded_at: String?,
        status: String?,
        updated_at: String?
    ) {
        self.amount = amount
        self.authorized_at = authorized_at
        self.captured_at = captured_at
        self.cart_id = cart_id
        self.contact_id = contact_id
        self.created_at = created_at
        self.currency = currency
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
        self.error_message = try container.decodeIfPresent(String.self, forKey: .error_message)
        self.failed_at = try container.decodeIfPresent(String.self, forKey: .failed_at)
        self.fee_amount = try container.decodeIfPresent(Double.self, forKey: .fee_amount)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.idempotency_key = try container.decodeIfPresent(String.self, forKey: .idempotency_key)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.method_code = try container.decodeIfPresent(String.self, forKey: .method_code)
        self.next_action = try container.decodeIfPresent([String: AnyCodable].self, forKey: .next_action)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.psp_payment_id = try container.decodeIfPresent(String.self, forKey: .psp_payment_id)
        self.refunded_at = try container.decodeIfPresent(String.self, forKey: .refunded_at)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
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
        try container.encodeIfPresent(error_message, forKey: .error_message)
        try container.encodeIfPresent(failed_at, forKey: .failed_at)
        try container.encodeIfPresent(fee_amount, forKey: .fee_amount)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(idempotency_key, forKey: .idempotency_key)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(method_code, forKey: .method_code)
        try container.encodeIfPresent(next_action, forKey: .next_action)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(psp_payment_id, forKey: .psp_payment_id)
        try container.encodeIfPresent(refunded_at, forKey: .refunded_at)
        try container.encodeIfPresent(status, forKey: .status)
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
            "error_message": error_message as Any,
            "failed_at": failed_at as Any,
            "fee_amount": fee_amount as Any,
            "id": id as Any,
            "idempotency_key": idempotency_key as Any,
            "kind": kind as Any,
            "metadata": metadata as Any,
            "method_code": method_code as Any,
            "next_action": next_action as Any,
            "order_ref": order_ref as Any,
            "provider": provider as Any,
            "psp_payment_id": psp_payment_id as Any,
            "refunded_at": refunded_at as Any,
            "status": status as Any,
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
            error_message: map["error_message"] as? String,
            failed_at: map["failed_at"] as? String,
            fee_amount: map["fee_amount"] as? Double,
            id: map["id"] as? String,
            idempotency_key: map["idempotency_key"] as? String,
            kind: map["kind"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            method_code: map["method_code"] as? String,
            next_action: map["next_action"] as? [String: AnyCodable],
            order_ref: map["order_ref"] as? String,
            provider: map["provider"] as? String,
            psp_payment_id: map["psp_payment_id"] as? String,
            refunded_at: map["refunded_at"] as? String,
            status: map["status"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
