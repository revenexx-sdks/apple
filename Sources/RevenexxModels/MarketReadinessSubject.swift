import Foundation
import JSONCodable
import RevenexxEnums

/// The market the verdict is about, identified rather than returned in full — the five columns a reader needs to know which market answered. Read GET /markets/{id} for the rest.
open class MarketReadinessSubject: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case currency = "currency"
        case id = "id"
        case name = "name"
        case status = "status"
    }

    /// Market code, unique per tenant, and the single most load-bearing string in this app: it IS the market scope slug. The Entity Scoping Engine publishes it as the `market` dimension (`scope_context.market` in the JWT), and every other commerce app — products, prices, orders, customers — stores THIS value to say which market a row belongs to. Renaming it re-keys that scope for everyone, so treat it as permanent. Accepted in place of the uuid on /readiness, /clone, /backfill and /make-default — but not on the item routes or /context, which take a uuid only.
    public let code: String?
    /// Base currency this market quotes in — ISO 4217, and schema.json's own default is 'EUR'. This is the single currency prices are STATED in; the currencies collection under the market is the wider set it accepts. A base currency missing from that collection is a blocking readiness failure.
    public let currency: String?
    /// The market's primary key — resolved, so a call that named the market by its code gets the uuid back.
    public let id: String?
    /// Display name, in the operator's own language. Cockpit copy only — nothing resolves a market by it.
    public let name: String?
    /// Default 'active'. Only an active market serves a storefront; 'inactive' keeps the market and all its configuration but takes it out of service. Readiness reports an active market that cannot trade as `serving: true, ready: false` — live and broken.
    public let status: RevenexxEnums.MarketStatus?

    init(
        code: String?,
        currency: String?,
        id: String?,
        name: String?,
        status: RevenexxEnums.MarketStatus?
    ) {
        self.code = code
        self.currency = currency
        self.id = id
        self.name = name
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.MarketStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "currency": currency as Any,
            "id": id as Any,
            "name": name as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketReadinessSubject {
        return MarketReadinessSubject(
            code: map["code"] as? String,
            currency: map["currency"] as? String,
            id: map["id"] as? String,
            name: map["name"] as? String,
            status: map["status"] as? String != nil ? MarketStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
