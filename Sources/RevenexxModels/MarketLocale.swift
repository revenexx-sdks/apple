import Foundation
import JSONCodable

/// One language a market is rendered in, and one key its translations are stored under. A market may register several; one of them is the default a storefront falls back to.
open class MarketLocale: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case country = "country"
        case created_at = "created_at"
        case id = "id"
        case is_default = "is_default"
        case language = "language"
        case market_id = "market_id"
        case position = "position"
    }

    /// Locale code, language-COUNTRY — the language a storefront renders this market in, and the key a translation is stored under. Unique per market. The app's own seeded value is the tenant's `fallback_locale` setting, whose declared default is de-DE.
    public let code: String?
    /// ISO 3166-1 alpha-2 country code — the region half of `code`. It is a spelling of the language, not a shipping destination: a market may register de-AT without trading in Austria.
    public let country: String?
    /// When the locale was registered on this market. Set by the database; never writable.
    public let created_at: String?
    /// Primary key of this locale registration. The locale is named by `code` everywhere else.
    public let id: String?
    /// The locale a storefront renders this market in when the request asks for none. At most one per market; where none carries the flag the first by position is used, and `default_locale.source` on the context says which of the two happened.
    public let is_default: Bool?
    /// ISO 639-1 language code — the language half of `code`, stored separately so a client can group markets by language without parsing.
    public let language: String?
    /// The market this locale belongs to. Filled from the route path on write and never read out of the body; ON DELETE CASCADE, so deleting the market deletes this row.
    public let market_id: String?
    /// Sort position among this market's locales, ascending, default 0 — and the tie-break that picks a default when no locale is flagged.
    public let position: Int?

    init(
        code: String?,
        country: String?,
        created_at: String?,
        id: String?,
        is_default: Bool?,
        language: String?,
        market_id: String?,
        position: Int?
    ) {
        self.code = code
        self.country = country
        self.created_at = created_at
        self.id = id
        self.is_default = is_default
        self.language = language
        self.market_id = market_id
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "country": country as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "language": language as Any,
            "market_id": market_id as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketLocale {
        return MarketLocale(
            code: map["code"] as? String,
            country: map["country"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            language: map["language"] as? String,
            market_id: map["market_id"] as? String,
            position: map["position"] as? Int
        )
    }
}
