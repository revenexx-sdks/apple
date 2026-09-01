import Foundation
import JSONCodable

/// One currency a market accepts, as opposed to the single base currency on the market row that its prices are quoted in. The base currency must be registered here or the market cannot serve.
open class MarketCurrency: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case is_default = "is_default"
        case market_id = "market_id"
        case position = "position"
    }

    /// ISO 4217 code, unique per market — one entry in the set of currencies this market TRADES in, as opposed to the single base currency on the market row that its prices are quoted in. The base currency must appear here or the market cannot serve; clone and backfill register it for you.
    public let code: String?
    /// When the currency was registered on this market. Set by the database; never writable.
    public let created_at: String?
    /// Primary key of this currency registration. The currency is named by `code` everywhere else.
    public let id: String?
    /// The currency offered first to a buyer who states no preference. At most one per market, and it should be the market's base currency — readiness reports it as a warning when it is not.
    public let is_default: Bool?
    /// The market this currency belongs to. Filled from the route path on write and never read out of the body; ON DELETE CASCADE, so deleting the market deletes this row.
    public let market_id: String?
    /// Sort position among this market's currencies, ascending, default 0 — the order a currency switcher lists them in.
    public let position: Int?

    init(
        code: String?,
        created_at: String?,
        id: String?,
        is_default: Bool?,
        market_id: String?,
        position: Int?
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.is_default = is_default
        self.market_id = market_id
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "market_id": market_id as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketCurrency {
        return MarketCurrency(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            market_id: map["market_id"] as? String,
            position: map["position"] as? Int
        )
    }
}
