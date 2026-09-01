import Foundation
import JSONCodable

/// An evenly-stepped tier table. Tiers are generated at from_value, from_value+step, … up to to_value; each costs step_price more than the one before.
open class ShippingRateTiersLadderRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case base_price = "base_price"
        case from_value = "from_value"
        case replace = "replace"
        case step = "step"
        case step_price = "step_price"
        case to_value = "to_value"
    }

    /// Price of the first tier.
    public let base_price: Double
    /// First tier threshold (default 0), in the method's matrix measure.
    public let from_value: Double?
    /// Replace the whole table (default true) or append to it.
    public let replace: Bool?
    /// Distance between two tiers. Must be > 0.
    public let step: Double
    /// Added to each subsequent tier (default 0). A negative value is allowed as long as no tier ends up below 0.
    public let step_price: Double?
    /// Last tier threshold. The final tier keeps applying above it — a matrix has no upper bound. Must be >= from_value.
    public let to_value: Double

    init(
        base_price: Double,
        from_value: Double?,
        replace: Bool?,
        step: Double,
        step_price: Double?,
        to_value: Double
    ) {
        self.base_price = base_price
        self.from_value = from_value
        self.replace = replace
        self.step = step
        self.step_price = step_price
        self.to_value = to_value
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.base_price = try container.decode(Double.self, forKey: .base_price)
        self.from_value = try container.decodeIfPresent(Double.self, forKey: .from_value)
        self.replace = try container.decodeIfPresent(Bool.self, forKey: .replace)
        self.step = try container.decode(Double.self, forKey: .step)
        self.step_price = try container.decodeIfPresent(Double.self, forKey: .step_price)
        self.to_value = try container.decode(Double.self, forKey: .to_value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(base_price, forKey: .base_price)
        try container.encodeIfPresent(from_value, forKey: .from_value)
        try container.encodeIfPresent(replace, forKey: .replace)
        try container.encode(step, forKey: .step)
        try container.encodeIfPresent(step_price, forKey: .step_price)
        try container.encode(to_value, forKey: .to_value)
    }

    public func toMap() -> [String: Any] {
        return [
            "base_price": base_price as Any,
            "from_value": from_value as Any,
            "replace": replace as Any,
            "step": step as Any,
            "step_price": step_price as Any,
            "to_value": to_value as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRateTiersLadderRequest {
        return ShippingRateTiersLadderRequest(
            base_price: map["base_price"] as! Double,
            from_value: map["from_value"] as? Double,
            replace: map["replace"] as? Bool,
            step: map["step"] as! Double,
            step_price: map["step_price"] as? Double,
            to_value: map["to_value"] as! Double
        )
    }
}
