import Foundation
import JSONCodable

/// A new matrix tier (from_value → price) of the method in the path.
open class ShippingRateTierCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case from_value = "from_value"
        case position = "position"
        case price = "price"
    }

    /// Lower bound of this tier, in the method's matrix measure — kilograms (or whatever the market's `weight_unit` names, converted through its factor) for a weight matrix, items for quantity, money in the method's currency for order_value, and the raw attribute value for 'attribute'. INCLUSIVE: the tier applies from this value upward, and the tier that wins is the one with the highest from_value at or below the measured value, so a measure of exactly 10 is priced by the tier at 10 rather than the one below it. The last tier has no upper bound. Unique per method — a second tier at the same threshold is a 409, because which of the two won would be whatever the database returned first. Defaults to 0.
    public let from_value: Double?
    /// Display order in the matrix editor (default 0; a bulk replace derives it from the array index). Pricing reads from_value, never this.
    public let position: Int?
    /// What this tier costs, in the method's currency. Charged in full for the whole consignment — a matrix is a lookup table, not a rate per unit. Defaults to 0.
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
