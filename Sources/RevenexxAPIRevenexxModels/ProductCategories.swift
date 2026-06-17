import Foundation
import JSONCodable

/// 
open class ProductCategories: Codable {

    enum CodingKeys: String, CodingKey {
        case category_id = "category_id"
        case created_at = "created_at"
        case id = "id"
        case position = "position"
        case product_id = "product_id"
    }

    /// 
    public let category_id: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let position: Int?
    /// 
    public let product_id: String?

    init(
        category_id: String?,
        created_at: String?,
        id: String?,
        position: Int?,
        product_id: String?
    ) {
        self.category_id = category_id
        self.created_at = created_at
        self.id = id
        self.position = position
        self.product_id = product_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.category_id = try container.decodeIfPresent(String.self, forKey: .category_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(category_id, forKey: .category_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "category_id": category_id as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "position": position as Any,
            "product_id": product_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductCategories {
        return ProductCategories(
            category_id: map["category_id"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            position: map["position"] as? Int,
            product_id: map["product_id"] as? String
        )
    }
}
