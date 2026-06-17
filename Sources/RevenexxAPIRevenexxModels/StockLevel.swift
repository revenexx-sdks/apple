import Foundation
import JSONCodable

/// 
open class StockLevel: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case location_id = "location_id"
        case metadata = "metadata"
        case on_hand = "on_hand"
        case product_id = "product_id"
        case reorder_point = "reorder_point"
        case reserved = "reserved"
        case sku = "sku"
        case updated_at = "updated_at"
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
    public let on_hand: Double?
    /// 
    public let product_id: String?
    /// 
    public let reorder_point: Double?
    /// 
    public let reserved: Double?
    /// 
    public let sku: String?
    /// 
    public let updated_at: String?

    init(
        created_at: String?,
        id: String?,
        location_id: String?,
        metadata: [String: AnyCodable]?,
        on_hand: Double?,
        product_id: String?,
        reorder_point: Double?,
        reserved: Double?,
        sku: String?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.id = id
        self.location_id = location_id
        self.metadata = metadata
        self.on_hand = on_hand
        self.product_id = product_id
        self.reorder_point = reorder_point
        self.reserved = reserved
        self.sku = sku
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.location_id = try container.decodeIfPresent(String.self, forKey: .location_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.on_hand = try container.decodeIfPresent(Double.self, forKey: .on_hand)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.reorder_point = try container.decodeIfPresent(Double.self, forKey: .reorder_point)
        self.reserved = try container.decodeIfPresent(Double.self, forKey: .reserved)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(location_id, forKey: .location_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(on_hand, forKey: .on_hand)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(reorder_point, forKey: .reorder_point)
        try container.encodeIfPresent(reserved, forKey: .reserved)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "location_id": location_id as Any,
            "metadata": metadata as Any,
            "on_hand": on_hand as Any,
            "product_id": product_id as Any,
            "reorder_point": reorder_point as Any,
            "reserved": reserved as Any,
            "sku": sku as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> StockLevel {
        return StockLevel(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            location_id: map["location_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            on_hand: map["on_hand"] as? Double,
            product_id: map["product_id"] as? String,
            reorder_point: map["reorder_point"] as? Double,
            reserved: map["reserved"] as? Double,
            sku: map["sku"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
