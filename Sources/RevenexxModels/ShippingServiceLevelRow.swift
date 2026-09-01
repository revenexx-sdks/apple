import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ShippingServiceLevelRow: Codable {

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
        case title = "title"
        case tone = "tone"
        case updated_at = "updated_at"
    }

    /// What `shipping_carriers.service_level` stores. Immutable once created — renaming it would orphan every row carrying it.
    public let code: String?
    /// When the row was created (UTC).
    public let created_at: String?
    /// The sentence under the title, explaining when to pick this service level. Null when the title says enough.
    public let description: String?
    /// Localized descriptions. A flat map keyed by locale — the Cockpit falls back to `en`. Null means the row has no translations and every client shows the untranslated column instead.
    public let descriptions: [String: AnyCodable]?
    /// Row id, assigned by the database on insert.
    public let id: String?
    /// The service level a fallback lands on. Exactly one row carries it, and POST …/make-default is what moves it.
    public let is_default: Bool?
    /// Seeded on install rather than typed by the merchant. Still renameable and still deletable; it only says where the row came from.
    public let is_system: Bool?
    /// Localized titles. A flat map keyed by locale — the Cockpit falls back to `en`. Null means the row has no translations and every client shows the untranslated column instead.
    public let labels: [String: AnyCodable]?
    /// Sort order in a select — the collection is returned in it.
    public let position: Int?
    /// What an operator reads in a select. The name a merchant renames; the code underneath never moves.
    public let title: String?
    /// Semantic badge colour for a UI listing the set. The client owns what each tone looks like.
    public let tone: RevenexxEnums.ShippingServiceLevelRowTone?
    /// When the row was last written (UTC).
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
        title: String?,
        tone: RevenexxEnums.ShippingServiceLevelRowTone?,
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
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.ShippingServiceLevelRowTone(rawValue: toneString)
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
            "title": title as Any,
            "tone": tone?.rawValue as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingServiceLevelRow {
        return ShippingServiceLevelRow(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            is_system: map["is_system"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            title: map["title"] as? String,
            tone: map["tone"] as? String != nil ? ShippingServiceLevelRowTone(rawValue: map["tone"] as! String) : nil,
            updated_at: map["updated_at"] as? String
        )
    }
}
