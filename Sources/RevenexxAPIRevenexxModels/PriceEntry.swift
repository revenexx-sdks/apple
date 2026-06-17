import Foundation
import JSONCodable

/// 
open class PriceEntry: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case metadata = "metadata"
        case price_list_id = "price_list_id"
        case price_type = "price_type"
        case product_id = "product_id"
        case quantity_min = "quantity_min"
        case sku = "sku"
        case unit = "unit"
        case unit_price = "unit_price"
        case updated_at = "updated_at"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
    }

    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let price_list_id: String?
    /// 
    public let price_type: String?
    /// 
    public let product_id: String?
    /// 
    public let quantity_min: Double?
    /// 
    public let sku: String?
    /// 
    public let unit: String?
    /// 
    public let unit_price: Double?
    /// 
    public let updated_at: String?
    /// 
    public let valid_from: String?
    /// 
    public let valid_until: String?

    init(
        created_at: String?,
        id: String?,
        metadata: [String: AnyCodable]?,
        price_list_id: String?,
        price_type: String?,
        product_id: String?,
        quantity_min: Double?,
        sku: String?,
        unit: String?,
        unit_price: Double?,
        updated_at: String?,
        valid_from: String?,
        valid_until: String?
    ) {
        self.created_at = created_at
        self.id = id
        self.metadata = metadata
        self.price_list_id = price_list_id
        self.price_type = price_type
        self.product_id = product_id
        self.quantity_min = quantity_min
        self.sku = sku
        self.unit = unit
        self.unit_price = unit_price
        self.updated_at = updated_at
        self.valid_from = valid_from
        self.valid_until = valid_until
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.price_list_id = try container.decodeIfPresent(String.self, forKey: .price_list_id)
        self.price_type = try container.decodeIfPresent(String.self, forKey: .price_type)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity_min = try container.decodeIfPresent(Double.self, forKey: .quantity_min)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.valid_from = try container.decodeIfPresent(String.self, forKey: .valid_from)
        self.valid_until = try container.decodeIfPresent(String.self, forKey: .valid_until)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(price_list_id, forKey: .price_list_id)
        try container.encodeIfPresent(price_type, forKey: .price_type)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity_min, forKey: .quantity_min)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(valid_from, forKey: .valid_from)
        try container.encodeIfPresent(valid_until, forKey: .valid_until)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "metadata": metadata as Any,
            "price_list_id": price_list_id as Any,
            "price_type": price_type as Any,
            "product_id": product_id as Any,
            "quantity_min": quantity_min as Any,
            "sku": sku as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "updated_at": updated_at as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntry {
        return PriceEntry(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            price_list_id: map["price_list_id"] as? String,
            price_type: map["price_type"] as? String,
            product_id: map["product_id"] as? String,
            quantity_min: map["quantity_min"] as? Double,
            sku: map["sku"] as? String,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            updated_at: map["updated_at"] as? String,
            valid_from: map["valid_from"] as? String,
            valid_until: map["valid_until"] as? String
        )
    }
}
