import Foundation
import JSONCodable

/// 
open class InventoryRestockRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case location_code = "location_code"
        case order_ref = "order_ref"
        case reason = "reason"
    }

    /// The returned items (at most 200).
    public let items: [InventoryStockItem]
    /// Restocking location (default &#039;main&#039;).
    public let location_code: String?
    /// Originating order (ledger reference).
    public let order_ref: String?
    /// Ledger note (e.g. return reason).
    public let reason: String?

    init(
        items: [InventoryStockItem],
        location_code: String?,
        order_ref: String?,
        reason: String?
    ) {
        self.items = items
        self.location_code = location_code
        self.order_ref = order_ref
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([InventoryStockItem].self, forKey: .items)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(items, forKey: .items)
        try container.encodeIfPresent(location_code, forKey: .location_code)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items.map { $0.toMap() } as Any,
            "location_code": location_code as Any,
            "order_ref": order_ref as Any,
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryRestockRequest {
        return InventoryRestockRequest(
            items: (map["items"] as! [[String: Any]]).map { InventoryStockItem.from(map: $0) },
            location_code: map["location_code"] as? String,
            order_ref: map["order_ref"] as? String,
            reason: map["reason"] as? String
        )
    }
}
