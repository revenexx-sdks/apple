import Foundation
import JSONCodable

/// Narrow modification — only these columns are touchable, and only until the order is acknowledged. Status moves through the action routes.
open class OrderUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case billing_address = "billing_address"
        case buyer = "buyer"
        case customer_order_number = "customer_order_number"
        case metadata = "metadata"
        case shipping_address = "shipping_address"
        case user_data = "user_data"
    }

    /// 
    public let billing_address: [String: AnyCodable]?
    /// 
    public let buyer: [String: AnyCodable]?
    /// 
    public let customer_order_number: String?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// 
    public let shipping_address: [String: AnyCodable]?
    /// Free-form user data.
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
