import Foundation
import JSONCodable

/// 
open class AuthMeResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case contact = "contact"
        case permissions = "permissions"
        case user = "user"
    }

    /// The customer record mirrored against this user, or null. A user with no contact resolves perfectly well — that is not the 404.
    public let contact: Contact?
    /// A contact's effective grants, derived from its role on every read — nothing here is stored, so a role change can never leave a stale grant behind. Null when there is no contact to derive them from.
    public let permissions: ContactPermissions?
    /// The platform identity record, forwarded verbatim from the identity service. This app neither reshapes nor validates it, so treat unknown fields as forward-compatible; the ones named here are the ones this app itself writes and reads.
    public let user: [String: AnyCodable]?

    init(
        contact: Contact?,
        permissions: ContactPermissions?,
        user: [String: AnyCodable]?
    ) {
        self.contact = contact
        self.permissions = permissions
        self.user = user
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact = try container.decodeIfPresent(Contact.self, forKey: .contact)
        self.permissions = try container.decodeIfPresent(ContactPermissions.self, forKey: .permissions)
        self.user = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(contact, forKey: .contact)
        try container.encodeIfPresent(permissions, forKey: .permissions)
        try container.encodeIfPresent(user, forKey: .user)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact": contact?.toMap() as Any,
            "permissions": permissions?.toMap() as Any,
            "user": user as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthMeResponse {
        return AuthMeResponse(
            contact: Contact.from(map: map["contact"] as! [String: Any]),
            permissions: ContactPermissions.from(map: map["permissions"] as! [String: Any]),
            user: map["user"] as? [String: AnyCodable]
        )
    }
}
