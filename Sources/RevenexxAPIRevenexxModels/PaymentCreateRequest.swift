import Foundation
import JSONCodable

/// Creates AND authorizes: self-managed methods authorize immediately, PSP methods may answer next_action (redirect). Eligibility is re-checked server-side.
open class PaymentCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case cart_id = "cart_id"
        case contact_id = "contact_id"
        case country = "country"
        case currency = "currency"
        case idempotency_key = "idempotency_key"
        case metadata = "metadata"
        case method_code = "method_code"
        case order_ref = "order_ref"
        case return_url = "return_url"
    }

    /// Order amount — 0 is legal (free orders), negative is not.
    public let amount: Double
    /// The cart this payment pays for.
    public let cart_id: String?
    /// Paying customer contact.
    public let contact_id: String?
    /// Buyer ISO country code for the eligibility check.
    public let country: String?
    /// ISO 4217 code (default EUR).
    public let currency: String?
    /// Same key answers the same payment instead of a duplicate.
    public let idempotency_key: String?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Code of a configured payment method.
    public let method_code: String
    /// External order reference — also the webhook fallback key.
    public let order_ref: String?
    /// Where the PSP redirect flow returns the buyer to.
    public let return_url: String?

    init(
        amount: Double,
        cart_id: String?,
        contact_id: String?,
        country: String?,
        currency: String?,
        idempotency_key: String?,
        metadata: [String: AnyCodable]?,
        method_code: String,
        order_ref: String?,
        return_url: String?
    ) {
        self.amount = amount
        self.cart_id = cart_id
        self.contact_id = contact_id
        self.country = country
        self.currency = currency
        self.idempotency_key = idempotency_key
        self.metadata = metadata
        self.method_code = method_code
        self.order_ref = order_ref
        self.return_url = return_url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.amount = try container.decode(Double.self, forKey: .amount)
        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.idempotency_key = try container.decodeIfPresent(String.self, forKey: .idempotency_key)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.method_code = try container.decode(String.self, forKey: .method_code)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.return_url = try container.decodeIfPresent(String.self, forKey: .return_url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(amount, forKey: .amount)
        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(idempotency_key, forKey: .idempotency_key)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encode(method_code, forKey: .method_code)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(return_url, forKey: .return_url)
    }

    public func toMap() -> [String: Any] {
        return [
            "amount": amount as Any,
            "cart_id": cart_id as Any,
            "contact_id": contact_id as Any,
            "country": country as Any,
            "currency": currency as Any,
            "idempotency_key": idempotency_key as Any,
            "metadata": metadata as Any,
            "method_code": method_code as Any,
            "order_ref": order_ref as Any,
            "return_url": return_url as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentCreateRequest {
        return PaymentCreateRequest(
            amount: map["amount"] as! Double,
            cart_id: map["cart_id"] as? String,
            contact_id: map["contact_id"] as? String,
            country: map["country"] as? String,
            currency: map["currency"] as? String,
            idempotency_key: map["idempotency_key"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            method_code: map["method_code"] as! String,
            order_ref: map["order_ref"] as? String,
            return_url: map["return_url"] as? String
        )
    }
}
