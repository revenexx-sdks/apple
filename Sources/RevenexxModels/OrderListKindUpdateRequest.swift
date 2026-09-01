import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class OrderListKindUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case descriptions = "descriptions"
        case is_default = "is_default"
        case labels = "labels"
        case position = "position"
        case title = "title"
        case tone = "tone"
    }

    /// What this kind is for, in one sentence. Explicit null clears it.
    public let description: String?
    /// Localized descriptions, keyed by language tag. Replaces the whole map rather than merging into it.
    public let descriptions: [String: AnyCodable]?
    /// True promotes this kind and demotes the previous default — the same move POST /orderlists/kinds/{id}/make-default makes on its own.
    public let is_default: Bool?
    /// Localized titles, keyed by language tag. Replaces the whole map rather than merging into it.
    public let labels: [String: AnyCodable]?
    /// Where the kind sits in a select, ascending.
    public let position: Int?
    /// What a person reads. A blank title is ignored rather than stored — a kind with no words is unreadable in every UI.
    public let title: String?
    /// Semantic badge colour. The client owns what each tone looks like.
    public let tone: RevenexxEnums.OrderListKindTone?

    init(
        description: String?,
        descriptions: [String: AnyCodable]?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        position: Int?,
        title: String?,
        tone: RevenexxEnums.OrderListKindTone?
    ) {
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

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .descriptions)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.OrderListKindTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(descriptions, forKey: .descriptions)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "descriptions": descriptions as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "position": position as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListKindUpdateRequest {
        return OrderListKindUpdateRequest(
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            title: map["title"] as? String,
            tone: map["tone"] as? String != nil ? OrderListKindTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
