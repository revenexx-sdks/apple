import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// An entry needs an identity: &#039;product_id&#039; or &#039;sku&#039;.
open class PriceEntryCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case price_type = "price_type"
        case product_id = "product_id"
        case quantity_min = "quantity_min"
        case sku = "sku"
        case unit = "unit"
        case unit_price = "unit_price"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
    }

    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Default &#039;standard&#039;; &#039;on_request&#039; is the explicit no-price marker — it stops resolution and answers &quot;price on request&quot;.
    public let price_type: Revenexx API — revenexxEnums.PriceEntryType?
    /// Priced product.
    public let product_id: String?
    /// Tier threshold (Staffelpreis): this price applies from this quantity (default 1).
    public let quantity_min: Double?
    /// Priced SKU (alternative to product_id).
    public let sku: String?
    /// 
    public let unit: String?
    /// Per-unit price (default 0).
    public let unit_price: Double?
    /// Per-entry validity start (promo prices).
    public let valid_from: String?
    /// Per-entry validity end.
    public let valid_until: String?

    init(
        metadata: [String: AnyCodable]?,
        price_type: Revenexx API — revenexxEnums.PriceEntryType?,
        product_id: String?,
        quantity_min: Double?,
        sku: String?,
        unit: String?,
        unit_price: Double?,
        valid_from: String?,
        valid_until: String?
    ) {
        self.metadata = metadata
        self.price_type = price_type
        self.product_id = product_id
        self.quantity_min = quantity_min
        self.sku = sku
        self.unit = unit
        self.unit_price = unit_price
        self.valid_from = valid_from
        self.valid_until = valid_until
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        if let price_typeString = try container.decodeIfPresent(String.self, forKey: .price_type) {
            self.price_type = Revenexx API — revenexxEnums.PriceEntryType(rawValue: price_typeString)
        } else {
            self.price_type = nil
        }
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity_min = try container.decodeIfPresent(Double.self, forKey: .quantity_min)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.valid_from = try container.decodeIfPresent(String.self, forKey: .valid_from)
        self.valid_until = try container.decodeIfPresent(String.self, forKey: .valid_until)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(price_type?.rawValue, forKey: .price_type)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity_min, forKey: .quantity_min)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(valid_from, forKey: .valid_from)
        try container.encodeIfPresent(valid_until, forKey: .valid_until)
    }

    public func toMap() -> [String: Any] {
        return [
            "metadata": metadata as Any,
            "price_type": price_type?.rawValue as Any,
            "product_id": product_id as Any,
            "quantity_min": quantity_min as Any,
            "sku": sku as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntryCreateRequest {
        return PriceEntryCreateRequest(
            metadata: map["metadata"] as? [String: AnyCodable],
            price_type: map["price_type"] as? String != nil ? PriceEntryType(rawValue: map["price_type"] as! String) : nil,
            product_id: map["product_id"] as? String,
            quantity_min: map["quantity_min"] as? Double,
            sku: map["sku"] as? String,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            valid_from: map["valid_from"] as? String,
            valid_until: map["valid_until"] as? String
        )
    }
}
