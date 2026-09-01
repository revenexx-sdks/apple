import Foundation
import JSONCodable

/// A new comment. Send `blockUuids` for a thread anchored to blocks, `parentUuid` for a reply.
open class PageCommentCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case blockUuids = "blockUuids"
        case body = "body"
        case parentUuid = "parentUuid"
    }

    /// The blocks this thread is about, so the editor can draw a marker next to them. Leave empty for a comment about the page as a whole.
    public let blockUuids: [String]?
    /// The comment, as editor HTML. `<span data-type="mention" data-id="USER_ID">` is what this app reads to decide whom to notify; `<li data-type="taskItem" data-checked="false">` makes a checkbox the toggle-task route can flip.
    public let body: String
    /// The root comment this replies to. Omit for a new thread — only roots can be resolved.
    public let parentUuid: String?

    init(
        blockUuids: [String]?,
        body: String,
        parentUuid: String?
    ) {
        self.blockUuids = blockUuids
        self.body = body
        self.parentUuid = parentUuid
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.blockUuids = try container.decodeIfPresent([String].self, forKey: .blockUuids)
        self.body = try container.decode(String.self, forKey: .body)
        self.parentUuid = try container.decodeIfPresent(String.self, forKey: .parentUuid)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(blockUuids, forKey: .blockUuids)
        try container.encode(body, forKey: .body)
        try container.encodeIfPresent(parentUuid, forKey: .parentUuid)
    }

    public func toMap() -> [String: Any] {
        return [
            "blockUuids": blockUuids as Any,
            "body": body as Any,
            "parentUuid": parentUuid as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageCommentCreateRequest {
        return PageCommentCreateRequest(
            blockUuids: map["blockUuids"] as? [String],
            body: map["body"] as! String,
            parentUuid: map["parentUuid"] as? String
        )
    }
}
