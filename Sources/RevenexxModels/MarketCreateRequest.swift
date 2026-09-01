import Foundation
import JSONCodable
import RevenexxEnums

/// A market needs a 'code' and a 'name' — currency defaults to EUR, status to active. To get a market that can actually trade, clone an existing one instead: POST /markets/{id}/clone.
open class MarketCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case currency = "currency"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case status = "status"
    }

    /// Market code, unique per tenant, and the single most load-bearing string in this app: it IS the market scope slug. The Entity Scoping Engine publishes it as the `market` dimension (`scope_context.market` in the JWT), and every other commerce app — products, prices, orders, customers — stores THIS value to say which market a row belongs to. Renaming it re-keys that scope for everyone, so treat it as permanent. Accepted in place of the uuid on /readiness, /clone, /backfill and /make-default — but not on the item routes or /context, which take a uuid only.
    public let code: String
    /// Base currency this market quotes in — ISO 4217, and schema.json's own default is 'EUR'. This is the single currency prices are STATED in; the currencies collection under the market is the wider set it accepts. A base currency missing from that collection is a blocking readiness failure.
    public let currency: String?
    /// The tenant default market — what a call naming no market falls back to. Exactly one market holds it; move it with POST /markets/{id}/make-default rather than by writing this flag, which does not demote the market that currently holds it.
    public let is_default: Bool?
    /// Localized display names for storefronts, keyed by locale: a flat {locale: label} map, one level deep, string values. WHICH key to write is not free — GET /markets/{id}/context returns `locale_policy`, whose `write` is the key this tenant keys by (a full locale under regional granularity, a bare language under language granularity) and whose `read` is the order to try. Null means nothing is translated and `name` is all there is.
    public let labels: [String: AnyCodable]?
    /// Display name, in the operator's own language. Cockpit copy only — nothing resolves a market by it.
    public let name: String
    /// Sort position among the tenant's markets, ascending, default 0. Presentation only — it decides the order the Cockpit and a market picker list them in, and nothing resolves a market by it.
    public let position: Int?
    /// Default 'active'. Only an active market serves a storefront; 'inactive' keeps the market and all its configuration but takes it out of service. Readiness reports an active market that cannot trade as `serving: true, ready: false` — live and broken.
    public let status: RevenexxEnums.MarketStatus?

    init(
        code: String,
        currency: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        name: String,
        position: Int?,
        status: RevenexxEnums.MarketStatus?
    ) {
        self.code = code
        self.currency = currency
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decode(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.MarketStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "currency": currency as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketCreateRequest {
        return MarketCreateRequest(
            code: map["code"] as! String,
            currency: map["currency"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as! String,
            position: map["position"] as? Int,
            status: map["status"] as? String != nil ? MarketStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
