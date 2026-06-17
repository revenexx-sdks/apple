import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// A position of the placed order — needs an identity: &#039;name&#039; or &#039;sku&#039;. Items are SNAPSHOTS: carry the product copy, prices are frozen at place-time.
open class OrderItemCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case configuration = "configuration"
        case cost_center = "cost_center"
        case metadata = "metadata"
        case name = "name"
        case position = "position"
        case position_text = "position_text"
        case product = "product"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
        case snapshot = "snapshot"
        case tax_amount = "tax_amount"
        case tax_rate = "tax_rate"
        case type = "type"
        case unit = "unit"
        case unit_price = "unit_price"
        case user_data = "user_data"
    }

    /// Free-form configuration of configured lines.
    public let configuration: [String: AnyCodable]?
    /// 
    public let cost_center: String?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Falls back to &#039;sku&#039; when omitted.
    public let name: String?
    /// Explicit position number; otherwise numbered in steps of the order range&#039;s position_step.
    public let position: Int?
    /// 
    public let position_text: String?
    /// Frozen product snapshot at place-time (&#039;snapshot&#039; is accepted as an alias).
    public let product: [String: AnyCodable]?
    /// 
    public let product_id: String?
    /// Default 1.
    public let quantity: Double?
    /// 
    public let sku: String?
    /// Alias for &#039;product&#039;.
    public let snapshot: [String: AnyCodable]?
    /// Derived from line_total and tax_rate when omitted.
    public let tax_amount: Double?
    /// Percent (default 0).
    public let tax_rate: Double?
    /// Line type (default &#039;product&#039;).
    public let type: Revenexx API — revenexxEnums.OrderItemType?
    /// 
    public let unit: String?
    /// Per-unit net price — line_total is always derived.
    public let unit_price: Double?
    /// Free-form user data.
    public let user_data: [String: AnyCodable]?

    init(
        configuration: [String: AnyCodable]?,
        cost_center: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        position_text: String?,
        product: [String: AnyCodable]?,
        product_id: String?,
        quantity: Double?,
        sku: String?,
        snapshot: [String: AnyCodable]?,
        tax_amount: Double?,
        tax_rate: Double?,
        type: Revenexx API — revenexxEnums.OrderItemType?,
        unit: String?,
        unit_price: Double?,
        user_data: [String: AnyCodable]?
    ) {
        self.configuration = configuration
        self.cost_center = cost_center
        self.metadata = metadata
        self.name = name
        self.position = position
        self.position_text = position_text
        self.product = product
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
        self.snapshot = snapshot
        self.tax_amount = tax_amount
        self.tax_rate = tax_rate
        self.type = type
        self.unit = unit
        self.unit_price = unit_price
        self.user_data = user_data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.configuration = try container.decodeIfPresent([String: AnyCodable].self, forKey: .configuration)
        self.cost_center = try container.decodeIfPresent(String.self, forKey: .cost_center)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.position_text = try container.decodeIfPresent(String.self, forKey: .position_text)
        self.product = try container.decodeIfPresent([String: AnyCodable].self, forKey: .product)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.snapshot = try container.decodeIfPresent([String: AnyCodable].self, forKey: .snapshot)
        self.tax_amount = try container.decodeIfPresent(Double.self, forKey: .tax_amount)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = Revenexx API — revenexxEnums.OrderItemType(rawValue: typeString)
        } else {
            self.type = nil
        }
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.user_data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user_data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(configuration, forKey: .configuration)
        try container.encodeIfPresent(cost_center, forKey: .cost_center)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(position_text, forKey: .position_text)
        try container.encodeIfPresent(product, forKey: .product)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(snapshot, forKey: .snapshot)
        try container.encodeIfPresent(tax_amount, forKey: .tax_amount)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(user_data, forKey: .user_data)
    }

    public func toMap() -> [String: Any] {
        return [
            "configuration": configuration as Any,
            "cost_center": cost_center as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "position_text": position_text as Any,
            "product": product as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "snapshot": snapshot as Any,
            "tax_amount": tax_amount as Any,
            "tax_rate": tax_rate as Any,
            "type": type?.rawValue as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "user_data": user_data as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderItemCreateRequest {
        return OrderItemCreateRequest(
            configuration: map["configuration"] as? [String: AnyCodable],
            cost_center: map["cost_center"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            position_text: map["position_text"] as? String,
            product: map["product"] as? [String: AnyCodable],
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String,
            snapshot: map["snapshot"] as? [String: AnyCodable],
            tax_amount: map["tax_amount"] as? Double,
            tax_rate: map["tax_rate"] as? Double,
            type: map["type"] as? String != nil ? OrderItemType(rawValue: map["type"] as! String) : nil,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            user_data: map["user_data"] as? [String: AnyCodable]
        )
    }
}
