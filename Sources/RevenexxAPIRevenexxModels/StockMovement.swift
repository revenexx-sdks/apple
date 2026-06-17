import Foundation
import JSONCodable

/// 
open class StockMovement: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case location_id = "location_id"
        case metadata = "metadata"
        case order_ref = "order_ref"
        case product_id = "product_id"
        case quantity = "quantity"
        case reason = "reason"
        case sku = "sku"
        case type = "type"
    }

    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let location_id: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let order_ref: String?
    /// 
    public let product_id: String?
    /// 
    public let quantity: Double?
    /// 
    public let reason: String?
    /// 
    public let sku: String?
    /// 
    public let type: String?

    init(
        created_at: String?,
        id: String?,
        location_id: String?,
        metadata: [String: AnyCodable]?,
        order_ref: String?,
        product_id: String?,
        quantity: Double?,
        reason: String?,
        sku: String?,
        type: String?
    ) {
        self.created_at = created_at
        self.id = id
        self.location_id = location_id
        self.metadata = metadata
        self.order_ref = order_ref
        self.product_id = product_id
        self.quantity = quantity
        self.reason = reason
        self.sku = sku
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.location_id = try container.decodeIfPresent(String.self, forKey: .location_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(location_id, forKey: .location_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "location_id": location_id as Any,
            "metadata": metadata as Any,
            "order_ref": order_ref as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "reason": reason as Any,
            "sku": sku as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> StockMovement {
        return StockMovement(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            location_id: map["location_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            order_ref: map["order_ref"] as? String,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            reason: map["reason"] as? String,
            sku: map["sku"] as? String,
            type: map["type"] as? String
        )
    }
}
