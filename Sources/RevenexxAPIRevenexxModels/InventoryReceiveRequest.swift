import Foundation
import JSONCodable

/// 
open class InventoryReceiveRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case location_code = "location_code"
        case reason = "reason"
    }

    /// The inbound items (at most 200).
    public let items: [InventoryStockItem]
    /// Receiving location (default &#039;main&#039;).
    public let location_code: String?
    /// Ledger note (e.g. delivery note number).
    public let reason: String?

    init(
        items: [InventoryStockItem],
        location_code: String?,
        reason: String?
    ) {
        self.items = items
        self.location_code = location_code
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([InventoryStockItem].self, forKey: .items)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(items, forKey: .items)
        try container.encodeIfPresent(location_code, forKey: .location_code)
        try container.encodeIfPresent(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items.map { $0.toMap() } as Any,
            "location_code": location_code as Any,
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryReceiveRequest {
        return InventoryReceiveRequest(
            items: (map["items"] as! [[String: Any]]).map { InventoryStockItem.from(map: $0) },
            location_code: map["location_code"] as? String,
            reason: map["reason"] as? String
        )
    }
}
