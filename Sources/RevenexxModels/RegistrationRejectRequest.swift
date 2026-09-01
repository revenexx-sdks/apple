import Foundation
import JSONCodable

/// 
open class RegistrationRejectRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case decided_by = "decided_by"
        case reason = "reason"
    }

    /// Who rejected it — recorded on the contact and carried in the event.
    public let decided_by: String?
    /// Why the application was declined. Always stored on the contact. It only reaches the APPLICANT when the tenant's registration_reason_disclosed setting is on — the event payload then carries it, and so does the 403 the login answers.
    public let reason: String

    init(
        decided_by: String?,
        reason: String
    ) {
        self.decided_by = decided_by
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.decided_by = try container.decodeIfPresent(String.self, forKey: .decided_by)
        self.reason = try container.decode(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(decided_by, forKey: .decided_by)
        try container.encode(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "decided_by": decided_by as Any,
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> RegistrationRejectRequest {
        return RegistrationRejectRequest(
            decided_by: map["decided_by"] as? String,
            reason: map["reason"] as! String
        )
    }
}
