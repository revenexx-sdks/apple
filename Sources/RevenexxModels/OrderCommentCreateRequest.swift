import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class OrderCommentCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case body = "body"
        case visibility = "visibility"
    }

    /// Who wrote it, as the caller reported it. Free text; not resolved against a user directory.
    public let author: String?
    /// The comment itself. Plain text; this app neither renders nor sanitizes it.
    public let body: String
    /// Who may see it: 'internal' is a note between operators, 'customer' is meant to be shown in the customer's order view. Nothing here enforces that — this app labels the comment and the client showing it decides. Defaults to the tenant's default_comment_visibility. Defaults to the tenant's default_comment_visibility setting, which is 'internal' out of the box.
    public let visibility: RevenexxEnums.OrderCommentVisibility?

    init(
        author: String?,
        body: String,
        visibility: RevenexxEnums.OrderCommentVisibility?
    ) {
        self.author = author
        self.body = body
        self.visibility = visibility
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.body = try container.decode(String.self, forKey: .body)
        if let visibilityString = try container.decodeIfPresent(String.self, forKey: .visibility) {
            self.visibility = RevenexxEnums.OrderCommentVisibility(rawValue: visibilityString)
        } else {
            self.visibility = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(author, forKey: .author)
        try container.encode(body, forKey: .body)
        try container.encodeIfPresent(visibility?.rawValue, forKey: .visibility)
    }

    public func toMap() -> [String: Any] {
        return [
            "author": author as Any,
            "body": body as Any,
            "visibility": visibility?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCommentCreateRequest {
        return OrderCommentCreateRequest(
            author: map["author"] as? String,
            body: map["body"] as! String,
            visibility: map["visibility"] as? String != nil ? OrderCommentVisibility(rawValue: map["visibility"] as! String) : nil
        )
    }
}
