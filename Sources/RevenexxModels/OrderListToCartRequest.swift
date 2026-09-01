import Foundation
import JSONCodable
import RevenexxEnums

/// Every field is optional: with an empty body the list goes into a NEW cart for its owner, on the tenant defaults.
open class OrderListToCartRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case cart_id = "cart_id"
        case currency = "currency"
        case mode = "mode"
    }

    /// Add to this existing cart. Omit to create one for the list owner and make it their current cart.
    public let cart_id: String?
    /// ISO 4217 code for the cart and its lines. Omit to let the carts app decide.
    public let currency: String?
    /// 'append' adds the positions (the carts app merges a line by product and price, so quantities accumulate); 'replace' makes the list the cart's entire contents. Defaults to the tenant's 'cart_merge_mode' setting.
    public let mode: RevenexxEnums.OrderListCartMode?

    init(
        cart_id: String?,
        currency: String?,
        mode: RevenexxEnums.OrderListCartMode?
    ) {
        self.cart_id = cart_id
        self.currency = currency
        self.mode = mode
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        if let modeString = try container.decodeIfPresent(String.self, forKey: .mode) {
            self.mode = RevenexxEnums.OrderListCartMode(rawValue: modeString)
        } else {
            self.mode = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(mode?.rawValue, forKey: .mode)
    }

    public func toMap() -> [String: Any] {
        return [
            "cart_id": cart_id as Any,
            "currency": currency as Any,
            "mode": mode?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListToCartRequest {
        return OrderListToCartRequest(
            cart_id: map["cart_id"] as? String,
            currency: map["currency"] as? String,
            mode: map["mode"] as? String != nil ? OrderListCartMode(rawValue: map["mode"] as! String) : nil
        )
    }
}
