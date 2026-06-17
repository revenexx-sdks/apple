import Foundation
import JSONCodable

/// 
open class InventoryAdjustRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case location_code = "location_code"
        case reason = "reason"
    }

    /// The corrections — quantities are SIGNED deltas (at most 200).
    public let items: [InventoryAdjustItem]
    /// Adjusted location (default &#039;main&#039;).
    public let location_code: String?
    /// Mandatory audit reason — every adjustment is a ledger row.
    public let reason: String

    init(
        items: [InventoryAdjustItem],
        location_code: String?,
        reason: String
    ) {
        self.items = items
        self.location_code = location_code
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([InventoryAdjustItem].self, forKey: .items)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
        self.reason = try container.decode(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(items, forKey: .items)
        try container.encodeIfPresent(location_code, forKey: .location_code)
        try container.encode(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items.map { $0.toMap() } as Any,
            "location_code": location_code as Any,
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryAdjustRequest {
        return InventoryAdjustRequest(
            items: (map["items"] as! [[String: Any]]).map { InventoryAdjustItem.from(map: $0) },
            location_code: map["location_code"] as? String,
            reason: map["reason"] as! String
        )
    }
}
