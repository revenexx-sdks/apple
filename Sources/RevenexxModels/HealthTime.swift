import Foundation
import JSONCodable

/// Health Time
open class HealthTime: Codable {

    enum CodingKeys: String, CodingKey {
        case diff = "diff"
        case localTime = "localTime"
        case remoteTime = "remoteTime"
    }

    /// Difference of unix remote and local timestamps in milliseconds.
    public let diff: Int
    /// Current unix timestamp of the core service host.
    public let localTime: Int
    /// Current unix timestamp on trustful remote server.
    public let remoteTime: Int

    init(
        diff: Int,
        localTime: Int,
        remoteTime: Int
    ) {
        self.diff = diff
        self.localTime = localTime
        self.remoteTime = remoteTime
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.diff = try container.decode(Int.self, forKey: .diff)
        self.localTime = try container.decode(Int.self, forKey: .localTime)
        self.remoteTime = try container.decode(Int.self, forKey: .remoteTime)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(diff, forKey: .diff)
        try container.encode(localTime, forKey: .localTime)
        try container.encode(remoteTime, forKey: .remoteTime)
    }

    public func toMap() -> [String: Any] {
        return [
            "diff": diff as Any,
            "localTime": localTime as Any,
            "remoteTime": remoteTime as Any
        ]
    }

    public static func from(map: [String: Any] ) -> HealthTime {
        return HealthTime(
            diff: map["diff"] as! Int,
            localTime: map["localTime"] as! Int,
            remoteTime: map["remoteTime"] as! Int
        )
    }
}
