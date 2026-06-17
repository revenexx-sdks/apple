import Foundation
import JSONCodable

/// 
open class OrderComment: Codable {

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case body = "body"
        case created_at = "created_at"
        case id = "id"
        case order_id = "order_id"
        case visibility = "visibility"
    }

    /// 
    public let author: String?
    /// 
    public let body: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let order_id: String?
    /// 
    public let visibility: String?

    init(
        author: String?,
        body: String?,
        created_at: String?,
        id: String?,
        order_id: String?,
        visibility: String?
    ) {
        self.author = author
        self.body = body
        self.created_at = created_at
        self.id = id
        self.order_id = order_id
        self.visibility = visibility
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.visibility = try container.decodeIfPresent(String.self, forKey: .visibility)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(visibility, forKey: .visibility)
    }

    public func toMap() -> [String: Any] {
        return [
            "author": author as Any,
            "body": body as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "order_id": order_id as Any,
            "visibility": visibility as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderComment {
        return OrderComment(
            author: map["author"] as? String,
            body: map["body"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            order_id: map["order_id"] as? String,
            visibility: map["visibility"] as? String
        )
    }
}
