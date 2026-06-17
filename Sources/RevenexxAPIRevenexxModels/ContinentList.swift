import Foundation
import JSONCodable

/// Continents List
open class ContinentList: Codable {

    enum CodingKeys: String, CodingKey {
        case continents = "continents"
        case total = "total"
    }

    /// List of continents.
    public let continents: [Continent]
    /// Total number of continents that matched your query.
    public let total: Int

    init(
        continents: [Continent],
        total: Int
    ) {
        self.continents = continents
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.continents = try container.decode([Continent].self, forKey: .continents)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(continents, forKey: .continents)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "continents": continents.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ContinentList {
        return ContinentList(
            continents: (map["continents"] as! [[String: Any]]).map { Continent.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
