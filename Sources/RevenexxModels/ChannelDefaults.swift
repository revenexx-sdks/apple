import Foundation
import JSONCodable

/// 
open class ChannelDefaults: Codable {

    enum CodingKeys: String, CodingKey {
        case created = "created"
        case existing = "existing"
        case types = "types"
    }

    /// Channel codes created by this call.
    public let created: [String]?
    /// Default channel codes that already existed.
    public let existing: [String]?
    /// The same answer for the channel types, which are seeded first because the seeded channel carries one.
    public let types: ChannelTypeDefaults?

    init(
        created: [String]?,
        existing: [String]?,
        types: ChannelTypeDefaults?
    ) {
        self.created = created
        self.existing = existing
        self.types = types
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created = try container.decodeIfPresent([String].self, forKey: .created)
        self.existing = try container.decodeIfPresent([String].self, forKey: .existing)
        self.types = try container.decodeIfPresent(ChannelTypeDefaults.self, forKey: .types)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(existing, forKey: .existing)
        try container.encodeIfPresent(types, forKey: .types)
    }

    public func toMap() -> [String: Any] {
        return [
            "created": created as Any,
            "existing": existing as Any,
            "types": types?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelDefaults {
        return ChannelDefaults(
            created: map["created"] as? [String],
            existing: map["existing"] as? [String],
            types: ChannelTypeDefaults.from(map: map["types"] as! [String: Any])
        )
    }
}
