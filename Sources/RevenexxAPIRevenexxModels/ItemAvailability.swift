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

    /// 
    public let available: Double?
    /// 
    public let locations: [Any]?
    /// 
    public let on_hand: Double?
    /// 
    public let orderable: Bool?
    /// 
    public let product_id: String?
    /// 
    public let requested: Double?
    /// 
    public let reserved: Double?
    /// 
    public let sku: String?
    /// false = unknown to inventory; the storefront decides whether untracked items sell freely.
    public let tracked: Bool?

    init(
        available: Double?,
        locations: [Any]?,
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
        self.locations = try container.decodeIfPresent([Any].self, forKey: .locations)
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
            "locations": locations as Any,
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
            locations: map["locations"] as? [Any],
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
