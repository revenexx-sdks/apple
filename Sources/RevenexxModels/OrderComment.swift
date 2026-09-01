import Foundation
import JSONCodable
import RevenexxEnums

/// A note on an order, either internal between operators or meant for the customer to see.
open class OrderComment: Codable {

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case body = "body"
        case created_at = "created_at"
        case id = "id"
        case order_id = "order_id"
        case visibility = "visibility"
    }

    /// Who wrote it, as the caller reported it. Free text; not resolved against a user directory.
    public let author: String?
    /// The comment itself. Plain text; this app neither renders nor sanitizes it.
    public let body: String?
    /// When the comment was written. Comments come back oldest first.
    public let created_at: String?
    /// Primary key of the comment.
    public let id: String?
    /// The order the comment hangs on.
    public let order_id: String?
    /// Who may see it: 'internal' is a note between operators, 'customer' is meant to be shown in the customer's order view. Nothing here enforces that — this app labels the comment and the client showing it decides. Defaults to the tenant's default_comment_visibility.
    public let visibility: RevenexxEnums.OrderCommentVisibility?

    init(
        author: String?,
        body: String?,
        created_at: String?,
        id: String?,
        order_id: String?,
        visibility: RevenexxEnums.OrderCommentVisibility?
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
        if let visibilityString = try container.decodeIfPresent(String.self, forKey: .visibility) {
            self.visibility = RevenexxEnums.OrderCommentVisibility(rawValue: visibilityString)
        } else {
            self.visibility = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(visibility?.rawValue, forKey: .visibility)
    }

    public func toMap() -> [String: Any] {
        return [
            "author": author as Any,
            "body": body as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "order_id": order_id as Any,
            "visibility": visibility?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderComment {
        return OrderComment(
            author: map["author"] as? String,
            body: map["body"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            order_id: map["order_id"] as? String,
            visibility: map["visibility"] as? String != nil ? OrderCommentVisibility(rawValue: map["visibility"] as! String) : nil
        )
    }
}
