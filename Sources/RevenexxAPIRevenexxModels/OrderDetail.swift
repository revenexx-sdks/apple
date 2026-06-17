import Foundation
import JSONCodable

/// The order aggregate: every column of the order plus its items, shipments (with positions), returns and cancellations.
open class OrderDetail: Codable {

    enum CodingKeys: String, CodingKey {
        case acknowledged_at = "acknowledged_at"
        case billing_address = "billing_address"
        case buyer = "buyer"
        case cancellations = "cancellations"
        case cancelled_at = "cancelled_at"
        case cart_id = "cart_id"
        case channel_id = "channel_id"
        case completed_at = "completed_at"
        case contact_id = "contact_id"
        case created_at = "created_at"
        case currency = "currency"
        case customer_order_number = "customer_order_number"
        case external_ref = "external_ref"
        case fulfillment_status = "fulfillment_status"
        case grand_total = "grand_total"
        case hold_reason = "hold_reason"
        case id = "id"
        case item_count = "item_count"
        case items = "items"
        case market_id = "market_id"
        case metadata = "metadata"
        case number = "number"
        case on_hold = "on_hold"
        case organization_id = "organization_id"
        case payment = "payment"
        case payment_status = "payment_status"
        case placed_at = "placed_at"
        case returns = "returns"
        case shipments = "shipments"
        case shipping = "shipping"
        case shipping_address = "shipping_address"
        case shipping_total = "shipping_total"
        case status = "status"
        case subtotal = "subtotal"
        case tax_total = "tax_total"
        case updated_at = "updated_at"
        case user_data = "user_data"
    }

    /// 
    public let acknowledged_at: String?
    /// 
    public let billing_address: [String: AnyCodable]?
    /// 
    public let buyer: [String: AnyCodable]?
    /// 
    public let cancellations: [OrderCancellation]?
    /// 
    public let cancelled_at: String?
    /// 
    public let cart_id: String?
    /// 
    public let channel_id: String?
    /// 
    public let completed_at: String?
    /// 
    public let contact_id: String?
    /// 
    public let created_at: String?
    /// 
    public let currency: String?
    /// 
    public let customer_order_number: String?
    /// 
    public let external_ref: String?
    /// 
    public let fulfillment_status: String?
    /// 
    public let grand_total: Double?
    /// 
    public let hold_reason: String?
    /// 
    public let id: String?
    /// 
    public let item_count: Int?
    /// 
    public let items: [OrderItem]?
    /// 
    public let market_id: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let number: String?
    /// 
    public let on_hold: Bool?
    /// 
    public let organization_id: String?
    /// 
    public let payment: [String: AnyCodable]?
    /// 
    public let payment_status: String?
    /// 
    public let placed_at: String?
    /// 
    public let returns: [OrderReturn]?
    /// 
    public let shipments: [OrderShipment]?
    /// 
    public let shipping: [String: AnyCodable]?
    /// 
    public let shipping_address: [String: AnyCodable]?
    /// 
    public let shipping_total: Double?
    /// 
    public let status: String?
    /// 
    public let subtotal: Double?
    /// 
    public let tax_total: Double?
    /// 
    public let updated_at: String?
    /// 
    public let user_data: [String: AnyCodable]?

