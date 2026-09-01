import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `product_categories` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class ProductCategoriesFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case category_id = "category_id"
        case created_at = "created_at"
        case id = "id"
        case position = "position"
        case product_id = "product_id"
        case source = "source"
        case data
    }

    /// The literal `?category_id=` value this call was understood to carry.
    public let category_id: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?position=` value this call was understood to carry.
    public let position: String?
    /// The literal `?product_id=` value this call was understood to carry.
    public let product_id: String?
    /// The literal `?source=` value this call was understood to carry.
    public let source: String?
    /// Additional properties
    public let data: T

    init(
        category_id: String?,
        created_at: String?,
        id: String?,
        position: String?,
        product_id: String?,
        source: String?,
        data: T
    ) {
        self.category_id = category_id
        self.created_at = created_at
        self.id = id
        self.position = position
        self.product_id = product_id
        self.source = source
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.category_id = try container.decodeIfPresent(String.self, forKey: .category_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(category_id, forKey: .category_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "category_id": category_id as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "position": position as Any,
            "product_id": product_id as Any,
            "source": source as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> ProductCategoriesFilter {
        return ProductCategoriesFilter(
            category_id: map["category_id"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            position: map["position"] as? String,
            product_id: map["product_id"] as? String,
            source: map["source"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
