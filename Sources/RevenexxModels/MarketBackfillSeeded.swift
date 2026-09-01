import Foundation
import JSONCodable

/// Rows this call added that were copied from nowhere, because the new market would otherwise have been left unable to trade: the tenant `fallback_locale` when neither market had a locale, and the base currency when it is not in the copied set. Zero on both is the normal, healthy answer — it means nothing had to be invented.
open class MarketBackfillSeeded: Codable {

    enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
        case locales = "locales"
    }

    /// 1 when the market's own base currency was registered because the copied set did not contain it; 0 otherwise.
    public let currencies: Int?
    /// 1 when the tenant's fallback_locale was written as this market's only locale, marked default; 0 otherwise.
    public let locales: Int?

    init(
        currencies: Int?,
        locales: Int?
    ) {
        self.currencies = currencies
        self.locales = locales
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currencies = try container.decodeIfPresent(Int.self, forKey: .currencies)
        self.locales = try container.decodeIfPresent(Int.self, forKey: .locales)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currencies, forKey: .currencies)
        try container.encodeIfPresent(locales, forKey: .locales)
    }

    public func toMap() -> [String: Any] {
        return [
            "currencies": currencies as Any,
            "locales": locales as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketBackfillSeeded {
        return MarketBackfillSeeded(
            currencies: map["currencies"] as? Int,
            locales: map["locales"] as? Int
        )
    }
}
