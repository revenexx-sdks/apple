import Foundation
import JSONCodable

/// The whole of one market: the row, its three collections, and the four resolved answers a client would otherwise have to work out for itself.
open class MarketContext: Codable {

    enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
        case default_locale = "default_locale"
        case locale_policy = "locale_policy"
        case locales = "locales"
        case market = "market"
        case pricing = "pricing"
        case readiness = "readiness"
        case tax_classes = "tax_classes"
    }

    /// Every currency this market trades in, in position order. Capped at 200. The market's own base currency should be among them; readiness reports it as blocking when it is not.
    public let currencies: [MarketCurrency]?
    /// The locale a storefront should render this market in. `source` names where it came from: 'market' (a locale flagged is_default), 'market_first' (no flag — first by position) or 'tenant_fallback' (the market registers none; the tenant's fallback_locale setting answered).
    public let default_locale: MarketDefaultLocale?
    /// How this tenant keys its translations, resolved rather than named: the key a client WRITES and the order it READS, per locale. Emitting the resolved answer is the point — a client handed only the setting names re-implements the policy and gets it subtly different, which is how a label editor came to ask for de-DE while the row held de.
    public let locale_policy: MarketLocalePolicy?
    /// Every locale this market registers, in position order. Capped at 200. Empty is a real answer — read `default_locale` before assuming a language.
    public let locales: [MarketLocale]?
    /// A distinct business context within a tenant — a country, a region, or a storefront segment such as B2C vs B2B — with its own base currency, locales, traded currencies and tax classes. A market is also the platform's `market` SCOPE dimension: every other commerce app slices its data by one, keyed on this row's `code`. A market is never just this row: it needs at least one locale, one currency and one tax class before it can serve, which is what /readiness measures and what /clone and /backfill build.
    public let market: Market?
    /// Whether a stored price in this market is NET or GROSS — the market layer of an answer the prices app also holds. A price list's own tax_basis wins over this; `tax_basis: null` with `source: 'unset'` means this market declares nothing and the reader must fall through to the tenant's own default.
    public let pricing: MarketPricing?
    /// Can this market actually trade? `ready` is false only when a BLOCKING check failed — no currency to quote in, no tax class to tax with. Warnings are degraded-but-serviceable.
    public let readiness: MarketReadiness?
    /// Every tax class of this market with its rate, in position order. Capped at 200. This is the rate table other apps resolve a line against, by code.
    public let tax_classes: [MarketTaxClass]?

    init(
        currencies: [MarketCurrency]?,
        default_locale: MarketDefaultLocale?,
        locale_policy: MarketLocalePolicy?,
        locales: [MarketLocale]?,
        market: Market?,
        pricing: MarketPricing?,
        readiness: MarketReadiness?,
        tax_classes: [MarketTaxClass]?
    ) {
        self.currencies = currencies
        self.default_locale = default_locale
        self.locale_policy = locale_policy
        self.locales = locales
        self.market = market
        self.pricing = pricing
        self.readiness = readiness
        self.tax_classes = tax_classes
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currencies = try container.decodeIfPresent([MarketCurrency].self, forKey: .currencies)
        self.default_locale = try container.decodeIfPresent(MarketDefaultLocale.self, forKey: .default_locale)
        self.locale_policy = try container.decodeIfPresent(MarketLocalePolicy.self, forKey: .locale_policy)
        self.locales = try container.decodeIfPresent([MarketLocale].self, forKey: .locales)
        self.market = try container.decodeIfPresent(Market.self, forKey: .market)
        self.pricing = try container.decodeIfPresent(MarketPricing.self, forKey: .pricing)
        self.readiness = try container.decodeIfPresent(MarketReadiness.self, forKey: .readiness)
        self.tax_classes = try container.decodeIfPresent([MarketTaxClass].self, forKey: .tax_classes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currencies, forKey: .currencies)
        try container.encodeIfPresent(default_locale, forKey: .default_locale)
        try container.encodeIfPresent(locale_policy, forKey: .locale_policy)
        try container.encodeIfPresent(locales, forKey: .locales)
        try container.encodeIfPresent(market, forKey: .market)
        try container.encodeIfPresent(pricing, forKey: .pricing)
        try container.encodeIfPresent(readiness, forKey: .readiness)
        try container.encodeIfPresent(tax_classes, forKey: .tax_classes)
    }

    public func toMap() -> [String: Any] {
        return [
            "currencies": currencies?.map { $0.toMap() } as Any,
            "default_locale": default_locale?.toMap() as Any,
            "locale_policy": locale_policy?.toMap() as Any,
            "locales": locales?.map { $0.toMap() } as Any,
            "market": market?.toMap() as Any,
            "pricing": pricing?.toMap() as Any,
            "readiness": readiness?.toMap() as Any,
            "tax_classes": tax_classes?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketContext {
        return MarketContext(
            currencies: (map["currencies"] as? [[String: Any]] ?? []).map { MarketCurrency.from(map: $0) },
            default_locale: MarketDefaultLocale.from(map: map["default_locale"] as! [String: Any]),
            locale_policy: MarketLocalePolicy.from(map: map["locale_policy"] as! [String: Any]),
            locales: (map["locales"] as? [[String: Any]] ?? []).map { MarketLocale.from(map: $0) },
            market: Market.from(map: map["market"] as! [String: Any]),
            pricing: MarketPricing.from(map: map["pricing"] as! [String: Any]),
            readiness: MarketReadiness.from(map: map["readiness"] as! [String: Any]),
            tax_classes: (map["tax_classes"] as? [[String: Any]] ?? []).map { MarketTaxClass.from(map: $0) }
        )
    }
}
