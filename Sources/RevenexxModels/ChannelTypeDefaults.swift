import Foundation
import JSONCodable

/// The same answer for the channel types, which are seeded first because the seeded channel carries one.
open class ChannelTypeDefaults: Codable {

    enum CodingKeys: String, CodingKey {
        case created = "created"
        case existing = "existing"
    }

    /// Channel type codes this call wrote. A fresh tenant gets all 5; a settled one gets none.
    public let created: [String]?
    /// Seeded type codes that were already there. Note the consequence of "idempotent" being keyed on the code: a seeded type the merchant deliberately retired is re-created by the next call and comes back under `created`. Types the merchant added themselves are never touched.
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

    public static func from(map: [String: Any] ) -> ChannelTypeDefaults {
        return ChannelTypeDefaults(
            created: map["created"] as? [String],
            existing: map["existing"] as? [String]
        )
    }
}
