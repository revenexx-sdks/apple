import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class MarketCurrencyUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case is_default = "is_default"
        case position = "position"
    }

    /// ISO 4217 code, unique per market — one entry in the set of currencies this market TRADES in, as opposed to the single base currency on the market row that its prices are quoted in. The base currency must appear here or the market cannot serve; clone and backfill register it for you.
    public let code: String?
    /// The currency offered first to a buyer who states no preference. At most one per market, and it should be the market's base currency — readiness reports it as a warning when it is not.
    public let is_default: Bool?
    /// Sort position among this market's currencies, ascending, default 0 — the order a currency switcher lists them in.
    public let position: Int?

    init(
        code: String?,
        is_default: Bool?,
        position: Int?
    ) {
        self.code = code
        self.is_default = is_default
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "is_default": is_default as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketCurrencyUpdateRequest {
        return MarketCurrencyUpdateRequest(
            code: map["code"] as? String,
            is_default: map["is_default"] as? Bool,
            position: map["position"] as? Int
        )
    }
}
