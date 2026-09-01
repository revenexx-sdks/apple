import Foundation
import JSONCodable

/// What was measured and stored into `products.completeness` by this call — how much of what the family requires the product actually carries.
open class ProductCompleteness: Codable {

    enum CodingKeys: String, CodingKey {
        case computed_at = "computed_at"
        case filled = "filled"
        case missing = "missing"
        case ratio = "ratio"
        case `required` = "required"
    }

    /// When this measurement was taken. It is a snapshot: editing the product does not update it, the next `POST /products/{id}/completeness` does.
    public let computed_at: String?
    /// How many of those carry a value — in ANY bucket, so a name held only in German counts.
    public let filled: Int?
    /// Attribute codes with no value in any bucket.
    public let missing: [String]?
    /// filled / required, 0..1. A family that requires nothing is 1, not undefined.
    public let ratio: Double?
    /// Attributes the product's family marks is_required.
    public let `required`: Int?

    init(
        computed_at: String?,
        filled: Int?,
        missing: [String]?,
        ratio: Double?,
        `required`: Int?
    ) {
        self.computed_at = computed_at
        self.filled = filled
        self.missing = missing
        self.ratio = ratio
        self.`required` = `required`
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.computed_at = try container.decodeIfPresent(String.self, forKey: .computed_at)
        self.filled = try container.decodeIfPresent(Int.self, forKey: .filled)
        self.missing = try container.decodeIfPresent([String].self, forKey: .missing)
        self.ratio = try container.decodeIfPresent(Double.self, forKey: .ratio)
        self.`required` = try container.decodeIfPresent(Int.self, forKey: .`required`)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(computed_at, forKey: .computed_at)
        try container.encodeIfPresent(filled, forKey: .filled)
        try container.encodeIfPresent(missing, forKey: .missing)
        try container.encodeIfPresent(ratio, forKey: .ratio)
        try container.encodeIfPresent(`required`, forKey: .`required`)
    }

    public func toMap() -> [String: Any] {
        return [
            "computed_at": computed_at as Any,
            "filled": filled as Any,
            "missing": missing as Any,
            "ratio": ratio as Any,
            "required": `required` as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductCompleteness {
        return ProductCompleteness(
            computed_at: map["computed_at"] as? String,
            filled: map["filled"] as? Int,
            missing: map["missing"] as? [String],
            ratio: map["ratio"] as? Double,
            required: map["required"] as? Int
        )
    }
}
