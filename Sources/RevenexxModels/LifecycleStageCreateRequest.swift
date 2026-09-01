import Foundation
import JSONCodable
import RevenexxEnums

/// Add one value to the lifecycle stages set. It is available to `organizations.lifecycle_stage` immediately.
open class LifecycleStageCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case description = "description"
        case descriptions = "descriptions"
        case is_default = "is_default"
        case labels = "labels"
        case position = "position"
        case title = "title"
        case tone = "tone"
    }

    /// What `organizations.lifecycle_stage` will store. Lowercase, starting with a letter; immutable afterwards.
    public let code: String
    /// One line of help for whoever picks this value.
    public let description: String?
    /// Localized descriptions, keyed by language tag ({ "en": …, "de": … }). Null when nobody translated this value — a client then falls back to `description`.
    public let descriptions: [String: AnyCodable]?
    /// Promote this value; the previous default is demoted in the same call.
    public let is_default: Bool?
    /// Localized titles, keyed by language tag ({ "en": …, "de": … }). Null when nobody translated this value — a client then falls back to `title`.
    public let labels: [String: AnyCodable]?
    /// Where it sits in the set, ascending. Default 0.
    public let position: Int?
    /// The fallback name shown when no locale matches.
    public let title: String
    /// Semantic badge colour.
    public let tone: RevenexxEnums.LifecycleStageCreateRequestTone?

    init(
        code: String,
        description: String?,
        descriptions: [String: AnyCodable]?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        position: Int?,
        title: String,
        tone: RevenexxEnums.LifecycleStageCreateRequestTone?
    ) {
        self.code = code
        self.description = description
        self.descriptions = descriptions
        self.is_default = is_default
        self.labels = labels
        self.position = position
        self.title = title
        self.tone = tone
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .descriptions)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.title = try container.decode(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.LifecycleStageCreateRequestTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(descriptions, forKey: .descriptions)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "description": description as Any,
            "descriptions": descriptions as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "position": position as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LifecycleStageCreateRequest {
        return LifecycleStageCreateRequest(
            code: map["code"] as! String,
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            title: map["title"] as! String,
            tone: map["tone"] as? String != nil ? LifecycleStageCreateRequestTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
