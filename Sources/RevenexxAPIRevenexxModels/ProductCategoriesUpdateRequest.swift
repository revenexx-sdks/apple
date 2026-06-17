import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class ProductCategoriesUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case category_id = "category_id"
        case position = "position"
        case product_id = "product_id"
    }

    /// 
    public let category_id: String?
    /// 
    public let position: Int?
    /// 
    public let product_id: String?

    init(
        category_id: String?,
        position: Int?,
        product_id: String?
    ) {
        self.category_id = category_id
        self.position = position
        self.product_id = product_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.category_id = try container.decodeIfPresent(String.self, forKey: .category_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(category_id, forKey: .category_id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "category_id": category_id as Any,
            "position": position as Any,
            "product_id": product_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductCategoriesUpdateRequest {
        return ProductCategoriesUpdateRequest(
            category_id: map["category_id"] as? String,
            position: map["position"] as? Int,
            product_id: map["product_id"] as? String
        )
    }
}
