import Foundation
import JSONCodable

/// 
open class ProductTaxRef: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case label = "label"
        case sku = "sku"
        case tax_class = "tax_class"
    }

    /// The product's id.
    public let id: String?
    /// The product's resolved display name, or its SKU when the catalog holds no name for it.
    public let label: String?
    /// The SKU, so a caller that asked by id can key its own answer by SKU and the other way round.
    public let sku: String?
    /// The tax class key the prices app resolves a rate from. Null means the product names none and the caller has to fall back to its own default.
    public let tax_class: String?

    init(
        id: String?,
        label: String?,
        sku: String?,
        tax_class: String?
    ) {
        self.id = id
        self.label = label
        self.sku = sku
        self.tax_class = tax_class
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "label": label as Any,
            "sku": sku as Any,
            "tax_class": tax_class as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductTaxRef {
        return ProductTaxRef(
            id: map["id"] as? String,
            label: map["label"] as? String,
            sku: map["sku"] as? String,
            tax_class: map["tax_class"] as? String
        )
    }
}
