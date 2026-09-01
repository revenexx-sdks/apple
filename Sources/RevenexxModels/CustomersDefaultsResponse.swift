import Foundation
import JSONCodable

/// 
open class CustomersDefaultsResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case sets = "sets"
    }

    /// One entry per value set, keyed by its route name — `payment-terms`, `address-types`, `lifecycle-stages`, `contact-event-kinds`. Each says what THIS call did: `created` are the codes it inserted, `existing` the seeded codes it found already there and left completely alone (a merchant's rename included). A second call therefore answers with everything under `existing` and nothing under `created`.
    public let sets: [String: AnyCodable]?

    init(
        sets: [String: AnyCodable]?
    ) {
        self.sets = sets
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.sets = try container.decodeIfPresent([String: AnyCodable].self, forKey: .sets)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(sets, forKey: .sets)
    }

    public func toMap() -> [String: Any] {
        return [
            "sets": sets as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CustomersDefaultsResponse {
        return CustomersDefaultsResponse(
            sets: map["sets"] as? [String: AnyCodable]
        )
    }
}
