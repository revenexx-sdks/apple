import Foundation
import JSONCodable

/// Narrow modification — these six columns and no others. Anything else in the body is ignored, and a body with none of them at all is a 400 naming the allowed set. A whole key REPLACES the value it names; there is no merge into an existing snapshot. Nothing here moves the order: status, payment and fulfillment travel through the action routes.
open class OrderUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case billing_address = "billing_address"
        case buyer = "buyer"
        case customer_order_number = "customer_order_number"
        case metadata = "metadata"
        case shipping_address = "shipping_address"
        case user_data = "user_data"
    }

    /// The invoice address, FROZEN at place-time. Changing the customer's address afterwards does not change what this order was billed to. Replaced wholesale — send the whole address, not a patch of it.
    public let billing_address: [String: AnyCodable]?
    /// The ordering party as it was at place-time, FROZEN: a copy, not a reference, so the order still reads correctly after the customer record is renamed, merged or deleted. The caller decides what goes in; this app stores it and reads nothing out of it. Replaced wholesale — send the whole snapshot, not a patch of it.
    public let buyer: [String: AnyCodable]?
    /// The BUYER's own reference — their purchase-order number. Free text, not unique, never generated here: it exists so the paperwork can carry the number the buyer's accounts payable will look for. One of the few fields PUT /orders/{id} may still change.
    public let customer_order_number: String?
    /// Free-form data belonging to the INTEGRATION side — an ERP's own bookkeeping about this order. Stored and returned untouched; nothing here reads it. Replaced wholesale.
    public let metadata: [String: AnyCodable]?
    /// The delivery address, FROZEN at place-time — what goes on the label of every shipment of this order. Null on an order that is never delivered (a service, a digital item, a collection). Replaced wholesale. This is the one correction that actually matters after placement: the label of every shipment still to go out is printed from it.
    public let shipping_address: [String: AnyCodable]?
    /// Free-form data belonging to the ORDERING side — carried through from the storefront or the cart and handed back untouched. One of the few fields PUT /orders/{id} may still change. Replaced wholesale.
    public let user_data: [String: AnyCodable]?

    init(
        billing_address: [String: AnyCodable]?,
        buyer: [String: AnyCodable]?,
        customer_order_number: String?,
        metadata: [String: AnyCodable]?,
        shipping_address: [String: AnyCodable]?,
        user_data: [String: AnyCodable]?
    ) {
        self.billing_address = billing_address
        self.buyer = buyer
        self.customer_order_number = customer_order_number
        self.metadata = metadata
        self.shipping_address = shipping_address
        self.user_data = user_data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.billing_address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .billing_address)
        self.buyer = try container.decodeIfPresent([String: AnyCodable].self, forKey: .buyer)
        self.customer_order_number = try container.decodeIfPresent(String.self, forKey: .customer_order_number)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.shipping_address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .shipping_address)
        self.user_data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user_data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(billing_address, forKey: .billing_address)
        try container.encodeIfPresent(buyer, forKey: .buyer)
        try container.encodeIfPresent(customer_order_number, forKey: .customer_order_number)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(shipping_address, forKey: .shipping_address)
        try container.encodeIfPresent(user_data, forKey: .user_data)
    }

    public func toMap() -> [String: Any] {
        return [
            "billing_address": billing_address as Any,
            "buyer": buyer as Any,
            "customer_order_number": customer_order_number as Any,
            "metadata": metadata as Any,
            "shipping_address": shipping_address as Any,
            "user_data": user_data as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderUpdateRequest {
        return OrderUpdateRequest(
            billing_address: map["billing_address"] as? [String: AnyCodable],
            buyer: map["buyer"] as? [String: AnyCodable],
            customer_order_number: map["customer_order_number"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            shipping_address: map["shipping_address"] as? [String: AnyCodable],
            user_data: map["user_data"] as? [String: AnyCodable]
        )
    }
}
