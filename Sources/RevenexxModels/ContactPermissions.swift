import Foundation
import JSONCodable

/// A contact's effective grants, derived from its role on every read — nothing here is stored, so a role change can never leave a stale grant behind. Carried here so a BFF does not need a second call to decide what to render.
open class ContactPermissions: Codable {

    enum CodingKeys: String, CodingKey {
        case active = "active"
        case contact_id = "contact_id"
        case order_approval_limit = "order_approval_limit"
        case organization_id = "organization_id"
        case permissions = "permissions"
        case role = "role"
    }

    /// False while the contact is blocked or its registration is still pending/rejected — it holds the role but must not act on it.
    public let active: Bool?
    /// The person these grants belong to. Null when the answer describes nobody — a user with no contact mirrored against it.
    public let contact_id: String?
    /// Amount ceiling in the market's currency; null means no ceiling. Only meaningful together with the 'orders.approve' permission.
    public let order_approval_limit: Double?
    /// The organization the role applies inside. Null for a standalone (B2C) contact — a role with no company to hold it in.
    public let organization_id: String?
    /// What this role may do. Derived from the role — see GET /customers/roles.
    public let permissions: [String]?
    /// The role this contact holds in its organization, and the only input to `permissions`.
    public let role: String?

    init(
        active: Bool?,
        contact_id: String?,
        order_approval_limit: Double?,
        organization_id: String?,
        permissions: [String]?,
        role: String?
    ) {
        self.active = active
        self.contact_id = contact_id
        self.order_approval_limit = order_approval_limit
        self.organization_id = organization_id
        self.permissions = permissions
        self.role = role
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.active = try container.decodeIfPresent(Bool.self, forKey: .active)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.order_approval_limit = try container.decodeIfPresent(Double.self, forKey: .order_approval_limit)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.permissions = try container.decodeIfPresent([String].self, forKey: .permissions)
        self.role = try container.decodeIfPresent(String.self, forKey: .role)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(active, forKey: .active)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(order_approval_limit, forKey: .order_approval_limit)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(permissions, forKey: .permissions)
        try container.encodeIfPresent(role, forKey: .role)
    }

    public func toMap() -> [String: Any] {
        return [
            "active": active as Any,
            "contact_id": contact_id as Any,
            "order_approval_limit": order_approval_limit as Any,
            "organization_id": organization_id as Any,
            "permissions": permissions as Any,
            "role": role as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ContactPermissions {
        return ContactPermissions(
            active: map["active"] as? Bool,
            contact_id: map["contact_id"] as? String,
            order_approval_limit: map["order_approval_limit"] as? Double,
            organization_id: map["organization_id"] as? String,
            permissions: map["permissions"] as? [String],
            role: map["role"] as? String
        )
    }
}
