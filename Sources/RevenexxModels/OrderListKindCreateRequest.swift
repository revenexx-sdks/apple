import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class OrderListKindCreateRequest: Codable {

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

    /// What `lists.kind` will store. Lowercased on the way in and immutable afterwards — a merchant who wants a different code creates a new kind and moves the lists over.
    public let code: String
    /// What this kind is for, in one sentence — the line a select shows under the title.
    public let description: String?
    /// Localized descriptions, keyed by language tag.
    public let descriptions: [String: AnyCodable]?
    /// Promote this kind; the previous default is demoted.
    public let is_default: Bool?
    /// Localized titles, keyed by language tag.
    public let labels: [String: AnyCodable]?
    /// Where the kind sits in a select, ascending. Omitted means 0, which puts it first among the unpositioned.
    public let position: Int?
    /// What a person reads. `labels` adds the localized forms on top; this one is the fallback.
    public let title: String
    /// Semantic badge colour. The client owns what each tone looks like; omitted means `neutral`.
    public let tone: RevenexxEnums.OrderListKindTone?

    init(
        code: String,
        description: String?,
        descriptions: [String: AnyCodable]?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        position: Int?,
        title: String,
        tone: RevenexxEnums.OrderListKindTone?
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
            self.tone = RevenexxEnums.OrderListKindTone(rawValue: toneString)
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

    public static func from(map: [String: Any] ) -> OrderListKindCreateRequest {
        return OrderListKindCreateRequest(
            code: map["code"] as! String,
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            title: map["title"] as! String,
            tone: map["tone"] as? String != nil ? OrderListKindTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
