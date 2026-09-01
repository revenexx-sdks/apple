import Foundation
import JSONCodable
import RevenexxEnums

/// A position of the placed order — needs an identity: 'name' or 'sku'. Items are SNAPSHOTS: carry the product copy, prices are frozen at place-time.
open class OrderItemCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case configuration = "configuration"
        case cost_center = "cost_center"
        case metadata = "metadata"
        case name = "name"
        case position = "position"
        case position_text = "position_text"
        case product = "product"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
        case snapshot = "snapshot"
        case tax_amount = "tax_amount"
        case tax_rate = "tax_rate"
        case type = "type"
        case unit = "unit"
        case unit_price = "unit_price"
        case user_data = "user_data"
    }

    /// The chosen options of a configured line — what the configurator produced, in whatever shape it produces. Only meaningful for type 'configuration'; null everywhere else.
    public let configuration: [String: AnyCodable]?
    /// The buyer's own cost centre for this line — a B2B field: the same order is split across several of them and the buyer's finance department needs the split per line, not per order.
    public let cost_center: String?
    /// Free-form data belonging to the integration side, per position. Stored and returned untouched.
    public let metadata: [String: AnyCodable]?
    /// The article name as it stood at place-time, frozen. Falls back to the sku when the caller sent none — a position always reads as something. Falls back to 'sku' when omitted; one of the two is required.
    public let name: String?
    /// The line number a human reads, and what the order is sorted by. Numbered in steps of the range's position_step (10, 20, 30) unless the caller set it explicitly — the gap is what lets a line be inserted later without renumbering. Omitted = numbered in steps of the order range's position_step.
    public let position: Int?
    /// A free note the buyer attached to this line — an engraving, a delivery instruction, the drawing number the line refers to. Printed on the paperwork, read by nothing.
    public let position_text: String?
    /// The product as it was at place-time, FROZEN: the copy that makes the order still correct after the catalog changes its price, its name or its attributes. The caller decides how much of the product to freeze; this app stores it and reads nothing out of it. 'snapshot' is accepted as an alias for this key.
    public let product: [String: AnyCodable]?
    /// The catalog product this line was taken from (the products app). Null on a custom line, and it stays a reference — the position keeps working after the product is retired.
    public let product_id: String?
    /// How much was ORDERED, in `unit`. Three decimal places, so 2.5 m of cable is a real order line. Never changed afterwards — cancelling or returning writes the quantity_* columns instead, which is what keeps the order a truthful record of what was asked for. Defaults to 1.
    public let quantity: Double?
    /// The article number as it stood at place-time, frozen with the rest of the line. The value an ERP and a warehouse both join on, and the one field a picker reads. Null only on a line that never had one.
    public let sku: String?
    /// The product as it was at place-time, FROZEN: the copy that makes the order still correct after the catalog changes its price, its name or its attributes. The caller decides how much of the product to freeze; this app stores it and reads nothing out of it. Alias for 'product' — send one or the other, not both.
    public let snapshot: [String: AnyCodable]?
    /// Tax on this line in `currency`. Derived from line_total × tax_rate/100 when the caller sent none, which is the normal case — but a caller may send it, for a market whose rounding rules differ from ours. Send it only where your market rounds differently from line_total × tax_rate/100.
    public let tax_amount: Double?
    /// Tax percentage for this line, as a number (19 means 19 %). Frozen at place-time with everything else. Defaults to 0.
    public let tax_rate: Double?
    /// What kind of line this is: 'product' is a catalog article, 'configuration' a configured one carrying its configuration, 'custom' a line typed by hand that no catalog knows. Defaults to 'product'.
    public let type: RevenexxEnums.OrderItemType?
    /// The unit the quantity is counted in — piece, metre, kilogram, package. Free text as the catalog carries it; this app does no conversion.
    public let unit: String?
    /// NET price per unit, FROZEN at place-time. A later price change in the catalog does not reach this order. Defaults to 0. line_total is always derived from it and never taken from the body.
    public let unit_price: Double?
    /// Free-form data belonging to the ordering side, per position — carried through from the cart line and handed back untouched.
    public let user_data: [String: AnyCodable]?

    init(
        configuration: [String: AnyCodable]?,
        cost_center: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        position_text: String?,
        product: [String: AnyCodable]?,
        product_id: String?,
        quantity: Double?,
        sku: String?,
        snapshot: [String: AnyCodable]?,
        tax_amount: Double?,
        tax_rate: Double?,
        type: RevenexxEnums.OrderItemType?,
        unit: String?,
        unit_price: Double?,
        user_data: [String: AnyCodable]?
    ) {
        self.configuration = configuration
        self.cost_center = cost_center
        self.metadata = metadata
        self.name = name
        self.position = position
        self.position_text = position_text
        self.product = product
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
        self.snapshot = snapshot
        self.tax_amount = tax_amount
        self.tax_rate = tax_rate
        self.type = type
        self.unit = unit
        self.unit_price = unit_price
        self.user_data = user_data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.configuration = try container.decodeIfPresent([String: AnyCodable].self, forKey: .configuration)
        self.cost_center = try container.decodeIfPresent(String.self, forKey: .cost_center)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.position_text = try container.decodeIfPresent(String.self, forKey: .position_text)
        self.product = try container.decodeIfPresent([String: AnyCodable].self, forKey: .product)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.snapshot = try container.decodeIfPresent([String: AnyCodable].self, forKey: .snapshot)
        self.tax_amount = try container.decodeIfPresent(Double.self, forKey: .tax_amount)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = RevenexxEnums.OrderItemType(rawValue: typeString)
        } else {
            self.type = nil
        }
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.user_data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user_data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(configuration, forKey: .configuration)
        try container.encodeIfPresent(cost_center, forKey: .cost_center)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(position_text, forKey: .position_text)
        try container.encodeIfPresent(product, forKey: .product)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(snapshot, forKey: .snapshot)
        try container.encodeIfPresent(tax_amount, forKey: .tax_amount)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(user_data, forKey: .user_data)
    }

    public func toMap() -> [String: Any] {
        return [
            "configuration": configuration as Any,
            "cost_center": cost_center as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "position_text": position_text as Any,
            "product": product as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "snapshot": snapshot as Any,
            "tax_amount": tax_amount as Any,
            "tax_rate": tax_rate as Any,
            "type": type?.rawValue as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "user_data": user_data as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderItemCreateRequest {
        return OrderItemCreateRequest(
            configuration: map["configuration"] as? [String: AnyCodable],
            cost_center: map["cost_center"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            position_text: map["position_text"] as? String,
            product: map["product"] as? [String: AnyCodable],
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String,
            snapshot: map["snapshot"] as? [String: AnyCodable],
            tax_amount: map["tax_amount"] as? Double,
            tax_rate: map["tax_rate"] as? Double,
            type: map["type"] as? String != nil ? OrderItemType(rawValue: map["type"] as! String) : nil,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            user_data: map["user_data"] as? [String: AnyCodable]
        )
    }
}
