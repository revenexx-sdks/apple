import Foundation
import JSONCodable

/// 
open class ProductTaxRef: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sku = "sku"
        case tax_class = "tax_class"
    }

    /// 
    public let id: String?
    /// 
    public let sku: String?
    /// 
    public let tax_class: String?

    init(
        id: String?,
        sku: String?,
        tax_class: String?
    ) {
        self.id = id
        self.sku = sku
        self.tax_class = tax_class
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "sku": sku as Any,
            "tax_class": tax_class as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductTaxRef {
        return ProductTaxRef(
            id: map["id"] as? String,
            sku: map["sku"] as? String,
            tax_class: map["tax_class"] as? String
        )
    }
}
