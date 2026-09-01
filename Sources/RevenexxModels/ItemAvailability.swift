import Foundation
import JSONCodable

/// 
open class ItemAvailability: Codable {

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case locations = "locations"
        case on_hand = "on_hand"
        case orderable = "orderable"
        case product_id = "product_id"
        case requested = "requested"
        case reserved = "reserved"
        case sku = "sku"
        case tracked = "tracked"
    }

    /// on_hand − reserved across the locations in scope: available-to-promise, and the number a storefront shows. It can be NEGATIVE once backorders have been reserved beyond stock — nothing floors it, because "sold more than we hold" is a real state a merchant needs to see.
    public let available: Double?
    /// The per-location breakdown behind the summed figures — which place could actually ship it.
    public let locations: [LocationAvailability]?
    /// Physically in stock, summed across the locations in scope (every enabled location, or the one `location_code` named). Promised units are included, so this is NOT what may be sold.
    public let on_hand: Double?
    /// True when the item is tracked and `available >= requested` at this moment. A SNAPSHOT, not a hold: nothing is set aside until POST /inventories/reserve, and two checkouts can both read true for the last unit.
    public let orderable: Bool?
    /// The product id as it was asked for, echoed. Null when the item was named by SKU.
    public let product_id: String?
    /// The quantity the check was made against — the item's own `quantity`, or 1 when none was sent. `orderable` answers "can I have this many?", so it is only as strict as this number.
    public let requested: Double?
    /// Already promised to orders, summed across the same locations — the part of `on_hand` that is spoken for.
    public let reserved: Double?
    /// The SKU as it was asked for, echoed. Null when the item was named by product id.
    public let sku: String?
    /// False when this app has never seen the item: no stock row anywhere in scope. It is not an error and not a zero — the storefront decides whether an untracked item sells freely (a service, a made-to-order piece) or not at all. `on_hand`, `reserved` and `available` are 0 in that case, and `orderable` is false.
    public let tracked: Bool?

    init(
        available: Double?,
        locations: [LocationAvailability]?,
        on_hand: Double?,
        orderable: Bool?,
        product_id: String?,
        requested: Double?,
        reserved: Double?,
        sku: String?,
        tracked: Bool?
    ) {
        self.available = available
        self.locations = locations
        self.on_hand = on_hand
        self.orderable = orderable
        self.product_id = product_id
        self.requested = requested
        self.reserved = reserved
        self.sku = sku
        self.tracked = tracked
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.available = try container.decodeIfPresent(Double.self, forKey: .available)
        self.locations = try container.decodeIfPresent([LocationAvailability].self, forKey: .locations)
        self.on_hand = try container.decodeIfPresent(Double.self, forKey: .on_hand)
        self.orderable = try container.decodeIfPresent(Bool.self, forKey: .orderable)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.requested = try container.decodeIfPresent(Double.self, forKey: .requested)
        self.reserved = try container.decodeIfPresent(Double.self, forKey: .reserved)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.tracked = try container.decodeIfPresent(Bool.self, forKey: .tracked)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(available, forKey: .available)
        try container.encodeIfPresent(locations, forKey: .locations)
        try container.encodeIfPresent(on_hand, forKey: .on_hand)
        try container.encodeIfPresent(orderable, forKey: .orderable)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(requested, forKey: .requested)
        try container.encodeIfPresent(reserved, forKey: .reserved)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(tracked, forKey: .tracked)
    }

    public func toMap() -> [String: Any] {
        return [
            "available": available as Any,
            "locations": locations?.map { $0.toMap() } as Any,
            "on_hand": on_hand as Any,
            "orderable": orderable as Any,
            "product_id": product_id as Any,
            "requested": requested as Any,
            "reserved": reserved as Any,
            "sku": sku as Any,
            "tracked": tracked as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ItemAvailability {
        return ItemAvailability(
            available: map["available"] as? Double,
            locations: (map["locations"] as? [[String: Any]] ?? []).map { LocationAvailability.from(map: $0) },
            on_hand: map["on_hand"] as? Double,
            orderable: map["orderable"] as? Bool,
            product_id: map["product_id"] as? String,
            requested: map["requested"] as? Double,
            reserved: map["reserved"] as? Double,
            sku: map["sku"] as? String,
            tracked: map["tracked"] as? Bool
        )
    }
}
