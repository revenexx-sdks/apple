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

    /// What the provider is asked to authorize, in `currency`. 0 is legal (a free order) and negative is refused by the handler and by the CHECK behind it. `fee_amount` is recorded beside this and is NOT added to it — a checkout that charges its payment surcharge sends a total that already includes it.
    public let amount: Double
    /// The cart this payment pays for. Not a foreign key: the payment is a record of what happened and outlives the cart. Indexed, so it is the cheap way to find the payment behind a checkout.
    public let cart_id: String?
    /// The paying customer contact. Not a foreign key — a payment must survive a contact being merged or erased. Indexed.
    public let contact_id: String?
    /// The buyer's ISO 3166-1 alpha-2 country code, for the eligibility check. A method restricted to countries is refused with 422 without it.
    public let country: String?
    /// ISO 4217 code the amount and the fee are in. The database bounds the length at three characters and nothing else, so lower case is stored as written. Defaults to EUR.
    public let currency: String?
    /// The caller's own key for this creation attempt. Sending it again answers the SAME payment with 200 instead of creating a second one — which is what makes a retried checkout safe. Unique per tenant, so a filter on it answers at most one row. The replay answers 200, not 201.
    public let idempotency_key: String?
    /// Free-form data to keep on the payment. Merged with the keys this app writes itself (`provider_method`, `return_url`, later the cancel/refund reasons), which win on a collision.
    public let metadata: [String: AnyCodable]?
    /// The `code` of the payment method this payment was made with, copied at creation. Deliberately a code and not a foreign key: the ledger records what happened and has to outlive the configuration it happened under. It must name a method this tenant has configured; eligibility for the buyer context below is re-checked here, whatever the checkout showed.
    public let method_code: String
    /// The external order reference the checkout wrote onto the payment. It is what POST /payments/orders/{order_ref}/capture resolves and the fallback key a PSP webhook is matched on when it carries no transaction id — so an integration that leaves it null gives up both. Free text with no uniqueness: several payments may share one reference.
    public let order_ref: String?
    /// Where the PSP sends the buyer back after a redirect or a 3-D Secure challenge. Kept in `metadata.return_url` and handed to the driver — a PSP method that needs a redirect and has none leaves the buyer stranded at the provider.
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
