import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ShippingServiceLevelCreateRequest: Codable {

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

    /// Lowercase letters, digits, - or _, starting with a letter. What `shipping_carriers.service_level` stores. Immutable once created — renaming it would orphan every row carrying it.
    public let code: String
    /// The sentence under the title, explaining when to pick this service level. Null when the title says enough.
    public let description: String?
    /// Localized descriptions. A flat map keyed by locale — the Cockpit falls back to `en`. Null means the row has no translations and every client shows the untranslated column instead.
    public let descriptions: [String: AnyCodable]?
    /// Promote this value on creation; the previous default is demoted.
    public let is_default: Bool?
    /// Localized titles. A flat map keyed by locale — the Cockpit falls back to `en`. Null means the row has no translations and every client shows the untranslated column instead.
    public let labels: [String: AnyCodable]?
    /// Sort order in a select — the collection is returned in it.
    public let position: Int?
    /// What an operator reads in a select. The name a merchant renames; the code underneath never moves.
    public let title: String
    /// Semantic badge colour for a UI listing the set. The client owns what each tone looks like.
    public let tone: RevenexxEnums.ShippingServiceLevelCreateRequestTone?

    init(
        code: String,
        description: String?,
        descriptions: [String: AnyCodable]?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        position: Int?,
        title: String,
        tone: RevenexxEnums.ShippingServiceLevelCreateRequestTone?
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
            self.tone = RevenexxEnums.ShippingServiceLevelCreateRequestTone(rawValue: toneString)
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

    public static func from(map: [String: Any] ) -> ShippingServiceLevelCreateRequest {
        return ShippingServiceLevelCreateRequest(
            code: map["code"] as! String,
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            title: map["title"] as! String,
            tone: map["tone"] as? String != nil ? ShippingServiceLevelCreateRequestTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
