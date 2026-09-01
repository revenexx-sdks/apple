import Foundation
import JSONCodable

/// 
open class FormDefaultsResult: Codable {

    enum CodingKeys: String, CodingKey {
        case created = "created"
        case existing = "existing"
    }

    /// Slugs this call created. On a tenant that has had the app installed for more than a moment this is empty — the sample form is seeded on `app.installed`.
    public let created: [String]?
    /// Slugs that were already there and were left alone. Nothing about them was overwritten — a form the merchant has edited stays edited.
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

    public static func from(map: [String: Any] ) -> FormDefaultsResult {
        return FormDefaultsResult(
            created: map["created"] as? [String],
            existing: map["existing"] as? [String]
        )
    }
}
