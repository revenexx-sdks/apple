import Foundation
import JSONCodable

/// When this working copy should go live.
open class PageScheduleRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case scheduledAt = "scheduledAt"
    }

    /// The moment to publish at. Stored on the edit state and echoed back normalized to UTC.
    public let scheduledAt: String

    init(
        scheduledAt: String
    ) {
        self.scheduledAt = scheduledAt
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.scheduledAt = try container.decode(String.self, forKey: .scheduledAt)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(scheduledAt, forKey: .scheduledAt)
    }

    public func toMap() -> [String: Any] {
        return [
            "scheduledAt": scheduledAt as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageScheduleRequest {
        return PageScheduleRequest(
            scheduledAt: map["scheduledAt"] as! String
        )
    }
}
