import Foundation
import JSONCodable

/// 
open class CartOrderRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case order_ref = "order_ref"
    }

    /// The order number this cart becomes, in order management's own numbering. Stored on the cart — filtering on it is how anyone gets from an order back to the cart behind it — and it is also the reference the stock reservation is booked under. Omit it and the cart id is used for the reservation instead.
    public let order_ref: String?

    init(
        order_ref: String?
    ) {
        self.order_ref = order_ref
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(order_ref, forKey: .order_ref)
    }

    public func toMap() -> [String: Any] {
        return [
            "order_ref": order_ref as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartOrderRequest {
        return CartOrderRequest(
            order_ref: map["order_ref"] as? String
        )
    }
}
