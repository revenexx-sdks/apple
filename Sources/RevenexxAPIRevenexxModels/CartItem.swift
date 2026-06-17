import Foundation
import JSONCodable

/// 
open class CartItem: Codable {

    enum CodingKeys: String, CodingKey {
        case cart_id = "cart_id"
        case configuration = "configuration"
        case created_at = "created_at"
        case currency = "currency"
        case id = "id"
        case line_total = "line_total"
        case metadata = "metadata"
        case name = "name"
        case position = "position"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
        case snapshot = "snapshot"
        case tax_rate = "tax_rate"
        case type = "type"
        case unit = "unit"
        case unit_price = "unit_price"
        case updated_at = "updated_at"
    }

    /// 
    public let cart_id: String?
    /// 
    public let configuration: [String: AnyCodable]?
    /// 
    public let created_at: String?
    /// 
    public let currency: String?
    /// 
    public let id: String?
    /// 
    public let line_total: Double?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let position: Int?
    /// 
    public let product_id: String?
    /// 
    public let quantity: Double?
    /// 
    public let sku: String?
    /// 
    public let snapshot: [String: AnyCodable]?
    /// 
    public let tax_rate: Double?
    /// 
    public let type: String?
    /// 
    public let unit: String?
    /// 
    public let unit_price: Double?
    /// 
    public let updated_at: String?

    init(
        cart_id: String?,
        configuration: [String: AnyCodable]?,
        created_at: String?,
        currency: String?,
        id: String?,
        line_total: Double?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        product_id: String?,
        quantity: Double?,
        sku: String?,
        snapshot: [String: AnyCodable]?,
        tax_rate: Double?,
        type: String?,
        unit: String?,
        unit_price: Double?,
        updated_at: String?
    ) {
        self.cart_id = cart_id
        self.configuration = configuration
        self.created_at = created_at
        self.currency = currency
        self.id = id
        self.line_total = line_total
        self.metadata = metadata
        self.name = name
        self.position = position
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
        self.snapshot = snapshot
        self.tax_rate = tax_rate
        self.type = type
        self.unit = unit
        self.unit_price = unit_price
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.configuration = try container.decodeIfPresent([String: AnyCodable].self, forKey: .configuration)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.line_total = try container.decodeIfPresent(Double.self, forKey: .line_total)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.snapshot = try container.decodeIfPresent([String: AnyCodable].self, forKey: .snapshot)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(configuration, forKey: .configuration)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(line_total, forKey: .line_total)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(snapshot, forKey: .snapshot)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "cart_id": cart_id as Any,
            "configuration": configuration as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "id": id as Any,
            "line_total": line_total as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "snapshot": snapshot as Any,
            "tax_rate": tax_rate as Any,
            "type": type as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartItem {
        return CartItem(
            cart_id: map["cart_id"] as? String,
            configuration: map["configuration"] as? [String: AnyCodable],
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            id: map["id"] as? String,
            line_total: map["line_total"] as? Double,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String,
            snapshot: map["snapshot"] as? [String: AnyCodable],
            tax_rate: map["tax_rate"] as? Double,
            type: map["type"] as? String,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            updated_at: map["updated_at"] as? String
        )
    }
}
