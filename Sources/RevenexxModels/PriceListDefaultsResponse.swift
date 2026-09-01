import Foundation
import JSONCodable

/// What seeding found and what it had to write. Idempotent twice over: by code, and by the existence of ANY default list — so changing default_price_list_code later never produces a second default.
open class PriceListDefaultsResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case created = "created"
        case existing = "existing"
    }

    /// Codes of the lists this call created — empty on a tenant that was already seeded.
    public let created: [String]?
    /// Codes of the lists that were already there, so nothing was written for them.
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

    public static func from(map: [String: Any] ) -> PriceListDefaultsResponse {
        return PriceListDefaultsResponse(
            created: map["created"] as? [String],
            existing: map["existing"] as? [String]
        )
    }
}
