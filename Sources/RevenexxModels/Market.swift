import Foundation
import JSONCodable
import RevenexxEnums

/// A distinct business context within a tenant — a country, a region, or a storefront segment such as B2C vs B2B — with its own base currency, locales, traded currencies and tax classes. A market is also the platform's `market` SCOPE dimension: every other commerce app slices its data by one, keyed on this row's `code`. A market is never just this row: it needs at least one locale, one currency and one tax class before it can serve, which is what /readiness measures and what /clone and /backfill build.
open class Market: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case currency = "currency"
        case id = "id"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case status = "status"
        case updated_at = "updated_at"
    }

    /// Market code, unique per tenant, and the single most load-bearing string in this app: it IS the market scope slug. The Entity Scoping Engine publishes it as the `market` dimension (`scope_context.market` in the JWT), and every other commerce app — products, prices, orders, customers — stores THIS value to say which market a row belongs to. Renaming it re-keys that scope for everyone, so treat it as permanent. Accepted in place of the uuid on /readiness, /clone, /backfill and /make-default — but not on the item routes or /context, which take a uuid only.
    public let code: String?
    /// When the market row was inserted. Set by the database; never writable.
    public let created_at: String?
    /// Base currency this market quotes in — ISO 4217, and schema.json's own default is 'EUR'. This is the single currency prices are STATED in; the currencies collection under the market is the wider set it accepts. A base currency missing from that collection is a blocking readiness failure.
    public let currency: String?
    /// Primary key. Note that OTHER apps do not store this: the market scope dimension is keyed on `code` (manifest `provides_scopes.slug_source = markets.code`), so a row elsewhere that is "in this market" carries the code, not this uuid. It is the item routes and /context that want this value.
    public let id: String?
    /// The tenant default market — what a call naming no market falls back to. Exactly one market holds it; move it with POST /markets/{id}/make-default rather than by writing this flag, which does not demote the market that currently holds it.
    public let is_default: Bool?
    /// Localized display names for storefronts, keyed by locale: a flat {locale: label} map, one level deep, string values. WHICH key to write is not free — GET /markets/{id}/context returns `locale_policy`, whose `write` is the key this tenant keys by (a full locale under regional granularity, a bare language under language granularity) and whose `read` is the order to try. Null means nothing is translated and `name` is all there is.
    public let labels: [String: AnyCodable]?
    /// Display name, in the operator's own language. Cockpit copy only — nothing resolves a market by it.
    public let name: String?
    /// Sort position among the tenant's markets, ascending, default 0. Presentation only — it decides the order the Cockpit and a market picker list them in, and nothing resolves a market by it.
    public let position: Int?
    /// Default 'active'. Only an active market serves a storefront; 'inactive' keeps the market and all its configuration but takes it out of service. Readiness reports an active market that cannot trade as `serving: true, ready: false` — live and broken.
    public let status: RevenexxEnums.MarketStatus?
    /// When the market row was last written. Set by the database on every update; never writable.
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        currency: String?,
        id: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        status: RevenexxEnums.MarketStatus?,
        updated_at: String?
    ) {
        self.code = code
        self.created_at = created_at
        self.currency = currency
        self.id = id
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.status = status
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.MarketStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "status": status?.rawValue as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Market {
        return Market(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            status: map["status"] as? String != nil ? MarketStatus(rawValue: map["status"] as! String) : nil,
            updated_at: map["updated_at"] as? String
        )
    }
}
