import Foundation
import JSONCodable

/// 
open class AuthMagicLinkConfirmResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case contact = "contact"
        case permissions = "permissions"
        case session = "session"
    }

    /// The customer record behind the login. Null when no contact is mirrored against the platform user yet — a sign-in link creates the account, not the customer.
    public let contact: Contact?
    /// A contact's effective grants, derived from its role on every read — nothing here is stored, so a role change can never leave a stale grant behind. Null when there is no contact to derive them from.
    public let permissions: ContactPermissions?
    /// Platform auth session. Treat `secret` as a credential — the trusted BFF stores it server-side (HTTP-only cookie), never in the browser.
    public let session: AuthSession?

    init(
        contact: Contact?,
        permissions: ContactPermissions?,
        session: AuthSession?
    ) {
        self.contact = contact
        self.permissions = permissions
        self.session = session
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact = try container.decodeIfPresent(Contact.self, forKey: .contact)
        self.permissions = try container.decodeIfPresent(ContactPermissions.self, forKey: .permissions)
        self.session = try container.decodeIfPresent(AuthSession.self, forKey: .session)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(contact, forKey: .contact)
        try container.encodeIfPresent(permissions, forKey: .permissions)
        try container.encodeIfPresent(session, forKey: .session)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact": contact?.toMap() as Any,
            "permissions": permissions?.toMap() as Any,
            "session": session?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthMagicLinkConfirmResponse {
        return AuthMagicLinkConfirmResponse(
            contact: Contact.from(map: map["contact"] as! [String: Any]),
            permissions: ContactPermissions.from(map: map["permissions"] as! [String: Any]),
            session: AuthSession.from(map: map["session"] as! [String: Any])
        )
    }
}
