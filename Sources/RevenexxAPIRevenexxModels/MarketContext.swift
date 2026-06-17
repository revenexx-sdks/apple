import Foundation
import JSONCodable

/// 
open class MarketContext: Codable {

    enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
        case locales = "locales"
        case market = "market"
        case tax_classes = "tax_classes"
    }

    /// 
    public let currencies: [MarketCurrency]?
    /// 
    public let locales: [MarketLocale]?
    /// 
    public let market: Market?
    /// 
    public let tax_classes: [MarketTaxClass]?

    init(
        currencies: [MarketCurrency]?,
        locales: [MarketLocale]?,
        market: Market?,
        tax_classes: [MarketTaxClass]?
    ) {
        self.currencies = currencies
        self.locales = locales
        self.market = market
        self.tax_classes = tax_classes
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currencies = try container.decodeIfPresent([MarketCurrency].self, forKey: .currencies)
        self.locales = try container.decodeIfPresent([MarketLocale].self, forKey: .locales)
        self.market = try container.decodeIfPresent(Market.self, forKey: .market)
        self.tax_classes = try container.decodeIfPresent([MarketTaxClass].self, forKey: .tax_classes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currencies, forKey: .currencies)
        try container.encodeIfPresent(locales, forKey: .locales)
        try container.encodeIfPresent(market, forKey: .market)
        try container.encodeIfPresent(tax_classes, forKey: .tax_classes)
    }

    public func toMap() -> [String: Any] {
        return [
            "currencies": currencies.map { $0.toMap() } as Any,
            "locales": locales.map { $0.toMap() } as Any,
            "market": market.toMap() as Any,
            "tax_classes": tax_classes.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketContext {
        return MarketContext(
            currencies: (map["currencies"] as? [[String: Any]] ?? []).map { MarketCurrency.from(map: $0) },
            locales: (map["locales"] as? [[String: Any]] ?? []).map { MarketLocale.from(map: $0) },
            market: Market.from(map: map["market"] as! [String: Any]),
            tax_classes: (map["tax_classes"] as? [[String: Any]] ?? []).map { MarketTaxClass.from(map: $0) }
        )
    }
}
