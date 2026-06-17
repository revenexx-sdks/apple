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

    /// Point in time for validity windows (ISO 8601 timestamp, default now).
    public let at: String?
    /// Buyer context: channel.
    public let channel_id: String?
    /// Buyer context: contact — most specific scope.
    public let contact_id: String?
    /// ISO 4217 code (default EUR) — only lists in this currency resolve.
    public let currency: String?
    /// Items to price (at most 200 per call).
    public let items: [PriceResolveItem]
    /// Buyer context: market.
    public let market_id: String?
    /// Buyer context: organization.
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
