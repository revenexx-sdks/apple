import Foundation
import JSONCodable

/// The category has to exist already; this route files a product into one, it does not create one.
open class ProductCategoryAssignRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case category_id = "category_id"
        case position = "position"
    }

    /// The category to file the product into.
    public let category_id: String
    /// Sort order inside the category. Default 0.
    public let position: Int?

    init(
        category_id: String,
        position: Int?
    ) {
        self.category_id = category_id
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.category_id = try container.decode(String.self, forKey: .category_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(category_id, forKey: .category_id)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "category_id": category_id as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductCategoryAssignRequest {
        return ProductCategoryAssignRequest(
            category_id: map["category_id"] as! String,
            position: map["position"] as? Int
        )
    }
}
