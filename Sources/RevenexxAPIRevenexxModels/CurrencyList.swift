import Foundation
import JSONCodable

/// Currencies List
open class CurrencyList: Codable {

    enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
        case total = "total"
    }

    /// List of currencies.
    public let currencies: [Currency]
    /// Total number of currencies that matched your query.
    public let total: Int

    init(
        currencies: [Currency],
        total: Int
    ) {
        self.currencies = currencies
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currencies = try container.decode([Currency].self, forKey: .currencies)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(currencies, forKey: .currencies)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "currencies": currencies.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CurrencyList {
        return CurrencyList(
            currencies: (map["currencies"] as! [[String: Any]]).map { Currency.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
