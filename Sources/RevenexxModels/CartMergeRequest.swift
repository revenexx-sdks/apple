import Foundation
import JSONCodable

/// 
open class CartMergeRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case source_cart_id = "source_cart_id"
        case target_cart_id = "target_cart_id"
    }

    /// The cart being folded in. It must be active, and it does NOT survive as a workspace: its lines are copied into the target, it becomes status merged, and merged_into_cart_id points at the target. Its own lines stay on it as the record of what was moved.
    public let source_cart_id: String
    /// The cart that SURVIVES. Must be active; it gains the source's lines (identical product lines at the same price adding up) and its totals are recomputed.
    public let target_cart_id: String

    init(
        source_cart_id: String,
        target_cart_id: String
    ) {
        self.source_cart_id = source_cart_id
        self.target_cart_id = target_cart_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.source_cart_id = try container.decode(String.self, forKey: .source_cart_id)
        self.target_cart_id = try container.decode(String.self, forKey: .target_cart_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(source_cart_id, forKey: .source_cart_id)
        try container.encode(target_cart_id, forKey: .target_cart_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "source_cart_id": source_cart_id as Any,
            "target_cart_id": target_cart_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartMergeRequest {
        return CartMergeRequest(
            source_cart_id: map["source_cart_id"] as! String,
            target_cart_id: map["target_cart_id"] as! String
        )
    }
}
