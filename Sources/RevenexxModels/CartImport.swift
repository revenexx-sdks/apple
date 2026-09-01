import Foundation
import JSONCodable

/// `cart` is the cart as it now stands, totals already recomputed — the newly created one, or the target with the imported lines folded in.
open class CartImport: Codable {

    enum CodingKeys: String, CodingKey {
        case cart = "cart"
        case imported_lines = "imported_lines"
    }

    /// 
    public let cart: Cart?
    /// Lines read out of the payload. Identical product lines merge, so the cart may have gained fewer rows than this.
    public let imported_lines: Int?

    init(
        cart: Cart?,
        imported_lines: Int?
    ) {
        self.cart = cart
        self.imported_lines = imported_lines
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cart = try container.decodeIfPresent(Cart.self, forKey: .cart)
        self.imported_lines = try container.decodeIfPresent(Int.self, forKey: .imported_lines)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cart, forKey: .cart)
        try container.encodeIfPresent(imported_lines, forKey: .imported_lines)
    }

    public func toMap() -> [String: Any] {
        return [
            "cart": cart?.toMap() as Any,
            "imported_lines": imported_lines as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartImport {
        return CartImport(
            cart: Cart.from(map: map["cart"] as! [String: Any]),
            imported_lines: map["imported_lines"] as? Int
        )
    }
}
