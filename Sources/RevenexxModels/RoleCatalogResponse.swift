import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class RoleCatalogResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case permissions = "permissions"
        case roles = "roles"
        case source = "source"
    }

    /// The built-in permission vocabulary, one entry per grant. The authoritative, installed-app-aware list is the platform's permission ledger — this app deliberately does not duplicate it.
    public let permissions: [[String: AnyCodable]]?
    /// Every role a contact of this tenant can hold, least to most privileged.
    public let roles: [[String: AnyCodable]]?
    /// 'tenant' — the configured mapping answered. 'defaults' — this tenant has no roles yet, or custom_roles_enabled locks the ledger, and the built-ins answered.
    public let source: RevenexxEnums.RoleCatalogResponseSource?

    init(
        permissions: [[String: AnyCodable]]?,
        roles: [[String: AnyCodable]]?,
        source: RevenexxEnums.RoleCatalogResponseSource?
    ) {
        self.permissions = permissions
        self.roles = roles
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.permissions = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .permissions)
        self.roles = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .roles)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.RoleCatalogResponseSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(permissions, forKey: .permissions)
        try container.encodeIfPresent(roles, forKey: .roles)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "permissions": permissions as Any,
            "roles": roles as Any,
            "source": source?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> RoleCatalogResponse {
        return RoleCatalogResponse(
            permissions: map["permissions"] as? [[String: AnyCodable]],
            roles: map["roles"] as? [[String: AnyCodable]],
            source: map["source"] as? String != nil ? RoleCatalogResponseSource(rawValue: map["source"] as! String) : nil
        )
    }
}
