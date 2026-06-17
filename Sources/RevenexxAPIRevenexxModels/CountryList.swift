import Foundation
import JSONCodable

/// Countries List
open class CountryList: Codable {

    enum CodingKeys: String, CodingKey {
        case countries = "countries"
        case total = "total"
    }

    /// List of countries.
    public let countries: [Country]
    /// Total number of countries that matched your query.
    public let total: Int

    init(
        countries: [Country],
        total: Int
    ) {
        self.countries = countries
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.countries = try container.decode([Country].self, forKey: .countries)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(countries, forKey: .countries)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "countries": countries.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CountryList {
        return CountryList(
            countries: (map["countries"] as! [[String: Any]]).map { Country.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
