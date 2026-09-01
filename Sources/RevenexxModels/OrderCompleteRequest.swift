import Foundation
import JSONCodable

/// No required fields — send {}.
open class OrderCompleteRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case completed_by = "completed_by"
    }

    /// Who closed the order, as the caller reports it. Not stored on the order: it is carried in the order.completed event's payload, which is where the audit trail keeps who did what. Free text, not resolved against a user directory.
    public let completed_by: String?

    init(
        completed_by: String?
    ) {
        self.completed_by = completed_by
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.completed_by = try container.decodeIfPresent(String.self, forKey: .completed_by)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(completed_by, forKey: .completed_by)
    }

    public func toMap() -> [String: Any] {
        return [
            "completed_by": completed_by as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCompleteRequest {
        return OrderCompleteRequest(
            completed_by: map["completed_by"] as? String
        )
    }
}
