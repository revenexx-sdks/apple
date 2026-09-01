import Foundation
import JSONCodable

/// 
open class CartItemsReplaceRequest<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }

    /// The complete new item set (set semantics).
    public let items: [CartItemCreateRequest<T>]

    init(
        items: [CartItemCreateRequest<T>]
    ) {
        self.items = items
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([CartItemCreateRequest<T>].self, forKey: .items)
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

    public static func from(map: [String: Any] ) -> CartItemsReplaceRequest {
        return CartItemsReplaceRequest(
            items: (map["items"] as! [[String: Any]]).map { CartItemCreateRequest.from(map: $0) }
        )
    }
}
