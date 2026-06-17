import Foundation
import JSONCodable

/// Teams List
open class TeamList<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case teams = "teams"
        case total = "total"
    }

    /// List of teams.
    public let teams: [Team<T>]
    /// Total number of teams that matched your query.
    public let total: Int

    init(
        teams: [Team<T>],
        total: Int
    ) {
        self.teams = teams
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.teams = try container.decode([Team<T>].self, forKey: .teams)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(teams, forKey: .teams)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "teams": teams.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TeamList {
        return TeamList(
            teams: (map["teams"] as! [[String: Any]]).map { Team.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
