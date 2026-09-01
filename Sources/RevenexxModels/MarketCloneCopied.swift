import Foundation
import JSONCodable

/// Child rows copied from the source, per collection. A flag left false is a zero here, and so is a source that had none of that kind.
open class MarketCloneCopied: Codable {

    enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
        case locales = "locales"
        case tax_classes = "tax_classes"
    }

    /// Traded currencies copied from the source market.
    public let currencies: Int?
    /// Locales copied from the source market.
    public let locales: Int?
    /// Tax classes copied from the source market.
    public let tax_classes: Int?

    init(
        currencies: Int?,
        locales: Int?,
        tax_classes: Int?
    ) {
        self.currencies = currencies
        self.locales = locales
        self.tax_classes = tax_classes
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currencies = try container.decodeIfPresent(Int.self, forKey: .currencies)
        self.locales = try container.decodeIfPresent(Int.self, forKey: .locales)
        self.tax_classes = try container.decodeIfPresent(Int.self, forKey: .tax_classes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currencies, forKey: .currencies)
        try container.encodeIfPresent(locales, forKey: .locales)
        try container.encodeIfPresent(tax_classes, forKey: .tax_classes)
    }

    public func toMap() -> [String: Any] {
        return [
            "currencies": currencies as Any,
            "locales": locales as Any,
            "tax_classes": tax_classes as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketCloneCopied {
        return MarketCloneCopied(
            currencies: map["currencies"] as? Int,
            locales: map["locales"] as? Int,
            tax_classes: map["tax_classes"] as? Int
        )
    }
}
