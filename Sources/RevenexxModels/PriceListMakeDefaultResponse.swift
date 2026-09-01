import Foundation
import JSONCodable

/// The list as it now stands, plus whoever lost the flag.
open class PriceListMakeDefaultResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case demoted = "demoted"
        case price_list = "price_list"
    }

    /// Codes of the lists that lost the flag — empty when this list already held it, which is what makes a repeated call free.
    public let demoted: [String]?
    /// A price list: one currency, one tax basis, one validity window, one buyer scope — and the entries that price items in it. Which list wins for a given buyer is decided by scope first, then priority, then the default flag; see prices.resolve.
    public let price_list: PriceList?

    init(
        demoted: [String]?,
        price_list: PriceList?
    ) {
        self.demoted = demoted
        self.price_list = price_list
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.demoted = try container.decodeIfPresent([String].self, forKey: .demoted)
        self.price_list = try container.decodeIfPresent(PriceList.self, forKey: .price_list)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(demoted, forKey: .demoted)
        try container.encodeIfPresent(price_list, forKey: .price_list)
    }

    public func toMap() -> [String: Any] {
        return [
            "demoted": demoted as Any,
            "price_list": price_list?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceListMakeDefaultResponse {
        return PriceListMakeDefaultResponse(
            demoted: map["demoted"] as? [String],
            price_list: PriceList.from(map: map["price_list"] as! [String: Any])
        )
    }
}
