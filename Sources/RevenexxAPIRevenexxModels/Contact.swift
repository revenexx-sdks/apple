import Foundation
import JSONCodable

/// 
open class Contact: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case email = "email"
        case external_user_id = "external_user_id"
        case first_name = "first_name"
        case id = "id"
        case is_primary = "is_primary"
        case last_name = "last_name"
        case locale = "locale"
        case organization_id = "organization_id"
        case phone = "phone"
        case role = "role"
        case status = "status"
        case updated_at = "updated_at"
    }

    /// 
    public let created_at: String?
    /// 
    public let email: String?
    /// 
    public let external_user_id: String?
    /// 
    public let first_name: String?
    /// 
    public let id: String?
    /// 
    public let is_primary: Bool?
    /// 
    public let last_name: String?
    /// 
    public let locale: String?
    /// 
    public let organization_id: String?
    /// 
    public let phone: String?
    /// 
    public let role: String?
    /// 
    public let status: String?
    /// 
    public let updated_at: String?

    init(
        created_at: String?,
        email: String?,
        external_user_id: String?,
        first_name: String?,
        id: String?,
        is_primary: Bool?,
        last_name: String?,
        locale: String?,
        organization_id: String?,
        phone: String?,
        role: String?,
        status: String?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.email = email
        self.external_user_id = external_user_id
        self.first_name = first_name
        self.id = id
        self.is_primary = is_primary
        self.last_name = last_name
        self.locale = locale
        self.organization_id = organization_id
        self.phone = phone
        self.role = role
        self.status = status
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.external_user_id = try container.decodeIfPresent(String.self, forKey: .external_user_id)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_primary = try container.decodeIfPresent(Bool.self, forKey: .is_primary)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.role = try container.decodeIfPresent(String.self, forKey: .role)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(external_user_id, forKey: .external_user_id)
        try container.encodeIfPresent(first_name, forKey: .first_name)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_primary, forKey: .is_primary)
        try container.encodeIfPresent(last_name, forKey: .last_name)
        try container.encodeIfPresent(locale, forKey: .locale)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "email": email as Any,
            "external_user_id": external_user_id as Any,
            "first_name": first_name as Any,
            "id": id as Any,
            "is_primary": is_primary as Any,
            "last_name": last_name as Any,
            "locale": locale as Any,
            "organization_id": organization_id as Any,
            "phone": phone as Any,
            "role": role as Any,
            "status": status as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Contact {
        return Contact(
            created_at: map["created_at"] as? String,
            email: map["email"] as? String,
            external_user_id: map["external_user_id"] as? String,
            first_name: map["first_name"] as? String,
            id: map["id"] as? String,
            is_primary: map["is_primary"] as? Bool,
            last_name: map["last_name"] as? String,
            locale: map["locale"] as? String,
            organization_id: map["organization_id"] as? String,
            phone: map["phone"] as? String,
            role: map["role"] as? String,
            status: map["status"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
