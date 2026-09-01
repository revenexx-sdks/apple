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
        case metadata = "metadata"
        case organization_id = "organization_id"
        case payment = "payment"
        case shipping = "shipping"
        case shipping_address = "shipping_address"
        case shipping_total = "shipping_total"
        case user_data = "user_data"
    }

    /// The invoice address, FROZEN at place-time. Changing the customer's address afterwards does not change what this order was billed to.
    public let billing_address: [String: AnyCodable]?
    /// The ordering party as it was at place-time, FROZEN: a copy, not a reference, so the order still reads correctly after the customer record is renamed, merged or deleted. The caller decides what goes in; this app stores it and reads nothing out of it.
    public let buyer: [String: AnyCodable]?
    /// The cart this order was placed from, when a storefront handed one over. A reference across an app boundary (the carts app), not a foreign key — nothing here checks that it resolves. Null for an order an integration or an operator created. The carts.order hand-over sets it.
    public let cart_id: String?
    /// The sales channel the order arrived through — webshop, app, phone desk, EDI. Null when the caller named none.
    public let channel_id: String?
    /// The PERSON who ordered — a contact in the customers app. Resolved from the acting principal whenever the caller carries one, and a body value that disagrees is refused rather than silently overridden. Null for a guest checkout. Ignored when the caller carries a principal — the RESOLVED contact wins, and a body value that disagrees is a 400 rather than a silent override.
    public let contact_id: String?
    /// ISO 4217 code of EVERY amount on this order. Frozen at place-time from the market's default_currency unless the caller named one. Nothing on this order is ever converted, and the approval threshold is read in this currency — which is why the threshold is a per-market setting. Defaults to the market's default_currency setting.
    public let currency: String?
    /// The BUYER's own reference — their purchase-order number. Free text, not unique, never generated here: it exists so the paperwork can carry the number the buyer's accounts payable will look for. One of the few fields PUT /orders/{id} may still change.
    public let customer_order_number: String?
    /// Optional, and CHECKED rather than used: the order always computes its own total from the positions, the shipping cost and the tax. Send it as a checksum on that arithmetic — if it agrees the order is placed, and if it disagrees the call is refused with 400 naming both numbers, yours and the computed one. The comparison is at 2 decimal places (this app stores 4, ERPs work to 2, so a difference below a cent is agreement). It is never taken as the order value: the approval threshold and the revenue rollup read the computed number, which is why a total that disagrees is an error rather than an override.
    public let grand_total: Double?
    /// The order positions — at least one, and at most the tenant's max_items_per_order (500 out of the box; a longer list is a 400 naming the limit).
    public let items: [OrderItemCreateRequest]
    /// Free-form data belonging to the INTEGRATION side — an ERP's own bookkeeping about this order. Stored and returned untouched; nothing here reads it.
    public let metadata: [String: AnyCodable]?
    /// The COMPANY the order is booked on — an organization in the customers app, and the B2B half of who ordered. This is what orders.reports.customer-rollup aggregates by and what makes an order visible to a buyer's colleagues. Null on a private or guest order, which the rollup counts separately because it cannot attribute it. A principal's own organization wins over this when it has one.
    public let organization_id: String?
    /// The payment arrangement as it was chosen, FROZEN. This app reads exactly two keys and stores the rest untouched: 'status' seeds payment_status at place-time when it names one of the permitted values (anything else is ignored and the order starts 'open'), and 'payment_id' is merged in by POST /orders/{id}/payment-status. The method itself, its provider fields and any redirect state belong to the payments app.
    public let payment: [String: AnyCodable]?
    /// The shipping arrangement as it was chosen, FROZEN. Two keys are READ at place-time and feed the totals: 'price' becomes shipping_total (the shipping_total field is only the fallback when this is absent) and 'tax_rate' is what shipping is taxed at, because shipping is a Nebenleistung and is taxed too. Everything else — the carrier product, the delivery window, the pickup point — is stored untouched and belongs to the shipping app.
    public let shipping: [String: AnyCodable]?
    /// The delivery address, FROZEN at place-time — what goes on the label of every shipment of this order. Null on an order that is never delivered (a service, a digital item, a collection).
    public let shipping_address: [String: AnyCodable]?
    /// NET shipping cost, taken from shipping.price or, when the snapshot carries no price, from the request's shipping_total. In `currency`. Only read when the shipping snapshot carries no 'price'.
    public let shipping_total: Double?
    /// Free-form data belonging to the ORDERING side — carried through from the storefront or the cart and handed back untouched. One of the few fields PUT /orders/{id} may still change.
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
