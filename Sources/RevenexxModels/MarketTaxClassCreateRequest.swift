import Foundation
import JSONCodable

/// The owning market comes from the route path ('market_id').
open class MarketTaxClassCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case rate = "rate"
    }

    /// Tax class code, unique per market — the rate bucket a product or a shipping method is assigned to ('standard', 'reduced', 'zero'). Other apps name a class by THIS and by nothing else: there is no foreign key behind it and there cannot be (ADR-0055), which is why the delete route asks the shipping app what still points at the code before removing it.
    public let code: String
    /// The class applied to a line that names none. At most one per market. A market that stores GROSS prices and marks no default cannot break those prices back down into net, which is why readiness turns that combination from a warning into a blocking failure.
    public let is_default: Bool?
    /// Localized display names for storefronts and invoices, keyed by locale: a flat {locale: label} map, one level deep, string values. The key to write is the `locale_policy.write` from GET /markets/{id}/context, exactly as for a market's labels. Null means nothing is translated and `name` is all there is.
    public let labels: [String: AnyCodable]?
    /// Display name of the rate bucket, in the operator's own language.
    public let name: String
    /// Sort position among this market's tax classes, ascending, default 0 — and the tie-break that picks a class when none is flagged default.
    public let position: Int?
    /// Tax rate in PERCENT, 0–100 (default 0) — 20 means 20 %, not 0.2. Whether a stored price already contains it is a separate question, answered per market by `pricing.tax_basis` on the context.
    public let rate: Double?

    init(
        code: String,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        name: String,
        position: Int?,
        rate: Double?
    ) {
        self.code = code
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.rate = rate
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decode(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(rate, forKey: .rate)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "rate": rate as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketTaxClassCreateRequest {
        return MarketTaxClassCreateRequest(
            code: map["code"] as! String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as! String,
            position: map["position"] as? Int,
            rate: map["rate"] as? Double
        )
    }
}
