import Foundation
import JSONCodable
import RevenexxEnums

/// One value of the lifecycle stages set. Where a company stands in the sales pipeline — a separate axis from status, and one whose steps are a sales team's own.
open class LifecycleStage: Codable {

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

    /// What `organizations.lifecycle_stage` stores, and the only part of this row other data depends on. Immutable once created: renaming it would orphan every record carrying it.
    public let code: String?
    /// When the value was added to this set.
    public let created_at: String?
    /// One line of help for an operator choosing this value. Null when there is nothing to add. A row seeded before 0.22.0 may hold a serialized locale map here instead (PE-443).
    public let description: String?
    /// Localized descriptions, keyed by language tag ({ "en": …, "de": … }). Null when nobody translated this value — a client then falls back to `description`.
    public let descriptions: [String: AnyCodable]?
    /// Primary key of this value. What the update and delete routes address it by — the CODE is what records store.
    public let id: String?
    /// The value a create falls back to when the caller names none. Exactly one row of the set carries it; promoting another one demotes this.
    public let is_default: Bool?
    /// True for a value this app seeded on install. Still renameable and still removable — it only records where the value came from.
    public let is_system: Bool?
    /// Localized titles, keyed by language tag ({ "en": …, "de": … }). Null when nobody translated this value — a client then falls back to `title`.
    public let labels: [String: AnyCodable]?
    /// Where this value sits in the set, ascending. It is the order a select should offer.
    public let position: Int?
    /// The tenant this row belongs to — the store slug, not an id. Set by the platform from the authenticated context, never by a caller; a write that carries it is ignored, and no request can read another tenant's rows by sending a different one.
    public let tenant_id: String?
    /// The fallback name — what a client shows when no locale in `labels` matches. A row seeded before 0.22.0 may hold a serialized locale map here instead (PE-443) — those rows were seeded with no `labels` at all.
    public let title: String?
    /// Semantic badge colour. The palette stays fixed — it is a render concern, not a merchant decision.
    public let tone: RevenexxEnums.LifecycleStageTone?
    /// When it was last edited.
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        description: String?,
        descriptions: [String: AnyCodable]?,
        id: String?,
        is_default: Bool?,
        is_system: Bool?,
        labels: [String: AnyCodable]?,
        position: Int?,
        tenant_id: String?,
        title: String?,
        tone: RevenexxEnums.LifecycleStageTone?,
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
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .descriptions)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.is_system = try container.decodeIfPresent(Bool.self, forKey: .is_system)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.LifecycleStageTone(rawValue: toneString)
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

    public static func from(map: [String: Any] ) -> LifecycleStage {
        return LifecycleStage(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            is_system: map["is_system"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            tenant_id: map["tenant_id"] as? String,
            title: map["title"] as? String,
            tone: map["tone"] as? String != nil ? LifecycleStageTone(rawValue: map["tone"] as! String) : nil,
            updated_at: map["updated_at"] as? String
        )
    }
}
