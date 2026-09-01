import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class CartItem<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case cart_id = "cart_id"
        case configuration = "configuration"
        case created_at = "created_at"
        case currency = "currency"
        case id = "id"
        case line_total = "line_total"
        case metadata = "metadata"
        case name = "name"
        case position = "position"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
        case snapshot = "snapshot"
        case tax_rate = "tax_rate"
        case tenant_id = "tenant_id"
        case type = "type"
        case unit = "unit"
        case unit_price = "unit_price"
        case updated_at = "updated_at"
    }

    /// The cart this line belongs to. A line never moves between carts — a merge copies it into the target and closes the source cart.
    public let cart_id: String?
    /// What was configured on this line, in the configurator's own vocabulary — this app stores it and reads nothing out of it. Its mere PRESENCE is behaviour: a line that carries a configuration never merges with another, because two differently configured units of the same article are not one line. Keys are the configurator's; the example is one shape, not the shape.
    public let configuration: [String: AnyCodable]?
    /// When the line was added. A merge into an existing line keeps the original — the quantity moved, the line did not.
    public let created_at: String?
    /// ISO 4217 code this line is priced in. Defaults to the cart's currency when a line is added without one.
    public let currency: String?
    /// The line, as carts.items.get/update/delete address it.
    public let id: String?
    /// quantity × unit_price, net, always derived. A line_total in a payload is ignored: the cart may not disagree with its own arithmetic.
    public let line_total: Double?
    /// Free-form data the storefront hangs on the line. Stored and returned verbatim; no key in here is read by this app.
    public let metadata: [String: AnyCodable]?
    /// What the line reads as on the cart page. Falls back to the SKU when a caller sends none, so a line always has something to show.
    public let name: String?
    /// Sort order within the cart, ascending. Lines come back in this order unless `order` says otherwise, and a bulk replace numbers them by their place in the payload.
    public let position: Int?
    /// The catalogue product this line came from, when it came from one. Null on a custom line, and null on a product line the storefront identified by SKU alone.
    public let product_id: String?
    /// How much of it. Fractional on purpose — 2.5 metres of cable is a line, not a rounding error — and always greater than zero: removing a line is a DELETE, not a quantity of 0.
    public let quantity: Double?
    /// The article number the merchant sorts by in the ERP — the value every integration joins on. Free text here: this app does not resolve it against the catalogue, so it is exactly what the storefront wrote into the line. Together with product_id and unit_price it decides whether adding the same article again lands on this line or opens a new one.
    public let sku: String?
    /// The product as the buyer was shown it when this line was added — the cart's own copy, so it stays honest when the catalogue moves underneath it. Free-form apart from the price: conversion reads `unit_price` (or `price` as a fallback) and nothing else. A snapshot without a readable price leaves the line alone in both price modes, which is deliberate — a missing snapshot must never be read as "free".
    public let snapshot: CartItemSnapshot<T>?
    /// VAT percent for this line, as a number (19 means 19 %). Stored with the line for the order to use — no total in this app includes tax.
    public let tax_rate: Double?
    /// The tenant this row belongs to, echoed by the data plane.
    public let tenant_id: String?
    /// What kind of line this is. 'product' is a catalogue line and the only type that ever merges with another. 'configuration' is a configured product — it carries its configuration and always stands alone, because two differently configured units of the same article are not the same line. 'custom' is a free line nobody has to find in a catalogue: a service, a surcharge, a hand-typed position.
    public let type: RevenexxEnums.CartItemType?
    /// The unit the quantity is counted in ('pcs', 'm', 'kg', 'h'). Display and ERP hand-over only; this app converts nothing.
    public let unit: String?
    /// Net price of ONE unit, in the line's currency. This is the working price — a resync, a PUT on the line or a repricing job may have moved it since the buyer saw it. The price the buyer WAS shown lives in snapshot, and carts.order decides which of the two the order is booked on.
    public let unit_price: Double?
    /// When the line last changed — including a quantity another add merged into it.
    public let updated_at: String?

    init(
        cart_id: String?,
        configuration: [String: AnyCodable]?,
        created_at: String?,
        currency: String?,
        id: String?,
        line_total: Double?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        product_id: String?,
        quantity: Double?,
        sku: String?,
        snapshot: CartItemSnapshot<T>?,
        tax_rate: Double?,
        tenant_id: String?,
        type: RevenexxEnums.CartItemType?,
        unit: String?,
        unit_price: Double?,
        updated_at: String?
    ) {
        self.cart_id = cart_id
        self.configuration = configuration
        self.created_at = created_at
        self.currency = currency
        self.id = id
        self.line_total = line_total
        self.metadata = metadata
        self.name = name
        self.position = position
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
        self.snapshot = snapshot
        self.tax_rate = tax_rate
        self.tenant_id = tenant_id
        self.type = type
        self.unit = unit
        self.unit_price = unit_price
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.configuration = try container.decodeIfPresent([String: AnyCodable].self, forKey: .configuration)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.line_total = try container.decodeIfPresent(Double.self, forKey: .line_total)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.snapshot = try container.decodeIfPresent(CartItemSnapshot<T>.self, forKey: .snapshot)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = RevenexxEnums.CartItemType(rawValue: typeString)
        } else {
            self.type = nil
        }
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(configuration, forKey: .configuration)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(line_total, forKey: .line_total)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(snapshot, forKey: .snapshot)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "cart_id": cart_id as Any,
            "configuration": configuration as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "id": id as Any,
            "line_total": line_total as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "snapshot": snapshot?.toMap() as Any,
            "tax_rate": tax_rate as Any,
            "tenant_id": tenant_id as Any,
            "type": type?.rawValue as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartItem {
        return CartItem(
            cart_id: map["cart_id"] as? String,
            configuration: map["configuration"] as? [String: AnyCodable],
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            id: map["id"] as? String,
            line_total: map["line_total"] as? Double,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String,
            snapshot: CartItemSnapshot.from(map: map["snapshot"] as! [String: Any]),
            tax_rate: map["tax_rate"] as? Double,
            tenant_id: map["tenant_id"] as? String,
            type: map["type"] as? String != nil ? CartItemType(rawValue: map["type"] as! String) : nil,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            updated_at: map["updated_at"] as? String
        )
    }
}
