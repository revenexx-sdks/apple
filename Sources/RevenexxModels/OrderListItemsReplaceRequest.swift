import Foundation
import JSONCodable

/// Replace ALL positions of the list (set semantics).
open class OrderListItemsReplaceRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }

    /// The new full set of positions, in the order they should carry. An empty array empties the list. Every existing position is deleted and rewritten, so ids are NOT preserved. The array order is the DEFAULT and not an override: an entry that names no `position` takes its index, one that names its own keeps it — so a replace does not by itself renumber the list from zero.
    public let items: [OrderListItemInput]

    init(
        items: [OrderListItemInput]
    ) {
        self.items = items
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([OrderListItemInput].self, forKey: .items)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(items, forKey: .items)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListItemsReplaceRequest {
        return OrderListItemsReplaceRequest(
            items: (map["items"] as! [[String: Any]]).map { OrderListItemInput.from(map: $0) }
        )
    }
}
