import Foundation
import JSONCodable

/// A new matrix tier (from_value → price) of the method in the path.
open class ShippingRateTierCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case from_value = "from_value"
        case position = "position"
        case price = "price"
    }

    /// Tier threshold (default 0) — the tier with the highest from_value at or below the measured value wins.
    public let from_value: Double?
    /// Sort order (default 0; bulk replace derives it from the array index).
    public let position: Int?
    /// Price of this tier (default 0).
    public let price: Double?

    init(
        from_value: Double?,
        position: Int?,
        price: Double?
    ) {
        self.from_value = from_value
        self.position = position
        self.price = price
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.from_value = try container.decodeIfPresent(Double.self, forKey: .from_value)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(from_value, forKey: .from_value)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(price, forKey: .price)
    }

    public func toMap() -> [String: Any] {
        return [
            "from_value": from_value as Any,
            "position": position as Any,
            "price": price as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRateTierCreateRequest {
        return ShippingRateTierCreateRequest(
            from_value: map["from_value"] as? Double,
            position: map["position"] as? Int,
            price: map["price"] as? Double
        )
    }
}
