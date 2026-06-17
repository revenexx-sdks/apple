import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// Partial update — omitted fields keep their current value.
open class CartItemUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case configuration = "configuration"
        case currency = "currency"
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
    }

    /// Free-form configuration — configured lines never merge.
    public let configuration: [String: AnyCodable]?
    /// Defaults to the cart&#039;s currency.
    public let currency: String?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Falls back to &#039;sku&#039; when omitted.
    public let name: String?
    /// 
    public let position: Int?
    /// 
    public let product_id: String?
    /// Default 1.
    public let quantity: Double?
    /// 
    public let sku: String?
    /// Loose product snapshot at add-time (price, name, image, …).
    public let snapshot: [String: AnyCodable]?
    /// 
    public let tax_rate: Double?
    /// Line type (default &#039;product&#039;). Plain product lines merge by product+price; configurations always stand alone.
    public let type: Revenexx API — revenexxEnums.CartItemType?
    /// 
    public let unit: String?
    /// Per-unit net price — line_total is always derived.
    public let unit_price: Double?

    init(
        configuration: [String: AnyCodable]?,
        currency: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        product_id: String?,
        quantity: Double?,
        sku: String?,
        snapshot: [String: AnyCodable]?,
        tax_rate: Double?,
        type: Revenexx API — revenexxEnums.CartItemType?,
        unit: String?,
        unit_price: Double?
    ) {
        self.configuration = configuration
        self.currency = currency
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
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.configuration = try container.decodeIfPresent([String: AnyCodable].self, forKey: .configuration)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.snapshot = try container.decodeIfPresent([String: AnyCodable].self, forKey: .snapshot)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = Revenexx API — revenexxEnums.CartItemType(rawValue: typeString)
        } else {
            self.type = nil
        }
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(configuration, forKey: .configuration)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(snapshot, forKey: .snapshot)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
    }

    public func toMap() -> [String: Any] {
        return [
            "configuration": configuration as Any,
            "currency": currency as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "snapshot": snapshot as Any,
            "tax_rate": tax_rate as Any,
            "type": type?.rawValue as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartItemUpdateRequest {
        return CartItemUpdateRequest(
            configuration: map["configuration"] as? [String: AnyCodable],
            currency: map["currency"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String,
            snapshot: map["snapshot"] as? [String: AnyCodable],
            tax_rate: map["tax_rate"] as? Double,
            type: map["type"] as? String != nil ? CartItemType(rawValue: map["type"] as! String) : nil,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double
        )
    }
}
