import Foundation
import JSONCodable

/// 
open class CartMergeIntoRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case target_cart_id = "target_cart_id"
    }

    /// Receiving cart (must be active). The cart in the path is the source and becomes status merged.
    public let target_cart_id: String

    init(
        target_cart_id: String
    ) {
        self.target_cart_id = target_cart_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.target_cart_id = try container.decode(String.self, forKey: .target_cart_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(target_cart_id, forKey: .target_cart_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "target_cart_id": target_cart_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartMergeIntoRequest {
        return CartMergeIntoRequest(
            target_cart_id: map["target_cart_id"] as! String
        )
    }
}
