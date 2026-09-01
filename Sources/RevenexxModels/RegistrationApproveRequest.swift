import Foundation
import JSONCodable

/// No required fields — send {}.
open class RegistrationApproveRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case decided_by = "decided_by"
    }

    /// Who approved it — recorded on the contact and carried in the event. Free text (operator id or email); this app does not resolve it.
    public let decided_by: String?

    init(
        decided_by: String?
    ) {
        self.decided_by = decided_by
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.decided_by = try container.decodeIfPresent(String.self, forKey: .decided_by)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(decided_by, forKey: .decided_by)
    }

    public func toMap() -> [String: Any] {
        return [
            "decided_by": decided_by as Any
        ]
    }

    public static func from(map: [String: Any] ) -> RegistrationApproveRequest {
        return RegistrationApproveRequest(
            decided_by: map["decided_by"] as? String
        )
    }
}
