import Foundation
import JSONCodable

/// 
open class OrderListItem: Codable {

    enum CodingKeys: String, CodingKey {
        case category_slug = "category_slug"
        case cost_center_id = "cost_center_id"
        case created_at = "created_at"
        case custom_sku = "custom_sku"
        case id = "id"
        case image = "image"
        case list_id = "list_id"
        case metadata = "metadata"
        case name = "name"
        case position = "position"
        case position_texts = "position_texts"
        case price = "price"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
        case subcategory_slug = "subcategory_slug"
        case tax_rate = "tax_rate"
        case tenant_id = "tenant_id"
        case unit = "unit"
        case updated_at = "updated_at"
    }

    /// The catalogue category the article sat in when the position was saved, as a slug. Kept so a long list can be grouped the way the shop groups it without a call to the catalogue.
    public let category_slug: String?
    /// The cost centre this position books to, as the tenant's ERP names it. Free text and not our enum. It survives into the ORDER position, which has a `cost_center` column; a CART line has none, so the cart conversion carries it in the line snapshot instead.
    public let cost_center_id: String?
    /// When the position was added to the list.
    public let created_at: String?
    /// The buyer's OWN article number for this article — what their purchasing system calls it, which is rarely what the shop calls it. Free text, and the field a B2B buyer searches their own lists by.
    public let custom_sku: String?
    /// The position, by id.
    public let id: String?
    /// The article image at the time the position was saved, as a URL or a path — a snapshot like `name`, and nothing here refreshes it. It rides into the cart line and the order position in their snapshot, because neither has a column for it.
    public let image: String?
    /// The list this position belongs to. Taken from the path and never from the payload — a position does not move between lists.
    public let list_id: String?
    /// Free-form data the tenant keeps on the position. Never read by this app; it travels into the cart line / order position snapshot untouched. A write replaces the whole document rather than merging into it.
    public let metadata: [String: AnyCodable]?
    /// The article name AS IT WAS when the position was saved. A snapshot on purpose: the list is the buyer's own record, so a renamed or withdrawn article still reads the way they wrote it down.
    public let name: String?
    /// Sort order within the list, ascending — the order the positions collection returns by default and the order the conversions hand the lines over in. Neither dense nor unique: an add with no `position` of its own takes the list's current position COUNT, so removing a position from the middle and adding another leaves two rows sharing a number. A bulk replace assigns the array index the same way, so it renumbers only the positions it is not given explicitly.
    public let position: Int?
    /// Per-position notes the buyer wrote — an engraving, a delivery instruction, a reference for the picker. An ARRAY OF STRINGS, one entry per line; the order conversion joins them with newlines into the order position's single `position_text`, and the cart conversion carries the array in the line snapshot.
    public let position_texts: [String: AnyCodable]?
    /// Unit price snapshot — what the buyer saw when they saved the position, in whatever way the catalogue quoted it. It is a record, not a live price: the cart and the order reprice on their own terms, so this never becomes what somebody is charged.
    public let price: Double?
    /// The catalogue product this position stands for. One of `product_id` / `sku` must be set (the database enforces it); this is the identity the products app answers to, and the one `reject_unknown_articles` and the conversions check against.
    public let product_id: String?
    /// How much of the article the list holds. Greater than zero — the database refuses the rest — and fractional to three decimals, because a B2B position may be 2.5 metres or 0.75 kilos.
    public let quantity: Double?
    /// The article number as the catalogue knows it — the alternative identity to `product_id`, and the one an ERP integration usually joins on.
    public let sku: String?
    /// The catalogue subcategory, as a slug. Same purpose as `category_slug`, one level down.
    public let subcategory_slug: String?
    /// The VAT rate that applied when the position was saved, as a PERCENT (19 = 19 %). Four decimals so a rate like 8.25 % survives; carts and orders document the same field the same way, and the conversion forwards the number unchanged.
    public let tax_rate: Double?
    /// The tenant this row belongs to, as a slug. Set by the platform, never by a caller — it is the row-level security scope, not a field, and every row a request can reach is inside it already.
    public let tenant_id: String?
    /// The unit `quantity` counts in, in the tenant's own words. Deliberately open text and deliberately NOT a vocabulary: a B2B catalogue units in pieces, metres, kilos, rolls and pallets, and any closed list published here would be a guess.
    public let unit: String?
    /// When the position was last changed.
    public let updated_at: String?

    init(
        category_slug: String?,
        cost_center_id: String?,
        created_at: String?,
        custom_sku: String?,
        id: String?,
        image: String?,
        list_id: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        position_texts: [String: AnyCodable]?,
        price: Double?,
        product_id: String?,
        quantity: Double?,
        sku: String?,
        subcategory_slug: String?,
        tax_rate: Double?,
        tenant_id: String?,
        unit: String?,
        updated_at: String?
    ) {
        self.category_slug = category_slug
        self.cost_center_id = cost_center_id
        self.created_at = created_at
        self.custom_sku = custom_sku
        self.id = id
        self.image = image
        self.list_id = list_id
        self.metadata = metadata
        self.name = name
        self.position = position
        self.position_texts = position_texts
        self.price = price
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
        self.subcategory_slug = subcategory_slug
        self.tax_rate = tax_rate
        self.tenant_id = tenant_id
        self.unit = unit
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.category_slug = try container.decodeIfPresent(String.self, forKey: .category_slug)
        self.cost_center_id = try container.decodeIfPresent(String.self, forKey: .cost_center_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.custom_sku = try container.decodeIfPresent(String.self, forKey: .custom_sku)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.list_id = try container.decodeIfPresent(String.self, forKey: .list_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.position_texts = try container.decodeIfPresent([String: AnyCodable].self, forKey: .position_texts)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.subcategory_slug = try container.decodeIfPresent(String.self, forKey: .subcategory_slug)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(category_slug, forKey: .category_slug)
        try container.encodeIfPresent(cost_center_id, forKey: .cost_center_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(custom_sku, forKey: .custom_sku)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(list_id, forKey: .list_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(position_texts, forKey: .position_texts)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(subcategory_slug, forKey: .subcategory_slug)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "category_slug": category_slug as Any,
            "cost_center_id": cost_center_id as Any,
            "created_at": created_at as Any,
            "custom_sku": custom_sku as Any,
            "id": id as Any,
            "image": image as Any,
            "list_id": list_id as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "position_texts": position_texts as Any,
            "price": price as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "subcategory_slug": subcategory_slug as Any,
            "tax_rate": tax_rate as Any,
            "tenant_id": tenant_id as Any,
            "unit": unit as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListItem {
        return OrderListItem(
            category_slug: map["category_slug"] as? String,
            cost_center_id: map["cost_center_id"] as? String,
            created_at: map["created_at"] as? String,
            custom_sku: map["custom_sku"] as? String,
            id: map["id"] as? String,
            image: map["image"] as? String,
            list_id: map["list_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            position_texts: map["position_texts"] as? [String: AnyCodable],
            price: map["price"] as? Double,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String,
            subcategory_slug: map["subcategory_slug"] as? String,
            tax_rate: map["tax_rate"] as? Double,
            tenant_id: map["tenant_id"] as? String,
            unit: map["unit"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
