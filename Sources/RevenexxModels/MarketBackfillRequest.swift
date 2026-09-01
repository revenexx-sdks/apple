import Foundation
import JSONCodable

/// The path id is the market being REPAIRED; `source` is the market to copy from (a uuid or a market code). The three flags default to true.
open class MarketBackfillRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
        case locales = "locales"
        case source = "source"
        case tax_classes = "tax_classes"
    }

    /// Take the source's traded currencies for codes this market does not already carry. Default true.
    public let currencies: Bool?
    /// Take the source's locales for codes this market does not already carry. Default true.
    public let locales: Bool?
    /// The market to copy the missing pieces FROM — a uuid or a market code. Must not be the market in the path. Pick a market that is already right; nothing about it is changed.
    public let source: String
    /// Take the source's tax classes for codes this market does not already carry. An existing code keeps ITS rate — a backfill never re-rates a class the merchant already set. Default true.
    public let tax_classes: Bool?

    init(
        currencies: Bool?,
        locales: Bool?,
        source: String,
        tax_classes: Bool?
    ) {
        self.currencies = currencies
        self.locales = locales
        self.source = source
        self.tax_classes = tax_classes
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currencies = try container.decodeIfPresent(Bool.self, forKey: .currencies)
        self.locales = try container.decodeIfPresent(Bool.self, forKey: .locales)
        self.source = try container.decode(String.self, forKey: .source)
        self.tax_classes = try container.decodeIfPresent(Bool.self, forKey: .tax_classes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currencies, forKey: .currencies)
        try container.encodeIfPresent(locales, forKey: .locales)
        try container.encode(source, forKey: .source)
        try container.encodeIfPresent(tax_classes, forKey: .tax_classes)
    }

    public func toMap() -> [String: Any] {
        return [
            "currencies": currencies as Any,
            "locales": locales as Any,
            "source": source as Any,
            "tax_classes": tax_classes as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketBackfillRequest {
        return MarketBackfillRequest(
            currencies: map["currencies"] as? Bool,
            locales: map["locales"] as? Bool,
            source: map["source"] as! String,
            tax_classes: map["tax_classes"] as? Bool
        )
    }
}
