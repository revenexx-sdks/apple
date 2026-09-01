import Foundation
import JSONCodable

/// What one location holds of this item. Only enabled locations appear, and only those with a stock row for the item — a location that has never held it is absent rather than zero.
open class LocationAvailability: Codable {

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case location = "location"
        case on_hand = "on_hand"
        case reserved = "reserved"
    }

    /// on_hand − reserved at this location — what this one place can still promise.
    public let available: Double?
    /// The location CODE (`locations.code`) — the same value `location_code` takes in a request. Falls back to the raw location id in the rare case where the location row disappeared between the two reads.
    public let location: String?
    /// Physically at this location, promised units included.
    public let on_hand: Double?
    /// Held for orders at this location.
    public let reserved: Double?

    init(
        available: Double?,
        location: String?,
        on_hand: Double?,
        reserved: Double?
    ) {
        self.available = available
        self.location = location
        self.on_hand = on_hand
        self.reserved = reserved
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.available = try container.decodeIfPresent(Double.self, forKey: .available)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.on_hand = try container.decodeIfPresent(Double.self, forKey: .on_hand)
        self.reserved = try container.decodeIfPresent(Double.self, forKey: .reserved)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(available, forKey: .available)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(on_hand, forKey: .on_hand)
        try container.encodeIfPresent(reserved, forKey: .reserved)
    }

    public func toMap() -> [String: Any] {
        return [
            "available": available as Any,
            "location": location as Any,
            "on_hand": on_hand as Any,
            "reserved": reserved as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LocationAvailability {
        return LocationAvailability(
            available: map["available"] as? Double,
            location: map["location"] as? String,
            on_hand: map["on_hand"] as? Double,
            reserved: map["reserved"] as? Double
        )
    }
}
