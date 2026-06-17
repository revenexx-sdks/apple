import Foundation
import JSONCodable

/// 
open class InventoryReserveRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case expires_at = "expires_at"
        case items = "items"
        case order_ref = "order_ref"
    }

    /// Optional reservation expiry.
    public let expires_at: String?
    /// The items to reserve — all-or-nothing (at most 200).
    public let items: [InventoryStockItem]
    /// The order this reservation belongs to.
    public let order_ref: String

    init(
        expires_at: String?,
        items: [InventoryStockItem],
        order_ref: String
    ) {
        self.expires_at = expires_at
        self.items = items
        self.order_ref = order_ref
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.expires_at = try container.decodeIfPresent(String.self, forKey: .expires_at)
        self.items = try container.decode([InventoryStockItem].self, forKey: .items)
        self.order_ref = try container.decode(String.self, forKey: .order_ref)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(expires_at, forKey: .expires_at)
        try container.encode(items, forKey: .items)
        try container.encode(order_ref, forKey: .order_ref)
    }

    public func toMap() -> [String: Any] {
        return [
            "expires_at": expires_at as Any,
            "items": items.map { $0.toMap() } as Any,
            "order_ref": order_ref as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryReserveRequest {
        return InventoryReserveRequest(
            expires_at: map["expires_at"] as? String,
            items: (map["items"] as! [[String: Any]]).map { InventoryStockItem.from(map: $0) },
            order_ref: map["order_ref"] as! String
        )
    }
}
