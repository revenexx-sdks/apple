import Foundation
import JSONCodable

/// A stock row tracks an item: 'product_id' or 'sku'.
open class StockLevelCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case location_id = "location_id"
        case metadata = "metadata"
        case product_id = "product_id"
        case reorder_point = "reorder_point"
        case sku = "sku"
    }

    /// The location this balance is held at — a `locations` row of this tenant (GET /inventories/locations). There is ONE stock row per (location, item): the same SKU in three warehouses is three rows, and what a storefront shows is their sum (POST /inventories/availability). Deleting the location deletes its stock rows with it. It has to exist already (GET /inventories/locations); an id no location carries is answered 400 by the foreign key, not 404.
    public let location_id: String
    /// Free-form data the tenant keeps on this stock row, and ONE key this app reads: `backorder`. A literal boolean `true` there opts this item into backorders while `backorder_policy` is 'allow_per_sku' — anything else, including the string "true", does not, and the reservation is refused with 422. That is how a merchant backorders the supplier-stocked half of a catalogue without promising the rest.
    public let metadata: [String: AnyCodable]?
    /// The product this row tracks, as the products app knows it. A row tracks a `product_id` or a `sku` — the database insists on at least one (CHECK `product_id is not null or sku is not null`) — and matching is exact: a row keyed by SKU is not found by product id.
    public let product_id: String?
    /// The available quantity at or below which this row belongs on the replenishment worklist (GET /inventories/reorder-alerts). Null falls back to the `reorder_point_default` setting, so replenishment works without a threshold per SKU; 0 never alerts, which is how one row opts out.
    public let reorder_point: Double?
    /// The article number this row tracks when there is no product id, which is the normal case for an ERP-stocked catalogue. Exact match, and the identity every stock call may use instead of a uuid.
    public let sku: String?

    init(
        location_id: String,
        metadata: [String: AnyCodable]?,
        product_id: String?,
        reorder_point: Double?,
        sku: String?
    ) {
        self.location_id = location_id
        self.metadata = metadata
        self.product_id = product_id
        self.reorder_point = reorder_point
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.location_id = try container.decode(String.self, forKey: .location_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.reorder_point = try container.decodeIfPresent(Double.self, forKey: .reorder_point)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(location_id, forKey: .location_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(reorder_point, forKey: .reorder_point)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "location_id": location_id as Any,
            "metadata": metadata as Any,
            "product_id": product_id as Any,
            "reorder_point": reorder_point as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> StockLevelCreateRequest {
        return StockLevelCreateRequest(
            location_id: map["location_id"] as! String,
            metadata: map["metadata"] as? [String: AnyCodable],
            product_id: map["product_id"] as? String,
            reorder_point: map["reorder_point"] as? Double,
            sku: map["sku"] as? String
        )
    }
}
