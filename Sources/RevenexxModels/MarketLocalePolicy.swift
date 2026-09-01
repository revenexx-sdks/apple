import Foundation
import JSONCodable
import RevenexxEnums

/// How this tenant keys its translations, resolved rather than named: the key a client WRITES and the order it READS, per locale. Emitting the resolved answer is the point — a client handed only the setting names re-implements the policy and gets it subtly different, which is how a label editor came to ask for de-DE while the row held de.
open class MarketLocalePolicy: Codable {

    enum CodingKeys: String, CodingKey {
        case fallback = "fallback"
        case granularity = "granularity"
        case locales = "locales"
    }

    /// settings#locale_fallback — what a read tries after the exact key holds nothing.
    public let fallback: RevenexxEnums.MarketLocaleFallback?
    /// settings#locale_granularity — whether a value is keyed by the full locale ('regional') or by its language alone.
    public let granularity: RevenexxEnums.MarketLocaleGranularity?
    /// One entry per locale this market registers, in position order — the keys to use for that locale. A market with no locale of its own has an empty array here, not the fallback: the fallback answers `default_locale`, and there is nothing to key against.
    public let locales: [MarketLocaleKeys]?

    init(
        fallback: RevenexxEnums.MarketLocaleFallback?,
        granularity: RevenexxEnums.MarketLocaleGranularity?,
        locales: [MarketLocaleKeys]?
    ) {
        self.fallback = fallback
        self.granularity = granularity
        self.locales = locales
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let fallbackString = try container.decodeIfPresent(String.self, forKey: .fallback) {
            self.fallback = RevenexxEnums.MarketLocaleFallback(rawValue: fallbackString)
        } else {
            self.fallback = nil
        }
        if let granularityString = try container.decodeIfPresent(String.self, forKey: .granularity) {
            self.granularity = RevenexxEnums.MarketLocaleGranularity(rawValue: granularityString)
        } else {
            self.granularity = nil
        }
        self.locales = try container.decodeIfPresent([MarketLocaleKeys].self, forKey: .locales)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(fallback?.rawValue, forKey: .fallback)
        try container.encodeIfPresent(granularity?.rawValue, forKey: .granularity)
        try container.encodeIfPresent(locales, forKey: .locales)
    }

    public func toMap() -> [String: Any] {
        return [
            "fallback": fallback?.rawValue as Any,
            "granularity": granularity?.rawValue as Any,
            "locales": locales?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketLocalePolicy {
        return MarketLocalePolicy(
            fallback: map["fallback"] as? String != nil ? MarketLocaleFallback(rawValue: map["fallback"] as! String) : nil,
            granularity: map["granularity"] as? String != nil ? MarketLocaleGranularity(rawValue: map["granularity"] as! String) : nil,
            locales: (map["locales"] as? [[String: Any]] ?? []).map { MarketLocaleKeys.from(map: $0) }
        )
    }
}
