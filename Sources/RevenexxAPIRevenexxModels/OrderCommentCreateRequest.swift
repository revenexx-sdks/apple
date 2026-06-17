import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// 
open class OrderCommentCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case body = "body"
        case visibility = "visibility"
    }

    /// 
    public let author: String?
    /// 
    public let body: String
    /// Default &#039;internal&#039;.
    public let visibility: Revenexx API — revenexxEnums.OrderCommentVisibility?

    init(
        author: String?,
        body: String,
        visibility: Revenexx API — revenexxEnums.OrderCommentVisibility?
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
            self.visibility = Revenexx API — revenexxEnums.OrderCommentVisibility(rawValue: visibilityString)
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
