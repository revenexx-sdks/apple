import Foundation
import JSONCodable

/// Team
open class Team<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case name = "name"
        case prefs = "prefs"
        case total = "total"
    }

    /// Team creation date in ISO 8601 format.
    public let createdAt: String
    /// Team ID.
    public let id: String
    /// Team update date in ISO 8601 format.
    public let updatedAt: String
    /// Team name.
    public let name: String
    /// Team preferences as a key-value object
    public let prefs: Preferences<T>
    /// Total number of team members.
    public let total: Int

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        name: String,
        prefs: Preferences<T>,
        total: Int
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.name = name
        self.prefs = prefs
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.name = try container.decode(String.self, forKey: .name)
        self.prefs = try container.decode(Preferences<T>.self, forKey: .prefs)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(name, forKey: .name)
        try container.encode(prefs, forKey: .prefs)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "name": name as Any,
            "prefs": prefs.toMap() as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Team {
        return Team(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            name: map["name"] as! String,
            prefs: Preferences.from(map: map["prefs"] as! [String: Any]),
            total: map["total"] as! Int
        )
    }
}
