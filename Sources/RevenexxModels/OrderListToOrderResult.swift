import Foundation
import JSONCodable

/// 
open class OrderListToOrderResult: Codable {

    enum CodingKeys: String, CodingKey {
        case list_id = "list_id"
        case order = "order"
        case order_id = "order_id"
        case order_number = "order_number"
        case positions = "positions"
        case skipped = "skipped"
        case status = "status"
    }

    /// The list that was ordered. Unchanged by the call — the list stays, so it can be ordered again next month.
    public let list_id: String?
    /// The orders app's answer, verbatim and unreshaped — the whole created order, whose shape is the orders app's own `Order` schema (GET /v1/orders/{id}) and is deliberately not restated here, because a copy would be the thing that goes stale. `order_id`, `order_number` and `status` are lifted out of it for a client that needs nothing else.
    public let order: [String: AnyCodable]?
    /// The order the orders app created. Null only when that app answered without one, which is a fault worth reporting rather than a normal outcome.
    public let order_id: String?
    /// The order number a human quotes, drawn from the tenant's order range by the orders app. It is NOT the id: every orders route addresses an order by uuid.
    public let order_number: String?
    /// Positions handed to the orders app — the list's count minus `skipped`.
    public let positions: Int?
    /// Positions left out because the catalogue no longer knows their article. Only ever non-empty when 'on_missing_article' is 'skip'.
    public let skipped: [OrderListSkippedPosition]?
    /// Where the new order stands, as the orders app decided: 'placed' when it was accepted outright, 'pending' when it awaits approval — a contact holding only orders.request, or an order above the tenant's approval threshold. This app does not choose it and cannot override it.
    public let status: String?

    init(
        list_id: String?,
        order: [String: AnyCodable]?,
        order_id: String?,
        order_number: String?,
        positions: Int?,
        skipped: [OrderListSkippedPosition]?,
        status: String?
    ) {
        self.list_id = list_id
        self.order = order
        self.order_id = order_id
        self.order_number = order_number
        self.positions = positions
        self.skipped = skipped
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.list_id = try container.decodeIfPresent(String.self, forKey: .list_id)
        self.order = try container.decodeIfPresent([String: AnyCodable].self, forKey: .order)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.order_number = try container.decodeIfPresent(String.self, forKey: .order_number)
        self.positions = try container.decodeIfPresent(Int.self, forKey: .positions)
        self.skipped = try container.decodeIfPresent([OrderListSkippedPosition].self, forKey: .skipped)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(list_id, forKey: .list_id)
        try container.encodeIfPresent(order, forKey: .order)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(order_number, forKey: .order_number)
        try container.encodeIfPresent(positions, forKey: .positions)
        try container.encodeIfPresent(skipped, forKey: .skipped)
        try container.encodeIfPresent(status, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "list_id": list_id as Any,
            "order": order as Any,
            "order_id": order_id as Any,
            "order_number": order_number as Any,
            "positions": positions as Any,
            "skipped": skipped?.map { $0.toMap() } as Any,
            "status": status as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListToOrderResult {
        return OrderListToOrderResult(
            list_id: map["list_id"] as? String,
            order: map["order"] as? [String: AnyCodable],
            order_id: map["order_id"] as? String,
            order_number: map["order_number"] as? String,
            positions: map["positions"] as? Int,
            skipped: (map["skipped"] as? [[String: Any]] ?? []).map { OrderListSkippedPosition.from(map: $0) },
            status: map["status"] as? String
        )
    }
}
