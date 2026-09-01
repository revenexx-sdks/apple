import Foundation
import JSONCodable

/// Where the order is going. Read ONLY when the tenant's `allocation_strategy` is 'nearest' — under 'priority' or 'single_location' it is accepted and ignored, so sending it is never wrong, it is just not always heard.
open class InventoryShipTo: Codable {

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case location_code = "location_code"
    }

    /// ISO country code of the delivery address. Locations whose `address.country` matches are tried before the rest, which is what stops a German order pulling from an overseas warehouse that merely sorts first.
    public let country: String?
    /// Prefer this location above everything else — a click-and-collect store the customer picked. It is a preference, not a demand: if it cannot cover the item the allocator moves on to the next location.
    public let location_code: String?

    init(
        country: String?,
        location_code: String?
    ) {
        self.country = country
        self.location_code = location_code
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(location_code, forKey: .location_code)
    }

    public func toMap() -> [String: Any] {
        return [
            "country": country as Any,
            "location_code": location_code as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryShipTo {
        return InventoryShipTo(
            country: map["country"] as? String,
            location_code: map["location_code"] as? String
        )
    }
}
