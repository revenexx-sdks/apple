import Foundation
import JSONCodable

/// One comment, in the shape the editor renders — this is not the stored row: the id is `uuid`, the timestamps are `created`/`updated` and the author is nested under `user`.
open class PageCommentItem: Codable {

    enum CodingKeys: String, CodingKey {
        case blockUuids = "blockUuids"
        case body = "body"
        case created = "created"
        case parentUuid = "parentUuid"
        case resolved = "resolved"
        case updated = "updated"
        case user = "user"
        case uuid = "uuid"
    }

    /// The blocks this thread hangs on, so the editor can draw a marker next to them. Empty for a comment about the page as a whole.
    public let blockUuids: [String]?
    /// The comment itself, as editor HTML. @mentions are `<span data-type="mention" data-id="…">` — that is what this app reads to decide whom to notify — and task checkboxes are `<li data-type="taskItem" data-checked="…">`.
    public let body: String?
    /// When the comment was written.
    public let created: String?
    /// The root comment this is a reply to. Absent on a root — and only roots can be resolved.
    public let parentUuid: String?
    /// Whether the thread was marked done. Replies inherit nothing: resolving is a property of the root.
    public let resolved: Bool?
    /// When it was last edited. Absent when it never was.
    public let updated: String?
    /// Who wrote it, or `null` when it was written without an identity.
    public let user: [String: AnyCodable]?
    /// The comment id. Every comment route addresses one by it.
    public let uuid: String?

    init(
        blockUuids: [String]?,
        body: String?,
        created: String?,
        parentUuid: String?,
        resolved: Bool?,
        updated: String?,
        user: [String: AnyCodable]?,
        uuid: String?
    ) {
        self.blockUuids = blockUuids
        self.body = body
        self.created = created
        self.parentUuid = parentUuid
        self.resolved = resolved
        self.updated = updated
        self.user = user
        self.uuid = uuid
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.blockUuids = try container.decodeIfPresent([String].self, forKey: .blockUuids)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.created = try container.decodeIfPresent(String.self, forKey: .created)
        self.parentUuid = try container.decodeIfPresent(String.self, forKey: .parentUuid)
        self.resolved = try container.decodeIfPresent(Bool.self, forKey: .resolved)
        self.updated = try container.decodeIfPresent(String.self, forKey: .updated)
        self.user = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user)
        self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(blockUuids, forKey: .blockUuids)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(parentUuid, forKey: .parentUuid)
        try container.encodeIfPresent(resolved, forKey: .resolved)
        try container.encodeIfPresent(updated, forKey: .updated)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encodeIfPresent(uuid, forKey: .uuid)
    }

    public func toMap() -> [String: Any] {
        return [
            "blockUuids": blockUuids as Any,
            "body": body as Any,
            "created": created as Any,
            "parentUuid": parentUuid as Any,
            "resolved": resolved as Any,
            "updated": updated as Any,
            "user": user as Any,
            "uuid": uuid as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageCommentItem {
        return PageCommentItem(
            blockUuids: map["blockUuids"] as? [String],
            body: map["body"] as? String,
            created: map["created"] as? String,
            parentUuid: map["parentUuid"] as? String,
            resolved: map["resolved"] as? Bool,
            updated: map["updated"] as? String,
            user: map["user"] as? [String: AnyCodable],
            uuid: map["uuid"] as? String
        )
    }
}
