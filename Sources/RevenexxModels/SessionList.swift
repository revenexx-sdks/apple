import Foundation
import JSONCodable

/// Sessions List
open class SessionList: Codable {

    enum CodingKeys: String, CodingKey {
        case sessions = "sessions"
        case total = "total"
    }

    /// List of sessions.
    public let sessions: [Session]
    /// Total number of sessions that matched your query.
    public let total: Int

    init(
        sessions: [Session],
        total: Int
    ) {
        self.sessions = sessions
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.sessions = try container.decode([Session].self, forKey: .sessions)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(sessions, forKey: .sessions)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "sessions": sessions.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SessionList {
        return SessionList(
            sessions: (map["sessions"] as! [[String: Any]]).map { Session.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
