import Foundation
import JSONCodable

/// One page of currencies of a market, the page it sits on, and the filters that produced it.
open class MarketCurrencyList: Codable {

    enum CodingKeys: String, CodingKey {
        case filter = "filter"
        case items = "items"
        case page = "page"
    }

    /// The exact-column filters this call applied, echoed back. Every value is the raw query string, never the column's own type: `?is_default=true` comes back as `"true"`. A `?column=value` naming a column this entity does not have is DROPPED rather than refused — the call answers 200 with the unfiltered list, and the key missing from here is the only way to find out.
    public let filter: MarketCurrencyFilter?
    /// The currencies of a market on this page, in `order` — by `position` ascending unless the call asked otherwise.
    public let items: [MarketCurrency]?
    /// Where in the result set this answer sits. `limit` and `offset` are the values that were APPLIED, not the ones that were asked for — the data plane clamps rather than refuses, so an out-of-range or unparseable value comes back corrected here instead of as a 400.
    public let page: MarketsPage?

    init(
        filter: MarketCurrencyFilter?,
        items: [MarketCurrency]?,
        page: MarketsPage?
    ) {
        self.filter = filter
        self.items = items
        self.page = page
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.filter = try container.decodeIfPresent(MarketCurrencyFilter.self, forKey: .filter)
        self.items = try container.decodeIfPresent([MarketCurrency].self, forKey: .items)
        self.page = try container.decodeIfPresent(MarketsPage.self, forKey: .page)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(filter, forKey: .filter)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(page, forKey: .page)
    }

    public func toMap() -> [String: Any] {
        return [
            "filter": filter?.toMap() as Any,
            "items": items?.map { $0.toMap() } as Any,
            "page": page?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketCurrencyList {
        return MarketCurrencyList(
            filter: MarketCurrencyFilter.from(map: map["filter"] as! [String: Any]),
            items: (map["items"] as? [[String: Any]] ?? []).map { MarketCurrency.from(map: $0) },
            page: MarketsPage.from(map: map["page"] as! [String: Any])
        )
    }
}
