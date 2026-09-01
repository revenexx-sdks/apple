import Foundation
import JSONCodable

/// 
open class ShippingRateTier: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case from_value = "from_value"
        case id = "id"
        case method_id = "method_id"
        case position = "position"
        case price = "price"
        case updated_at = "updated_at"
    }

    /// When the row was created (UTC).
    public let created_at: String?
    /// Lower bound of this tier, in the method's matrix measure — kilograms (or whatever the market's `weight_unit` names, converted through its factor) for a weight matrix, items for quantity, money in the method's currency for order_value, and the raw attribute value for 'attribute'. INCLUSIVE: the tier applies from this value upward, and the tier that wins is the one with the highest from_value at or below the measured value, so a measure of exactly 10 is priced by the tier at 10 rather than the one below it. The last tier has no upper bound. Unique per method — a second tier at the same threshold is a 409, because which of the two won would be whatever the database returned first.
    public let from_value: Double?
    /// Row id, assigned by the database on insert.
    public let id: String?
    /// The shipping method this tier prices. Set from the path on every write, so a body that names another method is ignored rather than obeyed. ON DELETE CASCADE: deleting the method deletes its table.
    public let method_id: String?
    /// Display order in the matrix editor (default 0; a bulk replace derives it from the array index). Pricing reads from_value, never this.
    public let position: Int?
    /// What this tier costs, in the method's currency. Charged in full for the whole consignment — a matrix is a lookup table, not a rate per unit.
    public let price: Double?
    /// When the row was last written (UTC).
    public let updated_at: String?

    init(
        created_at: String?,
        from_value: Double?,
        id: String?,
        method_id: String?,
        position: Int?,
        price: Double?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.from_value = from_value
        self.id = id
        self.method_id = method_id
        self.position = position
        self.price = price
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.from_value = try container.decodeIfPresent(Double.self, forKey: .from_value)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.method_id = try container.decodeIfPresent(String.self, forKey: .method_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(from_value, forKey: .from_value)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(method_id, forKey: .method_id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "from_value": from_value as Any,
            "id": id as Any,
            "method_id": method_id as Any,
            "position": position as Any,
            "price": price as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRateTier {
        return ShippingRateTier(
            created_at: map["created_at"] as? String,
            from_value: map["from_value"] as? Double,
            id: map["id"] as? String,
            method_id: map["method_id"] as? String,
            position: map["position"] as? Int,
            price: map["price"] as? Double,
            updated_at: map["updated_at"] as? String
        )
    }
}
