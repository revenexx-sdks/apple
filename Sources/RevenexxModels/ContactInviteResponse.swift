import Foundation
import JSONCodable

/// 
open class ContactInviteResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case contact_id = "contact_id"
        case invited = "invited"
        case organization_id = "organization_id"
    }

    /// Who was invited.
    public let contact_id: String?
    /// Always true when this answers — a failure to send is a 502, not a false here.
    public let invited: Bool?
    /// The company they were invited into.
    public let organization_id: String?

    init(
        contact_id: String?,
        invited: Bool?,
        organization_id: String?
    ) {
        self.contact_id = contact_id
        self.invited = invited
        self.organization_id = organization_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.invited = try container.decodeIfPresent(Bool.self, forKey: .invited)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(invited, forKey: .invited)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact_id": contact_id as Any,
            "invited": invited as Any,
            "organization_id": organization_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ContactInviteResponse {
        return ContactInviteResponse(
            contact_id: map["contact_id"] as? String,
            invited: map["invited"] as? Bool,
            organization_id: map["organization_id"] as? String
        )
    }
}
