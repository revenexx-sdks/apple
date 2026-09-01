import Foundation
import JSONCodable

/// The owning market comes from the route path ('market_id').
open class MarketLocaleCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case country = "country"
        case is_default = "is_default"
        case language = "language"
        case position = "position"
    }

    /// Locale code, language-COUNTRY — the language a storefront renders this market in, and the key a translation is stored under. Unique per market. The app's own seeded value is the tenant's `fallback_locale` setting, whose declared default is de-DE.
    public let code: String
    /// ISO 3166-1 alpha-2 country code — the region half of `code`. It is a spelling of the language, not a shipping destination: a market may register de-AT without trading in Austria.
    public let country: String
    /// The locale a storefront renders this market in when the request asks for none. At most one per market; where none carries the flag the first by position is used, and `default_locale.source` on the context says which of the two happened.
    public let is_default: Bool?
    /// ISO 639-1 language code — the language half of `code`, stored separately so a client can group markets by language without parsing.
    public let language: String
    /// Sort position among this market's locales, ascending, default 0 — and the tie-break that picks a default when no locale is flagged.
    public let position: Int?

    init(
        code: String,
        country: String,
        is_default: Bool?,
        language: String,
        position: Int?
    ) {
        self.code = code
        self.country = country
        self.is_default = is_default
        self.language = language
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.country = try container.decode(String.self, forKey: .country)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.language = try container.decode(String.self, forKey: .language)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encode(country, forKey: .country)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encode(language, forKey: .language)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "country": country as Any,
            "is_default": is_default as Any,
            "language": language as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketLocaleCreateRequest {
        return MarketLocaleCreateRequest(
            code: map["code"] as! String,
            country: map["country"] as! String,
            is_default: map["is_default"] as? Bool,
            language: map["language"] as! String,
            position: map["position"] as? Int
        )
    }
}
