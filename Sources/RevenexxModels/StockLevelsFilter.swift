import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `stock_levels` — a typo, a filter another entity has, `?q=` — is DROPPED and cannot appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class StockLevelsFilter<T : Codable>: Codable {

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
        case data
    }

    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?location_id=` value this call was understood to carry.
    public let location_id: String?
    /// The literal `?metadata=` value this call was understood to carry.
    public let metadata: String?
    /// The literal `?on_hand=` value this call was understood to carry.
    public let on_hand: String?
    /// The literal `?product_id=` value this call was understood to carry.
    public let product_id: String?
    /// The literal `?reorder_point=` value this call was understood to carry.
    public let reorder_point: String?
    /// The literal `?reserved=` value this call was understood to carry.
    public let reserved: String?
    /// The literal `?sku=` value this call was understood to carry.
    public let sku: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        created_at: String?,
        id: String?,
        location_id: String?,
        metadata: String?,
        on_hand: String?,
        product_id: String?,
        reorder_point: String?,
        reserved: String?,
        sku: String?,
        updated_at: String?,
        data: T
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
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.location_id = try container.decodeIfPresent(String.self, forKey: .location_id)
        self.metadata = try container.decodeIfPresent(String.self, forKey: .metadata)
        self.on_hand = try container.decodeIfPresent(String.self, forKey: .on_hand)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.reorder_point = try container.decodeIfPresent(String.self, forKey: .reorder_point)
        self.reserved = try container.decodeIfPresent(String.self, forKey: .reserved)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
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
        try container.encode(data, forKey: .data)
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
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> StockLevelsFilter {
        return StockLevelsFilter(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            location_id: map["location_id"] as? String,
            metadata: map["metadata"] as? String,
            on_hand: map["on_hand"] as? String,
            product_id: map["product_id"] as? String,
            reorder_point: map["reorder_point"] as? String,
            reserved: map["reserved"] as? String,
            sku: map["sku"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
