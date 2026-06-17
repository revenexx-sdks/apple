import Foundation
import JSONCodable

/// A stock row tracks an item: &#039;product_id&#039; or &#039;sku&#039;.
open class StockLevelCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case location_id = "location_id"
        case metadata = "metadata"
        case on_hand = "on_hand"
        case product_id = "product_id"
        case reorder_point = "reorder_point"
        case reserved = "reserved"
        case sku = "sku"
    }

    /// Owning location.
    public let location_id: String
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Physical stock (default 0).
    public let on_hand: Double?
    /// Tracked product.
    public let product_id: String?
    /// 
    public let reorder_point: Double?
    /// Reserved stock (default 0) — normally managed by reserve/release/commit.
    public let reserved: Double?
    /// Tracked SKU (alternative to product_id).
    public let sku: String?

    init(
        location_id: String,
        metadata: [String: AnyCodable]?,
        on_hand: Double?,
        product_id: String?,
        reorder_point: Double?,
        reserved: Double?,
        sku: String?
    ) {
        self.location_id = location_id
        self.metadata = metadata
        self.on_hand = on_hand
        self.product_id = product_id
        self.reorder_point = reorder_point
        self.reserved = reserved
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.location_id = try container.decode(String.self, forKey: .location_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.on_hand = try container.decodeIfPresent(Double.self, forKey: .on_hand)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.reorder_point = try container.decodeIfPresent(Double.self, forKey: .reorder_point)
        self.reserved = try container.decodeIfPresent(Double.self, forKey: .reserved)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(location_id, forKey: .location_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(on_hand, forKey: .on_hand)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(reorder_point, forKey: .reorder_point)
        try container.encodeIfPresent(reserved, forKey: .reserved)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "location_id": location_id as Any,
            "metadata": metadata as Any,
            "on_hand": on_hand as Any,
            "product_id": product_id as Any,
            "reorder_point": reorder_point as Any,
            "reserved": reserved as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> StockLevelCreateRequest {
        return StockLevelCreateRequest(
            location_id: map["location_id"] as! String,
            metadata: map["metadata"] as? [String: AnyCodable],
            on_hand: map["on_hand"] as? Double,
            product_id: map["product_id"] as? String,
            reorder_point: map["reorder_point"] as? Double,
            reserved: map["reserved"] as? Double,
            sku: map["sku"] as? String
        )
    }
}
