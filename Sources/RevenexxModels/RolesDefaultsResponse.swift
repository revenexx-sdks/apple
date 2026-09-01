import Foundation
import JSONCodable

/// 
open class RolesDefaultsResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case created = "created"
        case existing = "existing"
    }

    /// Role keys created by this call.
    public let created: [String]?
    /// Role keys that were already there and were left untouched, permissions included.
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

    public static func from(map: [String: Any] ) -> RolesDefaultsResponse {
        return RolesDefaultsResponse(
            created: map["created"] as? [String],
            existing: map["existing"] as? [String]
        )
    }
}
