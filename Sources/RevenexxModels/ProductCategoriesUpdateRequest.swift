import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — omitted fields keep their current value.
open class ProductCategoriesUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case category_id = "category_id"
        case position = "position"
        case product_id = "product_id"
        case source = "source"
    }

    /// The category it is filed into. One row per (product, category), whichever way it got there.
    public let category_id: String?
    /// Sort order of this product inside the category.
    public let position: Int?
    /// The product filed into the category. Deleting the product deletes the membership with it.
    public let product_id: String?
    /// How the membership came about: 'manual' is hand-picked, 'rule' was materialized by a category rule. The two never touch each other — a recompute only ever inserts and deletes `rule` rows, so a hand-picked membership survives every pass.
    public let source: RevenexxEnums.ProductCategoriesSource?

    init(
        category_id: String?,
        position: Int?,
        product_id: String?,
        source: RevenexxEnums.ProductCategoriesSource?
    ) {
        self.category_id = category_id
        self.position = position
        self.product_id = product_id
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.category_id = try container.decodeIfPresent(String.self, forKey: .category_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.ProductCategoriesSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(category_id, forKey: .category_id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "category_id": category_id as Any,
            "position": position as Any,
            "product_id": product_id as Any,
            "source": source?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductCategoriesUpdateRequest {
        return ProductCategoriesUpdateRequest(
            category_id: map["category_id"] as? String,
            position: map["position"] as? Int,
            product_id: map["product_id"] as? String,
            source: map["source"] as? String != nil ? ProductCategoriesSource(rawValue: map["source"] as! String) : nil
        )
    }
}
