import Foundation
import JSONCodable

/// 
open class ShippingRateTiersReplaceRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case tiers = "tiers"
    }

    /// The complete new tier set (set semantics) — positions are derived from the array order.
    public let tiers: [ShippingRateTierReplaceItem]

    init(
        tiers: [ShippingRateTierReplaceItem]
    ) {
        self.tiers = tiers
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.tiers = try container.decode([ShippingRateTierReplaceItem].self, forKey: .tiers)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(tiers, forKey: .tiers)
    }

    public func toMap() -> [String: Any] {
        return [
            "tiers": tiers.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRateTiersReplaceRequest {
        return ShippingRateTiersReplaceRequest(
            tiers: (map["tiers"] as! [[String: Any]]).map { ShippingRateTierReplaceItem.from(map: $0) }
        )
    }
}
