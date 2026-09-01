import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class OrderListToCartResult: Codable {

    enum CodingKeys: String, CodingKey {
        case added = "added"
        case cart_created = "cart_created"
        case cart_id = "cart_id"
        case list_id = "list_id"
        case mode = "mode"
        case skipped = "skipped"
    }

    /// Positions written to the cart. Equal to the list's position count minus `skipped`.
    public let added: Int?
    /// True when this call created the cart. A created cart is the owner's CURRENT cart, because a cart the buyer cannot see is not "added to cart".
    public let cart_created: Bool?
    /// The cart the positions landed in: the one that was passed in, or the one this call created.
    public let cart_id: String?
    /// The list that was converted. Unchanged by the call — a conversion reads the list, it never empties it.
    public let list_id: String?
    /// The mode that was actually applied — the one that was asked for, or the tenant's 'cart_merge_mode' default when the call named none.
    public let mode: RevenexxEnums.OrderListCartMode?
    /// Positions left out because the catalogue no longer knows their article. Only ever non-empty when 'on_missing_article' is 'skip' — 'include' converts them anyway and 'fail' answers 400 instead.
    public let skipped: [OrderListSkippedPosition]?

    init(
        added: Int?,
        cart_created: Bool?,
        cart_id: String?,
        list_id: String?,
        mode: RevenexxEnums.OrderListCartMode?,
        skipped: [OrderListSkippedPosition]?
    ) {
        self.added = added
        self.cart_created = cart_created
        self.cart_id = cart_id
        self.list_id = list_id
        self.mode = mode
        self.skipped = skipped
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.added = try container.decodeIfPresent(Int.self, forKey: .added)
        self.cart_created = try container.decodeIfPresent(Bool.self, forKey: .cart_created)
        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.list_id = try container.decodeIfPresent(String.self, forKey: .list_id)
        if let modeString = try container.decodeIfPresent(String.self, forKey: .mode) {
            self.mode = RevenexxEnums.OrderListCartMode(rawValue: modeString)
        } else {
            self.mode = nil
        }
        self.skipped = try container.decodeIfPresent([OrderListSkippedPosition].self, forKey: .skipped)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(added, forKey: .added)
        try container.encodeIfPresent(cart_created, forKey: .cart_created)
        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(list_id, forKey: .list_id)
        try container.encodeIfPresent(mode?.rawValue, forKey: .mode)
        try container.encodeIfPresent(skipped, forKey: .skipped)
    }

    public func toMap() -> [String: Any] {
        return [
            "added": added as Any,
            "cart_created": cart_created as Any,
            "cart_id": cart_id as Any,
            "list_id": list_id as Any,
            "mode": mode?.rawValue as Any,
            "skipped": skipped?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListToCartResult {
        return OrderListToCartResult(
            added: map["added"] as? Int,
            cart_created: map["cart_created"] as? Bool,
            cart_id: map["cart_id"] as? String,
            list_id: map["list_id"] as? String,
            mode: map["mode"] as? String != nil ? OrderListCartMode(rawValue: map["mode"] as! String) : nil,
            skipped: (map["skipped"] as? [[String: Any]] ?? []).map { OrderListSkippedPosition.from(map: $0) }
        )
    }
}
