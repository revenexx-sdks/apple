import Foundation
import JSONCodable
import RevenexxEnums

/// The locale a storefront should render this market in. `source` names where it came from: 'market' (a locale flagged is_default), 'market_first' (no flag — first by position) or 'tenant_fallback' (the market registers none; the tenant's fallback_locale setting answered).
open class MarketDefaultLocale: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case country = "country"
        case language = "language"
        case source = "source"
    }

    /// Locale code, language-COUNTRY — the language a storefront renders this market in, and the key a translation is stored under. Unique per market. The app's own seeded value is the tenant's `fallback_locale` setting, whose declared default is de-DE.
    public let code: String?
    /// ISO 3166-1 alpha-2 country code — the region half of `code`. It is a spelling of the language, not a shipping destination: a market may register de-AT without trading in Austria.
    public let country: String?
    /// ISO 639-1 language code — the language half of `code`, stored separately so a client can group markets by language without parsing.
    public let language: String?
    /// Which of the three rules answered. 'market' — a locale of this market carries is_default. 'market_first' — none does, so the first by position was taken. 'tenant_fallback' — the market registers no locale at all and the tenant's fallback_locale setting answered, which means this locale is NOT one of the market's own and nothing here was configured for it.
    public let source: RevenexxEnums.MarketDefaultLocaleSource?

    init(
        code: String?,
        country: String?,
        language: String?,
        source: RevenexxEnums.MarketDefaultLocaleSource?
    ) {
        self.code = code
        self.country = country
        self.language = language
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.MarketDefaultLocaleSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "country": country as Any,
            "language": language as Any,
            "source": source?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketDefaultLocale {
        return MarketDefaultLocale(
            code: map["code"] as? String,
            country: map["country"] as? String,
            language: map["language"] as? String,
            source: map["source"] as? String != nil ? MarketDefaultLocaleSource(rawValue: map["source"] as! String) : nil
        )
    }
}
