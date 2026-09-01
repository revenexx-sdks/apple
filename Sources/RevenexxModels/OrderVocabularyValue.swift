import Foundation
import JSONCodable
import RevenexxEnums

/// One permitted value with the words and the badge tone a client should render for it.
open class OrderVocabularyValue: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case `final` = "final"
        case key = "key"
        case stage = "stage"
        case title = "title"
        case tone = "tone"
    }

    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let description: String?
    /// True when this value ENDS the lifecycle. Lets a reader ask "is this order still open?" instead of matching status names it guessed.
    public let `final`: Bool?
    /// The value as stored — exactly what the CHECK constraint permits.
    public let key: String?
    /// Only on 'return-resolutions': which return transition accepts this value. A settlement word on the refusal dialog is how the two sets got mixed up.
    public let stage: RevenexxEnums.OrderResolutionStage?
    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let title: String?
    /// Semantic badge colour. The client owns what each tone looks like.
    public let tone: RevenexxEnums.OrderVocabularyTone?

    init(
        description: String?,
        `final`: Bool?,
        key: String?,
        stage: RevenexxEnums.OrderResolutionStage?,
        title: String?,
        tone: RevenexxEnums.OrderVocabularyTone?
    ) {
        self.description = description
        self.`final` = `final`
        self.key = key
        self.stage = stage
        self.title = title
        self.tone = tone
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.`final` = try container.decodeIfPresent(Bool.self, forKey: .`final`)
        self.key = try container.decodeIfPresent(String.self, forKey: .key)
        if let stageString = try container.decodeIfPresent(String.self, forKey: .stage) {
            self.stage = RevenexxEnums.OrderResolutionStage(rawValue: stageString)
        } else {
            self.stage = nil
        }
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.OrderVocabularyTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(`final`, forKey: .`final`)
        try container.encodeIfPresent(key, forKey: .key)
        try container.encodeIfPresent(stage?.rawValue, forKey: .stage)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "final": `final` as Any,
            "key": key as Any,
            "stage": stage?.rawValue as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderVocabularyValue {
        return OrderVocabularyValue(
            description: map["description"] as? String,
            final: map["final"] as? Bool,
            key: map["key"] as? String,
            stage: map["stage"] as? String != nil ? OrderResolutionStage(rawValue: map["stage"] as! String) : nil,
            title: map["title"] as? String,
            tone: map["tone"] as? String != nil ? OrderVocabularyTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
