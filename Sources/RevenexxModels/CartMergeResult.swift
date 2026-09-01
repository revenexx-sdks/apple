import Foundation
import JSONCodable

/// Which cart survived, and what it cost. `target` is the cart that SURVIVES, already recomputed — that is the one to render. The source cart still exists and still holds its own lines: a merge copies them into the target and closes the source, it does not move them.
open class CartMergeResult: Codable {

    enum CodingKeys: String, CodingKey {
        case merged_cart_id = "merged_cart_id"
        case merged_lines = "merged_lines"
        case target = "target"
    }

    /// The source cart, now status merged, with merged_into_cart_id pointing at the target. It still exists and still holds its own lines: the merge copies, it does not move.
    public let merged_cart_id: String?
    /// Lines read out of the source. Identical product lines at the same price add up rather than duplicating, so the target may have gained fewer rows than this.
    public let merged_lines: Int?
    /// 
    public let target: Cart?

    init(
        merged_cart_id: String?,
        merged_lines: Int?,
        target: Cart?
    ) {
        self.merged_cart_id = merged_cart_id
        self.merged_lines = merged_lines
        self.target = target
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.merged_cart_id = try container.decodeIfPresent(String.self, forKey: .merged_cart_id)
        self.merged_lines = try container.decodeIfPresent(Int.self, forKey: .merged_lines)
        self.target = try container.decodeIfPresent(Cart.self, forKey: .target)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(merged_cart_id, forKey: .merged_cart_id)
        try container.encodeIfPresent(merged_lines, forKey: .merged_lines)
        try container.encodeIfPresent(target, forKey: .target)
    }

    public func toMap() -> [String: Any] {
        return [
            "merged_cart_id": merged_cart_id as Any,
            "merged_lines": merged_lines as Any,
            "target": target?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartMergeResult {
        return CartMergeResult(
            merged_cart_id: map["merged_cart_id"] as? String,
            merged_lines: map["merged_lines"] as? Int,
            target: Cart.from(map: map["target"] as! [String: Any])
        )
    }
}
