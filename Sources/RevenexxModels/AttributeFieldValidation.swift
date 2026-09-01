import Foundation
import JSONCodable

/// The limits the value has to satisfy, ready to hand to a form validator. Only the seven keys below are republished; anything else the tenant stored in `attributes.validation` stays there.
open class AttributeFieldValidation: Codable {

    enum CodingKeys: String, CodingKey {
        case max = "max"
        case max_items = "max_items"
        case max_length = "max_length"
        case min = "min"
        case min_items = "min_items"
        case min_length = "min_length"
        case pattern = "pattern"
    }

    /// Largest permitted number.
    public let max: Double?
    /// Most entries.
    public let max_items: Int?
    /// Longest permitted text.
    public let max_length: Int?
    /// Smallest permitted number, for a number or measure field.
    public let min: Double?
    /// Fewest entries, for a multi-select or a collection.
    public let min_items: Int?
    /// Shortest permitted text.
    public let min_length: Int?
    /// A regular expression the text has to match.
    public let pattern: String?

    init(
        max: Double?,
        max_items: Int?,
        max_length: Int?,
        min: Double?,
        min_items: Int?,
        min_length: Int?,
        pattern: String?
    ) {
        self.max = max
        self.max_items = max_items
        self.max_length = max_length
        self.min = min
        self.min_items = min_items
        self.min_length = min_length
        self.pattern = pattern
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.max = try container.decodeIfPresent(Double.self, forKey: .max)
        self.max_items = try container.decodeIfPresent(Int.self, forKey: .max_items)
        self.max_length = try container.decodeIfPresent(Int.self, forKey: .max_length)
        self.min = try container.decodeIfPresent(Double.self, forKey: .min)
        self.min_items = try container.decodeIfPresent(Int.self, forKey: .min_items)
        self.min_length = try container.decodeIfPresent(Int.self, forKey: .min_length)
        self.pattern = try container.decodeIfPresent(String.self, forKey: .pattern)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(max, forKey: .max)
        try container.encodeIfPresent(max_items, forKey: .max_items)
        try container.encodeIfPresent(max_length, forKey: .max_length)
        try container.encodeIfPresent(min, forKey: .min)
        try container.encodeIfPresent(min_items, forKey: .min_items)
        try container.encodeIfPresent(min_length, forKey: .min_length)
        try container.encodeIfPresent(pattern, forKey: .pattern)
    }

    public func toMap() -> [String: Any] {
        return [
            "max": max as Any,
            "max_items": max_items as Any,
            "max_length": max_length as Any,
            "min": min as Any,
            "min_items": min_items as Any,
            "min_length": min_length as Any,
            "pattern": pattern as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeFieldValidation {
        return AttributeFieldValidation(
            max: map["max"] as? Double,
            max_items: map["max_items"] as? Int,
            max_length: map["max_length"] as? Int,
            min: map["min"] as? Double,
            min_items: map["min_items"] as? Int,
            min_length: map["min_length"] as? Int,
            pattern: map["pattern"] as? String
        )
    }
}
