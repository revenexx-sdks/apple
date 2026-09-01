import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ReorderAlert: Codable {

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case location_code = "location_code"
        case location_enabled = "location_enabled"
        case location_id = "location_id"
        case on_hand = "on_hand"
        case product_id = "product_id"
        case reorder_point = "reorder_point"
        case reorder_point_source = "reorder_point_source"
        case reserved = "reserved"
        case shortfall = "shortfall"
        case sku = "sku"
        case stock_level_id = "stock_level_id"
    }

    /// on_hand − reserved: the figure compared against the reorder point. Alerting on AVAILABLE rather than on_hand is the point of this list — a shelf that looks full but is entirely sold is exactly the row a buyer must see.
    public let available: Double?
    /// That location's code, resolved for the reader so no second call is needed. Null if the location row could not be read.
    public let location_code: String?
    /// Whether that location is enabled. A DISABLED location still alerts — its stock is invisible to availability, but the goods are real and somebody has to decide. Null if the location row could not be read.
    public let location_enabled: Bool?
    /// The location holding it.
    public let location_id: String?
    /// What is physically there right now, promised units included.
    public let on_hand: Double?
    /// The product this row tracks, null when it is tracked by SKU.
    public let product_id: String?
    /// The threshold that was applied to this row — its own, or the tenant default.
    public let reorder_point: Double?
    /// 'row' — the stock row's own threshold. 'default' — the reorder_point_default setting.
    public let reorder_point_source: RevenexxEnums.ReorderPointSource?
    /// How much of it is already promised to orders.
    public let reserved: Double?
    /// How far below the point this row has fallen. The list is sorted by it, worst first.
    public let shortfall: Double?
    /// The article number this row tracks, null when it is tracked by product id.
    public let sku: String?
    /// The stock row that is low — the id to correct or receive against (POST /inventories/stock/{id}/adjust).
    public let stock_level_id: String?

    init(
        available: Double?,
        location_code: String?,
        location_enabled: Bool?,
        location_id: String?,
        on_hand: Double?,
        product_id: String?,
        reorder_point: Double?,
        reorder_point_source: RevenexxEnums.ReorderPointSource?,
        reserved: Double?,
        shortfall: Double?,
        sku: String?,
        stock_level_id: String?
    ) {
        self.available = available
        self.location_code = location_code
        self.location_enabled = location_enabled
        self.location_id = location_id
        self.on_hand = on_hand
        self.product_id = product_id
        self.reorder_point = reorder_point
        self.reorder_point_source = reorder_point_source
        self.reserved = reserved
        self.shortfall = shortfall
        self.sku = sku
        self.stock_level_id = stock_level_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.available = try container.decodeIfPresent(Double.self, forKey: .available)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
        self.location_enabled = try container.decodeIfPresent(Bool.self, forKey: .location_enabled)
        self.location_id = try container.decodeIfPresent(String.self, forKey: .location_id)
        self.on_hand = try container.decodeIfPresent(Double.self, forKey: .on_hand)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.reorder_point = try container.decodeIfPresent(Double.self, forKey: .reorder_point)
        if let reorder_point_sourceString = try container.decodeIfPresent(String.self, forKey: .reorder_point_source) {
            self.reorder_point_source = RevenexxEnums.ReorderPointSource(rawValue: reorder_point_sourceString)
        } else {
            self.reorder_point_source = nil
        }
        self.reserved = try container.decodeIfPresent(Double.self, forKey: .reserved)
        self.shortfall = try container.decodeIfPresent(Double.self, forKey: .shortfall)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.stock_level_id = try container.decodeIfPresent(String.self, forKey: .stock_level_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(available, forKey: .available)
        try container.encodeIfPresent(location_code, forKey: .location_code)
        try container.encodeIfPresent(location_enabled, forKey: .location_enabled)
        try container.encodeIfPresent(location_id, forKey: .location_id)
        try container.encodeIfPresent(on_hand, forKey: .on_hand)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(reorder_point, forKey: .reorder_point)
        try container.encodeIfPresent(reorder_point_source?.rawValue, forKey: .reorder_point_source)
        try container.encodeIfPresent(reserved, forKey: .reserved)
        try container.encodeIfPresent(shortfall, forKey: .shortfall)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(stock_level_id, forKey: .stock_level_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "available": available as Any,
            "location_code": location_code as Any,
            "location_enabled": location_enabled as Any,
            "location_id": location_id as Any,
            "on_hand": on_hand as Any,
            "product_id": product_id as Any,
            "reorder_point": reorder_point as Any,
            "reorder_point_source": reorder_point_source?.rawValue as Any,
            "reserved": reserved as Any,
            "shortfall": shortfall as Any,
            "sku": sku as Any,
            "stock_level_id": stock_level_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReorderAlert {
        return ReorderAlert(
            available: map["available"] as? Double,
            location_code: map["location_code"] as? String,
            location_enabled: map["location_enabled"] as? Bool,
            location_id: map["location_id"] as? String,
            on_hand: map["on_hand"] as? Double,
            product_id: map["product_id"] as? String,
            reorder_point: map["reorder_point"] as? Double,
            reorder_point_source: map["reorder_point_source"] as? String != nil ? ReorderPointSource(rawValue: map["reorder_point_source"] as! String) : nil,
            reserved: map["reserved"] as? Double,
            shortfall: map["shortfall"] as? Double,
            sku: map["sku"] as? String,
            stock_level_id: map["stock_level_id"] as? String
        )
    }
}
