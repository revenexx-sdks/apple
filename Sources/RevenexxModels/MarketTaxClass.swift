import Foundation
import JSONCodable

/// One rate bucket within a market — 'standard', 'reduced', 'zero' — and the source of record for that rate across the platform. Other apps point at it by CODE, with no foreign key behind it.
open class MarketTaxClass: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case is_default = "is_default"
        case labels = "labels"
        case market_id = "market_id"
        case name = "name"
        case position = "position"
        case rate = "rate"
        case updated_at = "updated_at"
    }

    /// Tax class code, unique per market — the rate bucket a product or a shipping method is assigned to ('standard', 'reduced', 'zero'). Other apps name a class by THIS and by nothing else: there is no foreign key behind it and there cannot be (ADR-0055), which is why the delete route asks the shipping app what still points at the code before removing it.
    public let code: String?
    /// When the tax class was created on this market. Set by the database; never writable.
    public let created_at: String?
    /// Primary key of this tax class. The class is named by `code` everywhere else, including by other apps.
    public let id: String?
    /// The class applied to a line that names none. At most one per market. A market that stores GROSS prices and marks no default cannot break those prices back down into net, which is why readiness turns that combination from a warning into a blocking failure.
    public let is_default: Bool?
    /// Localized display names for storefronts and invoices, keyed by locale: a flat {locale: label} map, one level deep, string values. The key to write is the `locale_policy.write` from GET /markets/{id}/context, exactly as for a market's labels. Null means nothing is translated and `name` is all there is.
    public let labels: [String: AnyCodable]?
    /// The market this tax class belongs to. Filled from the route path on write and never read out of the body; ON DELETE CASCADE, so deleting the market deletes this row.
    public let market_id: String?
    /// Display name of the rate bucket, in the operator's own language.
    public let name: String?
    /// Sort position among this market's tax classes, ascending, default 0 — and the tie-break that picks a class when none is flagged default.
    public let position: Int?
    /// Tax rate in PERCENT, 0–100 (default 0) — 20 means 20 %, not 0.2. Whether a stored price already contains it is a separate question, answered per market by `pricing.tax_basis` on the context.
    public let rate: Double?
    /// When the tax class was last written. Set by the database on every update; never writable.
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        id: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        market_id: String?,
        name: String?,
        position: Int?,
        rate: Double?,
        updated_at: String?
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.is_default = is_default
        self.labels = labels
        self.market_id = market_id
        self.name = name
        self.position = position
        self.rate = rate
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "market_id": market_id as Any,
            "name": name as Any,
            "position": position as Any,
            "rate": rate as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketTaxClass {
        return MarketTaxClass(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            market_id: map["market_id"] as? String,
            name: map["name"] as? String,
            position: map["position"] as? Int,
            rate: map["rate"] as? Double,
            updated_at: map["updated_at"] as? String
        )
    }
}
