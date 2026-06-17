import Foundation
import JSONCodable

/// The snapshot payload: items plus frozen buyer/addresses/payment/shipping. The order number is drawn from the order range, totals are computed from the items.
open class OrderPlaceRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case billing_address = "billing_address"
        case buyer = "buyer"
        case cart_id = "cart_id"
        case channel_id = "channel_id"
        case contact_id = "contact_id"
        case currency = "currency"
        case customer_order_number = "customer_order_number"
        case grand_total = "grand_total"
        case items = "items"
        case market_id = "market_id"
        case metadata = "metadata"
        case organization_id = "organization_id"
        case payment = "payment"
        case shipping = "shipping"
        case shipping_address = "shipping_address"
        case shipping_total = "shipping_total"
        case user_data = "user_data"
    }

    /// Frozen billing address.
    public let billing_address: [String: AnyCodable]?
    /// Frozen buyer snapshot (name, email, …).
    public let buyer: [String: AnyCodable]?
    /// Source cart (the carts.order hand-over).
    public let cart_id: String?
    /// 
    public let channel_id: String?
    /// Ordering customer contact.
    public let contact_id: String?
    /// ISO 4217 code (default EUR).
    public let currency: String?
    /// The buyer&#039;s own order/PO number.
    public let customer_order_number: String?
    /// Override — computed as subtotal + shipping + tax when omitted.
    public let grand_total: Double?
    /// The order positions (at most 500).
    public let items: [OrderItemCreateRequest]
    /// 
    public let market_id: String?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// B2B organization.
    public let organization_id: String?
    /// Frozen payment snapshot — a known &#039;payment.status&#039; seeds payment_status (otherwise &#039;open&#039;).
    public let payment: [String: AnyCodable]?
    /// Frozen shipping snapshot — &#039;shipping.price&#039; seeds shipping_total.
    public let shipping: [String: AnyCodable]?
    /// Frozen shipping address.
    public let shipping_address: [String: AnyCodable]?
    /// Shipping total (fallback when &#039;shipping.price&#039; is absent).
    public let shipping_total: Double?
    /// Free-form user data.
    public let user_data: [String: AnyCodable]?

    init(
        billing_address: [String: AnyCodable]?,
        buyer: [String: AnyCodable]?,
        cart_id: String?,
        channel_id: String?,
        contact_id: String?,
        currency: String?,
        customer_order_number: String?,
        grand_total: Double?,
        items: [OrderItemCreateRequest],
        market_id: String?,
        metadata: [String: AnyCodable]?,
        organization_id: String?,
        payment: [String: AnyCodable]?,
        shipping: [String: AnyCodable]?,
        shipping_address: [String: AnyCodable]?,
        shipping_total: Double?,
        user_data: [String: AnyCodable]?
    ) {
        self.billing_address = billing_address
        self.buyer = buyer
        self.cart_id = cart_id
        self.channel_id = channel_id
        self.contact_id = contact_id
        self.currency = currency
        self.customer_order_number = customer_order_number
        self.grand_total = grand_total
        self.items = items
        self.market_id = market_id
        self.metadata = metadata
        self.organization_id = organization_id
        self.payment = payment
        self.shipping = shipping
        self.shipping_address = shipping_address
        self.shipping_total = shipping_total
        self.user_data = user_data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.billing_address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .billing_address)
        self.buyer = try container.decodeIfPresent([String: AnyCodable].self, forKey: .buyer)
        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.customer_order_number = try container.decodeIfPresent(String.self, forKey: .customer_order_number)
        self.grand_total = try container.decodeIfPresent(Double.self, forKey: .grand_total)
        self.items = try container.decode([OrderItemCreateRequest].self, forKey: .items)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.payment = try container.decodeIfPresent([String: AnyCodable].self, forKey: .payment)
        self.shipping = try container.decodeIfPresent([String: AnyCodable].self, forKey: .shipping)
        self.shipping_address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .shipping_address)
        self.shipping_total = try container.decodeIfPresent(Double.self, forKey: .shipping_total)
        self.user_data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user_data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(billing_address, forKey: .billing_address)
        try container.encodeIfPresent(buyer, forKey: .buyer)
        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(customer_order_number, forKey: .customer_order_number)
        try container.encodeIfPresent(grand_total, forKey: .grand_total)
        try container.encode(items, forKey: .items)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(payment, forKey: .payment)
        try container.encodeIfPresent(shipping, forKey: .shipping)
        try container.encodeIfPresent(shipping_address, forKey: .shipping_address)
        try container.encodeIfPresent(shipping_total, forKey: .shipping_total)
        try container.encodeIfPresent(user_data, forKey: .user_data)
    }

    public func toMap() -> [String: Any] {
        return [
            "billing_address": billing_address as Any,
            "buyer": buyer as Any,
            "cart_id": cart_id as Any,
            "channel_id": channel_id as Any,
            "contact_id": contact_id as Any,
            "currency": currency as Any,
            "customer_order_number": customer_order_number as Any,
            "grand_total": grand_total as Any,
            "items": items.map { $0.toMap() } as Any,
            "market_id": market_id as Any,
            "metadata": metadata as Any,
            "organization_id": organization_id as Any,
            "payment": payment as Any,
            "shipping": shipping as Any,
            "shipping_address": shipping_address as Any,
            "shipping_total": shipping_total as Any,
            "user_data": user_data as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderPlaceRequest {
        return OrderPlaceRequest(
            billing_address: map["billing_address"] as? [String: AnyCodable],
            buyer: map["buyer"] as? [String: AnyCodable],
            cart_id: map["cart_id"] as? String,
            channel_id: map["channel_id"] as? String,
            contact_id: map["contact_id"] as? String,
            currency: map["currency"] as? String,
            customer_order_number: map["customer_order_number"] as? String,
            grand_total: map["grand_total"] as? Double,
            items: (map["items"] as! [[String: Any]]).map { OrderItemCreateRequest.from(map: $0) },
            market_id: map["market_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            organization_id: map["organization_id"] as? String,
            payment: map["payment"] as? [String: AnyCodable],
            shipping: map["shipping"] as? [String: AnyCodable],
            shipping_address: map["shipping_address"] as? [String: AnyCodable],
            shipping_total: map["shipping_total"] as? Double,
            user_data: map["user_data"] as? [String: AnyCodable]
        )
    }
}
