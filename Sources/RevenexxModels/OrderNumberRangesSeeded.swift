import Foundation
import JSONCodable

/// Which of the three standard codes this call had to create and which were already there.
open class OrderNumberRangesSeeded: Codable {

    enum CodingKeys: String, CodingKey {
        case created = "created"
        case existing = "existing"
    }

    /// The codes that were created just now, with the standard format ORD-/DEL-/RET- and padding 6. Empty on every call after the first.
    public let created: [String]?
    /// The codes that were already there and were left EXACTLY as they are — a merchant who changed the prefix or the counter keeps their change. That is what makes this call safe to run again.
    public let existing: [String]?

    init(
        created: [String]?,
        existing: [String]?
    ) {
        self.created = created
        self.existing = existing
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created = try container.decodeIfPresent([String].self, forKey: .created)
        self.existing = try container.decodeIfPresent([String].self, forKey: .existing)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(existing, forKey: .existing)
    }

    public func toMap() -> [String: Any] {
        return [
            "created": created as Any,
            "existing": existing as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderNumberRangesSeeded {
        return OrderNumberRangesSeeded(
            created: map["created"] as? [String],
            existing: map["existing"] as? [String]
        )
    }
}
