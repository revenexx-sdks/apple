import Foundation
import JSONCodable

/// 
open class CategoryRuleSample: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sku = "sku"
    }

    /// A matching product.
    public let id: String?
    /// Its SKU, so the sample is readable. Null only for a row whose SKU is unset, which the database does not allow.
    public let sku: String?

    init(
        id: String?,
        sku: String?
    ) {
        self.id = id
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CategoryRuleSample {
        return CategoryRuleSample(
            id: map["id"] as? String,
            sku: map["sku"] as? String
        )
    }
}
