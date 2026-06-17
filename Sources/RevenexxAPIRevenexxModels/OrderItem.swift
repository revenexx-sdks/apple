import Foundation
import JSONCodable

/// 
open class OrderItem: Codable {

    enum CodingKeys: String, CodingKey {
        case configuration = "configuration"
        case cost_center = "cost_center"
        case created_at = "created_at"
        case id = "id"
        case line_total = "line_total"
        case metadata = "metadata"
        case name = "name"
        case order_id = "order_id"
        case position = "position"
        case position_text = "position_text"
        case product = "product"
        case product_id = "product_id"
        case quantity = "quantity"
        case quantity_cancelled = "quantity_cancelled"
        case quantity_returned = "quantity_returned"
        case quantity_shipped = "quantity_shipped"
        case sku = "sku"
        case tax_amount = "tax_amount"
        case tax_rate = "tax_rate"
        case type = "type"
        case unit = "unit"
        case unit_price = "unit_price"
        case updated_at = "updated_at"
        case user_data = "user_data"
    }

    /// 
    public let configuration: [String: AnyCodable]?
    /// 
    public let cost_center: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let line_total: Double?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let order_id: String?
    /// 
    public let position: Int?
    /// 
    public let position_text: String?
    /// 
    public let product: [String: AnyCodable]?
    /// 
    public let product_id: String?
    /// 
    public let quantity: Double?
    /// 
    public let quantity_cancelled: Double?
    /// 
    public let quantity_returned: Double?
    /// 
    public let quantity_shipped: Double?
    /// 
    public let sku: String?
    /// 
    public let tax_amount: Double?
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
    /// 
    public let user_data: [String: AnyCodable]?

    init(
        configuration: [String: AnyCodable]?,
        cost_center: String?,
        created_at: String?,
        id: String?,
        line_total: Double?,
        metadata: [String: AnyCodable]?,
        name: String?,
        order_id: String?,
        position: Int?,
        position_text: String?,
        product: [String: AnyCodable]?,
        product_id: String?,
        quantity: Double?,
        quantity_cancelled: Double?,
        quantity_returned: Double?,
        quantity_shipped: Double?,
        sku: String?,
        tax_amount: Double?,
        tax_rate: Double?,
        type: String?,
        unit: String?,
        unit_price: Double?,
        updated_at: String?,
        user_data: [String: AnyCodable]?
    ) {
        self.configuration = configuration
        self.cost_center = cost_center
        self.created_at = created_at
        self.id = id
        self.line_total = line_total
        self.metadata = metadata
        self.name = name
        self.order_id = order_id
        self.position = position
        self.position_text = position_text
        self.product = product
        self.product_id = product_id
        self.quantity = quantity
        self.quantity_cancelled = quantity_cancelled
        self.quantity_returned = quantity_returned
        self.quantity_shipped = quantity_shipped
        self.sku = sku
        self.tax_amount = tax_amount
        self.tax_rate = tax_rate
        self.type = type
        self.unit = unit
        self.unit_price = unit_price
        self.updated_at = updated_at
        self.user_data = user_data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.configuration = try container.decodeIfPresent([String: AnyCodable].self, forKey: .configuration)
        self.cost_center = try container.decodeIfPresent(String.self, forKey: .cost_center)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.line_total = try container.decodeIfPresent(Double.self, forKey: .line_total)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.position_text = try container.decodeIfPresent(String.self, forKey: .position_text)
        self.product = try container.decodeIfPresent([String: AnyCodable].self, forKey: .product)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.quantity_cancelled = try container.decodeIfPresent(Double.self, forKey: .quantity_cancelled)
        self.quantity_returned = try container.decodeIfPresent(Double.self, forKey: .quantity_returned)
        self.quantity_shipped = try container.decodeIfPresent(Double.self, forKey: .quantity_shipped)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.tax_amount = try container.decodeIfPresent(Double.self, forKey: .tax_amount)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.user_data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user_data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(configuration, forKey: .configuration)
        try container.encodeIfPresent(cost_center, forKey: .cost_center)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(line_total, forKey: .line_total)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(position_text, forKey: .position_text)
        try container.encodeIfPresent(product, forKey: .product)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(quantity_cancelled, forKey: .quantity_cancelled)
        try container.encodeIfPresent(quantity_returned, forKey: .quantity_returned)
        try container.encodeIfPresent(quantity_shipped, forKey: .quantity_shipped)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(tax_amount, forKey: .tax_amount)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(user_data, forKey: .user_data)
    }

    public func toMap() -> [String: Any] {
        return [
            "configuration": configuration as Any,
            "cost_center": cost_center as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "line_total": line_total as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "order_id": order_id as Any,
            "position": position as Any,
            "position_text": position_text as Any,
            "product": product as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "quantity_cancelled": quantity_cancelled as Any,
            "quantity_returned": quantity_returned as Any,
            "quantity_shipped": quantity_shipped as Any,
            "sku": sku as Any,
            "tax_amount": tax_amount as Any,
            "tax_rate": tax_rate as Any,
            "type": type as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "updated_at": updated_at as Any,
            "user_data": user_data as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderItem {
        return OrderItem(
            configuration: map["configuration"] as? [String: AnyCodable],
            cost_center: map["cost_center"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            line_total: map["line_total"] as? Double,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            order_id: map["order_id"] as? String,
            position: map["position"] as? Int,
            position_text: map["position_text"] as? String,
            product: map["product"] as? [String: AnyCodable],
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            quantity_cancelled: map["quantity_cancelled"] as? Double,
            quantity_returned: map["quantity_returned"] as? Double,
            quantity_shipped: map["quantity_shipped"] as? Double,
            sku: map["sku"] as? String,
            tax_amount: map["tax_amount"] as? Double,
            tax_rate: map["tax_rate"] as? Double,
            type: map["type"] as? String,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            updated_at: map["updated_at"] as? String,
            user_data: map["user_data"] as? [String: AnyCodable]
        )
    }
}
