import Foundation
import JSONCodable

/// One publication of this page, without the snapshot — who published, when, and under what name.
open class PageRevisionRef: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case created_by = "created_by"
        case created_by_name = "created_by_name"
        case id = "id"
        case label = "label"
        case page_id = "page_id"
    }

    /// When this revision was published.
    public let created_at: String?
    /// The user id that published.
    public let created_by: String?
    /// That user's display name, copied in at publish time so the history stays readable after the user is gone.
    public let created_by_name: String?
    /// The revision id. A page's `published_revision_id` points at one of these, and it is the only thing delivery reads.
    public let id: String?
    /// What this publication was called, e.g. "Autumn campaign". It is what turns the history into a list of changes rather than a list of timestamps.
    public let label: String?
    /// The page this revision belongs to.
    public let page_id: String?

    init(
        created_at: String?,
        created_by: String?,
        created_by_name: String?,
        id: String?,
        label: String?,
        page_id: String?
    ) {
        self.created_at = created_at
        self.created_by = created_by
        self.created_by_name = created_by_name
        self.id = id
        self.label = label
        self.page_id = page_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.created_by = try container.decodeIfPresent(String.self, forKey: .created_by)
        self.created_by_name = try container.decodeIfPresent(String.self, forKey: .created_by_name)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.page_id = try container.decodeIfPresent(String.self, forKey: .page_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(created_by, forKey: .created_by)
        try container.encodeIfPresent(created_by_name, forKey: .created_by_name)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(page_id, forKey: .page_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "created_by": created_by as Any,
            "created_by_name": created_by_name as Any,
            "id": id as Any,
            "label": label as Any,
            "page_id": page_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageRevisionRef {
        return PageRevisionRef(
            created_at: map["created_at"] as? String,
            created_by: map["created_by"] as? String,
            created_by_name: map["created_by_name"] as? String,
            id: map["id"] as? String,
            label: map["label"] as? String,
            page_id: map["page_id"] as? String
        )
    }
}
