import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// Partial update — omitted fields keep their current value; external_user_id is mirror-managed and ignored.
open class ContactUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case first_name = "first_name"
        case is_primary = "is_primary"
        case last_name = "last_name"
        case locale = "locale"
        case organization_id = "organization_id"
        case phone = "phone"
        case role = "role"
        case status = "status"
    }

    /// 
    public let email: String?
    /// 
    public let first_name: String?
    /// The primary contact of its organization.
    public let is_primary: Bool?
    /// 
    public let last_name: String?
    /// BCP 47, e.g. de-DE
    public let locale: String?
    /// Owning organization — membership is mirrored to the platform team.
    public let organization_id: String?
    /// 
    public let phone: String?
    /// Default &#039;buyer&#039; — also the team role on the platform mirror.
    public let role: Revenexx API — revenexxEnums.ContactRole?
    /// Default &#039;invited&#039; on create.
    public let status: Revenexx API — revenexxEnums.ContactStatus?

    init(
        email: String?,
        first_name: String?,
        is_primary: Bool?,
        last_name: String?,
        locale: String?,
        organization_id: String?,
        phone: String?,
        role: Revenexx API — revenexxEnums.ContactRole?,
        status: Revenexx API — revenexxEnums.ContactStatus?
    ) {
        self.email = email
        self.first_name = first_name
        self.is_primary = is_primary
        self.last_name = last_name
        self.locale = locale
        self.organization_id = organization_id
        self.phone = phone
        self.role = role
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.is_primary = try container.decodeIfPresent(Bool.self, forKey: .is_primary)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        if let roleString = try container.decodeIfPresent(String.self, forKey: .role) {
            self.role = Revenexx API — revenexxEnums.ContactRole(rawValue: roleString)
        } else {
            self.role = nil
        }
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = Revenexx API — revenexxEnums.ContactStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(first_name, forKey: .first_name)
        try container.encodeIfPresent(is_primary, forKey: .is_primary)
        try container.encodeIfPresent(last_name, forKey: .last_name)
        try container.encodeIfPresent(locale, forKey: .locale)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(role?.rawValue, forKey: .role)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "email": email as Any,
            "first_name": first_name as Any,
            "is_primary": is_primary as Any,
            "last_name": last_name as Any,
            "locale": locale as Any,
            "organization_id": organization_id as Any,
            "phone": phone as Any,
            "role": role?.rawValue as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ContactUpdateRequest {
        return ContactUpdateRequest(
            email: map["email"] as? String,
            first_name: map["first_name"] as? String,
            is_primary: map["is_primary"] as? Bool,
            last_name: map["last_name"] as? String,
            locale: map["locale"] as? String,
            organization_id: map["organization_id"] as? String,
            phone: map["phone"] as? String,
            role: map["role"] as? String != nil ? ContactRole(rawValue: map["role"] as! String) : nil,
            status: map["status"] as? String != nil ? ContactStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
