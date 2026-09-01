import Foundation
import JSONCodable

/// The new body. Nothing else about a comment is editable.
open class PageCommentUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case body = "body"
    }

    /// The comment, as editor HTML. Replaces the old body completely.
    public let body: String

    init(
        body: String
    ) {
        self.body = body
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.body = try container.decode(String.self, forKey: .body)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(body, forKey: .body)
    }

    public func toMap() -> [String: Any] {
        return [
            "body": body as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageCommentUpdateRequest {
        return PageCommentUpdateRequest(
            body: map["body"] as! String
        )
    }
}