    init(
        acknowledged_at: String?,
        billing_address: [String: AnyCodable]?,
        buyer: [String: AnyCodable]?,
        cancellations: [OrderCancellation]?,
        cancelled_at: String?,
        cart_id: String?,
        channel_id: String?,
        completed_at: String?,
        contact_id: String?,
        created_at: String?,
        currency: String?,
        customer_order_number: String?,
        external_ref: String?,
        fulfillment_status: String?,
        grand_total: Double?,
        hold_reason: String?,
        id: String?,
        item_count: Int?,
        items: [OrderItem]?,
        market_id: String?,
        metadata: [String: AnyCodable]?,
        number: String?,
        on_hold: Bool?,
        organization_id: String?,
        payment: [String: AnyCodable]?,
        payment_status: String?,
        placed_at: String?,
        returns: [OrderReturn]?,
        shipments: [OrderShipment]?,
        shipping: [String: AnyCodable]?,
        shipping_address: [String: AnyCodable]?,
        shipping_total: Double?,
        status: String?,
        subtotal: Double?,
        tax_total: Double?,
        updated_at: String?,
        user_data: [String: AnyCodable]?
    ) {
        self.acknowledged_at = acknowledged_at
        self.billing_address = billing_address
        self.buyer = buyer
        self.cancellations = cancellations
        self.cancelled_at = cancelled_at
        self.cart_id = cart_id
        self.channel_id = channel_id
        self.completed_at = completed_at
        self.contact_id = contact_id
        self.created_at = created_at
        self.currency = currency
        self.customer_order_number = customer_order_number
        self.external_ref = external_ref
        self.fulfillment_status = fulfillment_status
        self.grand_total = grand_total
        self.hold_reason = hold_reason
        self.id = id
        self.item_count = item_count
        self.items = items
        self.market_id = market_id
        self.metadata = metadata
        self.number = number
        self.on_hold = on_hold
        self.organization_id = organization_id
        self.payment = payment
        self.payment_status = payment_status
        self.placed_at = placed_at
        self.returns = returns
        self.shipments = shipments
        self.shipping = shipping
        self.shipping_address = shipping_address
        self.shipping_total = shipping_total
        self.status = status
        self.subtotal = subtotal
        self.tax_total = tax_total
        self.updated_at = updated_at
        self.user_data = user_data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.acknowledged_at = try container.decodeIfPresent(String.self, forKey: .acknowledged_at)
        self.billing_address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .billing_address)
        self.buyer = try container.decodeIfPresent([String: AnyCodable].self, forKey: .buyer)
        self.cancellations = try container.decodeIfPresent([OrderCancellation].self, forKey: .cancellations)
        self.cancelled_at = try container.decodeIfPresent(String.self, forKey: .cancelled_at)
        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.completed_at = try container.decodeIfPresent(String.self, forKey: .completed_at)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.customer_order_number = try container.decodeIfPresent(String.self, forKey: .customer_order_number)
        self.external_ref = try container.decodeIfPresent(String.self, forKey: .external_ref)
        self.fulfillment_status = try container.decodeIfPresent(String.self, forKey: .fulfillment_status)
        self.grand_total = try container.decodeIfPresent(Double.self, forKey: .grand_total)
        self.hold_reason = try container.decodeIfPresent(String.self, forKey: .hold_reason)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.item_count = try container.decodeIfPresent(Int.self, forKey: .item_count)
        self.items = try container.decodeIfPresent([OrderItem].self, forKey: .items)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.on_hold = try container.decodeIfPresent(Bool.self, forKey: .on_hold)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.payment = try container.decodeIfPresent([String: AnyCodable].self, forKey: .payment)
        self.payment_status = try container.decodeIfPresent(String.self, forKey: .payment_status)
        self.placed_at = try container.decodeIfPresent(String.self, forKey: .placed_at)
        self.returns = try container.decodeIfPresent([OrderReturn].self, forKey: .returns)
        self.shipments = try container.decodeIfPresent([OrderShipment].self, forKey: .shipments)
        self.shipping = try container.decodeIfPresent([String: AnyCodable].self, forKey: .shipping)
        self.shipping_address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .shipping_address)
        self.shipping_total = try container.decodeIfPresent(Double.self, forKey: .shipping_total)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.subtotal = try container.decodeIfPresent(Double.self, forKey: .subtotal)
        self.tax_total = try container.decodeIfPresent(Double.self, forKey: .tax_total)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.user_data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user_data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(acknowledged_at, forKey: .acknowledged_at)
        try container.encodeIfPresent(billing_address, forKey: .billing_address)
        try container.encodeIfPresent(buyer, forKey: .buyer)
        try container.encodeIfPresent(cancellations, forKey: .cancellations)
        try container.encodeIfPresent(cancelled_at, forKey: .cancelled_at)
        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(completed_at, forKey: .completed_at)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(customer_order_number, forKey: .customer_order_number)
        try container.encodeIfPresent(external_ref, forKey: .external_ref)
        try container.encodeIfPresent(fulfillment_status, forKey: .fulfillment_status)
        try container.encodeIfPresent(grand_total, forKey: .grand_total)
        try container.encodeIfPresent(hold_reason, forKey: .hold_reason)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(item_count, forKey: .item_count)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(on_hold, forKey: .on_hold)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(payment, forKey: .payment)
        try container.encodeIfPresent(payment_status, forKey: .payment_status)
        try container.encodeIfPresent(placed_at, forKey: .placed_at)
        try container.encodeIfPresent(returns, forKey: .returns)
        try container.encodeIfPresent(shipments, forKey: .shipments)
        try container.encodeIfPresent(shipping, forKey: .shipping)
        try container.encodeIfPresent(shipping_address, forKey: .shipping_address)
        try container.encodeIfPresent(shipping_total, forKey: .shipping_total)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(subtotal, forKey: .subtotal)
        try container.encodeIfPresent(tax_total, forKey: .tax_total)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(user_data, forKey: .user_data)
    }

    public func toMap() -> [String: Any] {
        return [
            "acknowledged_at": acknowledged_at as Any,
            "billing_address": billing_address as Any,
            "buyer": buyer as Any,
            "cancellations": cancellations.map { $0.toMap() } as Any,
            "cancelled_at": cancelled_at as Any,
            "cart_id": cart_id as Any,
            "channel_id": channel_id as Any,
            "completed_at": completed_at as Any,
            "contact_id": contact_id as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "customer_order_number": customer_order_number as Any,
            "external_ref": external_ref as Any,
            "fulfillment_status": fulfillment_status as Any,
            "grand_total": grand_total as Any,
            "hold_reason": hold_reason as Any,
            "id": id as Any,
            "item_count": item_count as Any,
            "items": items.map { $0.toMap() } as Any,
            "market_id": market_id as Any,
            "metadata": metadata as Any,
            "number": number as Any,
            "on_hold": on_hold as Any,
            "organization_id": organization_id as Any,
            "payment": payment as Any,
            "payment_status": payment_status as Any,
            "placed_at": placed_at as Any,
            "returns": returns.map { $0.toMap() } as Any,
            "shipments": shipments.map { $0.toMap() } as Any,
            "shipping": shipping as Any,
            "shipping_address": shipping_address as Any,
            "shipping_total": shipping_total as Any,
            "status": status as Any,
            "subtotal": subtotal as Any,
            "tax_total": tax_total as Any,
            "updated_at": updated_at as Any,
            "user_data": user_data as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderDetail {
        return OrderDetail(
            acknowledged_at: map["acknowledged_at"] as? String,
            billing_address: map["billing_address"] as? [String: AnyCodable],
            buyer: map["buyer"] as? [String: AnyCodable],
            cancellations: (map["cancellations"] as? [[String: Any]] ?? []).map { OrderCancellation.from(map: $0) },
            cancelled_at: map["cancelled_at"] as? String,
            cart_id: map["cart_id"] as? String,
            channel_id: map["channel_id"] as? String,
            completed_at: map["completed_at"] as? String,
            contact_id: map["contact_id"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            customer_order_number: map["customer_order_number"] as? String,
            external_ref: map["external_ref"] as? String,
            fulfillment_status: map["fulfillment_status"] as? String,
            grand_total: map["grand_total"] as? Double,
            hold_reason: map["hold_reason"] as? String,
            id: map["id"] as? String,
            item_count: map["item_count"] as? Int,
            items: (map["items"] as? [[String: Any]] ?? []).map { OrderItem.from(map: $0) },
            market_id: map["market_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            number: map["number"] as? String,
            on_hold: map["on_hold"] as? Bool,
            organization_id: map["organization_id"] as? String,
            payment: map["payment"] as? [String: AnyCodable],
            payment_status: map["payment_status"] as? String,
            placed_at: map["placed_at"] as? String,
            returns: (map["returns"] as? [[String: Any]] ?? []).map { OrderReturn.from(map: $0) },
            shipments: (map["shipments"] as? [[String: Any]] ?? []).map { OrderShipment.from(map: $0) },
            shipping: map["shipping"] as? [String: AnyCodable],
            shipping_address: map["shipping_address"] as? [String: AnyCodable],
            shipping_total: map["shipping_total"] as? Double,
            status: map["status"] as? String,
            subtotal: map["subtotal"] as? Double,
            tax_total: map["tax_total"] as? Double,
            updated_at: map["updated_at"] as? String,
            user_data: map["user_data"] as? [String: AnyCodable]
        )
    }
}
