import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelTypeRow: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case description = "description"
        case descriptions = "descriptions"
        case id = "id"
        case is_default = "is_default"
        case is_system = "is_system"
        case labels = "labels"
        case position = "position"
        case tenant_id = "tenant_id"
        case title = "title"
        case tone = "tone"
        case updated_at = "updated_at"
    }

    /// What `channels.type` stores. Immutable once created — renaming it would orphan every channel that carries it, and there is no FK behind `channels.type` to cascade. A fresh install seeds storefront, punchout, marketplace, api, pos; a merchant may retire any of them and add their own.
    public let code: String?
    /// When the row was inserted, set by the database.
    public let created_at: String?
    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let descriptions: [String: AnyCodable]?
    /// Row id, and the only handle GET/PUT/DELETE /channels/types/{id} accept. Not the type `code`. No example is published because no id this app could invent names a row a tenant holds.
    public let id: String?
    /// The type a channel created without one gets. Exactly one row carries it.
    public let is_default: Bool?
    /// Seeded on install rather than added by the merchant. A flag about origin only — a system type is still renameable, reorderable and retirable.
    public let is_system: Bool?
    /// A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let labels: [String: AnyCodable]?
    /// Sort position. GET /channels/types always answers in this order and takes no `order` parameter. It is not unique and defaults to 0, so ties are broken by `code` — the order is total, which is what makes paging the list safe to walk.
    public let position: Int?
    /// The tenant that owns this row. Added by the data plane, not by this app: it is not a column of schema.json, so it is read-only and `?tenant_id=` is not a filter — the key is silently dropped and never reaches the `filter` echo.
    public let tenant_id: String?
    /// The fallback name. `labels` carries the per-locale ones. Rows seeded before 0.7.0 hold a serialized locale map here instead (PE-452).
    public let title: [String: AnyCodable]?
    /// Semantic badge colour for this type, for a client that renders the list. The client owns what each tone looks like; the value only says what it MEANS.
    public let tone: RevenexxEnums.ChannelTypeTone?
    /// When the row was last written, set by the database.
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        description: [String: AnyCodable]?,
        descriptions: [String: AnyCodable]?,
        id: String?,
        is_default: Bool?,
        is_system: Bool?,
        labels: [String: AnyCodable]?,
        position: Int?,
        tenant_id: String?,
        title: [String: AnyCodable]?,
        tone: RevenexxEnums.ChannelTypeTone?,
        updated_at: String?
    ) {
        self.code = code
        self.created_at = created_at
        self.description = description
        self.descriptions = descriptions
        self.id = id
        self.is_default = is_default
        self.is_system = is_system
        self.labels = labels
        self.position = position
        self.tenant_id = tenant_id
        self.title = title
        self.tone = tone
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        self.descriptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .descriptions)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.is_system = try container.decodeIfPresent(Bool.self, forKey: .is_system)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.ChannelTypeTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(descriptions, forKey: .descriptions)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(is_system, forKey: .is_system)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "description": description as Any,
            "descriptions": descriptions as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "is_system": is_system as Any,
            "labels": labels as Any,
            "position": position as Any,
            "tenant_id": tenant_id as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelTypeRow {
        return ChannelTypeRow(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            description: map["description"] as? [String: AnyCodable],
            descriptions: map["descriptions"] as? [String: AnyCodable],
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            is_system: map["is_system"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            tenant_id: map["tenant_id"] as? String,
            title: map["title"] as? [String: AnyCodable],
            tone: map["tone"] as? String != nil ? ChannelTypeTone(rawValue: map["tone"] as! String) : nil,
            updated_at: map["updated_at"] as? String
        )
    }
}
