import Foundation
import JSONCodable

/// Buyer context + items. Unpriceable items come back as on_request — a missing price is a first-class state, never 0.
open class PriceResolveRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case at = "at"
        case channel_id = "channel_id"
        case contact_id = "contact_id"
        case currency = "currency"
        case items = "items"
        case market_id = "market_id"
        case organization_id = "organization_id"
    }

    /// The instant every validity window — list and entry — is evaluated at (ISO 8601). Default now. This is how a promo price is previewed before it starts, and it is echoed as `basis.evaluated_at`.
    public let at: String?
    /// Buyer context: the sales channel. Third scope — beats the open lists, loses to contact and organization.
    public let channel_id: String?
    /// Buyer context: the contact this quote is for. The most specific scope — a list naming this contact beats every other list, whatever their priority. Sending it (or organization_id) is also what makes the buyer AUTHENTICATED for `requires_auth` lists and for the tenant’s anonymous_resolve_allowed setting.
    public let contact_id: String?
    /// ISO 4217 code the quote is wanted in. ONLY lists in this currency are candidates and nothing is ever converted, so a wrong value here is not a rounding difference — it is no price at all. Omit to take the buyer market’s currency, then the tenant’s default_currency; `basis.currency_source` names which applied.
    public let currency: String?
    /// Items to price, at most 200 per call — a whole cart or a whole product listing in one round trip. The answer holds one entry per item, in this order.
    public let items: [PriceResolveItem]
    /// Buyer context: the market, as a uuid pin for older callers. Prefer the `X-Revenexx-Market` header, which carries a market CODE and is what scopes the visible price lists. The market decides the tax rates AND which per-market settings (rounding, tie-break, anonymous access) apply — with several markets and no signal at all the answer says `tax.resolved: false`, `reason: market_required` rather than quoting another market’s VAT.
    public let market_id: String?
    /// Buyer context: the organization the buyer belongs to. Second most specific scope; also counts as authenticated.
    public let organization_id: String?

    init(
        at: String?,
        channel_id: String?,
        contact_id: String?,
        currency: String?,
        items: [PriceResolveItem],
        market_id: String?,
        organization_id: String?
    ) {
        self.at = at
        self.channel_id = channel_id
        self.contact_id = contact_id
        self.currency = currency
        self.items = items
        self.market_id = market_id
        self.organization_id = organization_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.at = try container.decodeIfPresent(String.self, forKey: .at)
        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.items = try container.decode([PriceResolveItem].self, forKey: .items)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(at, forKey: .at)
        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encode(items, forKey: .items)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "at": at as Any,
            "channel_id": channel_id as Any,
            "contact_id": contact_id as Any,
            "currency": currency as Any,
            "items": items.map { $0.toMap() } as Any,
            "market_id": market_id as Any,
            "organization_id": organization_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceResolveRequest {
        return PriceResolveRequest(
            at: map["at"] as? String,
            channel_id: map["channel_id"] as? String,
            contact_id: map["contact_id"] as? String,
            currency: map["currency"] as? String,
            items: (map["items"] as! [[String: Any]]).map { PriceResolveItem.from(map: $0) },
            market_id: map["market_id"] as? String,
            organization_id: map["organization_id"] as? String
        )
    }
}
