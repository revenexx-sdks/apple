import Foundation
import JSONCodable

/// 
open class AuthRegisterRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case first_name = "first_name"
        case last_name = "last_name"
        case locale = "locale"
        case organization_id = "organization_id"
        case organization_name = "organization_name"
        case password = "password"
    }

    /// 
    public let email: String
    /// 
    public let first_name: String?
    /// 
    public let last_name: String?
    /// BCP 47, e.g. de-DE
    public let locale: String?
    /// Join an existing organization.
    public let organization_id: String?
    /// Found a new organization; the contact becomes its admin.
    public let organization_name: String?
    /// 
    public let password: String

    init(
        email: String,
        first_name: String?,
        last_name: String?,
        locale: String?,
        organization_id: String?,
        organization_name: String?,
        password: String
    ) {
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.locale = locale
        self.organization_id = organization_id
        self.organization_name = organization_name
        self.password = password
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decode(String.self, forKey: .email)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.organization_name = try container.decodeIfPresent(String.self, forKey: .organization_name)
        self.password = try container.decode(String.self, forKey: .password)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
        try container.encodeIfPresent(first_name, forKey: .first_name)
        try container.encodeIfPresent(last_name, forKey: .last_name)
        try container.encodeIfPresent(locale, forKey: .locale)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(organization_name, forKey: .organization_name)
        try container.encode(password, forKey: .password)
    }

    public func toMap() -> [String: Any] {
        return [
            "email": email as Any,
            "first_name": first_name as Any,
            "last_name": last_name as Any,
            "locale": locale as Any,
            "organization_id": organization_id as Any,
            "organization_name": organization_name as Any,
            "password": password as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthRegisterRequest {
        return AuthRegisterRequest(
            email: map["email"] as! String,
            first_name: map["first_name"] as? String,
            last_name: map["last_name"] as? String,
            locale: map["locale"] as? String,
            organization_id: map["organization_id"] as? String,
            organization_name: map["organization_name"] as? String,
            password: map["password"] as! String
        )
    }
}
