import Foundation
import JSONCodable

/// 
open class AuthLoginResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case challenge_id = "challenge_id"
        case contact = "contact"
        case mfa_required = "mfa_required"
        case permissions = "permissions"
        case session = "session"
    }

    /// The challenge to answer, when one was required. Send it back as `challenge_id`.
    public let challenge_id: String?
    /// The customer record behind the login. Null when a platform user has no contact mirrored against it — a storefront should treat that as "signed in, but not a customer of this app".
    public let contact: Contact?
    /// Present and true when the tenant's `mfa_mode` is 'required'. The password was one of two things this buyer has to prove: a challenge has already been created and mailed, and the session above must NOT be treated as signed in until `PUT /customers/auth/mfa/challenge` confirms the code. The session travels anyway because answering needs it — the expected caller holds session material server-side, and this is the point at which that trust is used.
    public let mfa_required: Bool?
    /// A contact's effective grants, derived from its role on every read — nothing here is stored, so a role change can never leave a stale grant behind. Carried here so a BFF does not need a second call to decide what to render.
    public let permissions: ContactPermissions?
    /// Platform auth session. Treat `secret` as a credential — the trusted BFF stores it server-side (HTTP-only cookie), never in the browser.
    public let session: AuthSession?

    init(
        challenge_id: String?,
        contact: Contact?,
        mfa_required: Bool?,
        permissions: ContactPermissions?,
        session: AuthSession?
    ) {
        self.challenge_id = challenge_id
        self.contact = contact
        self.mfa_required = mfa_required
        self.permissions = permissions
        self.session = session
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.challenge_id = try container.decodeIfPresent(String.self, forKey: .challenge_id)
        self.contact = try container.decodeIfPresent(Contact.self, forKey: .contact)
        self.mfa_required = try container.decodeIfPresent(Bool.self, forKey: .mfa_required)
        self.permissions = try container.decodeIfPresent(ContactPermissions.self, forKey: .permissions)
        self.session = try container.decodeIfPresent(AuthSession.self, forKey: .session)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(challenge_id, forKey: .challenge_id)
        try container.encodeIfPresent(contact, forKey: .contact)
        try container.encodeIfPresent(mfa_required, forKey: .mfa_required)
        try container.encodeIfPresent(permissions, forKey: .permissions)
        try container.encodeIfPresent(session, forKey: .session)
    }

    public func toMap() -> [String: Any] {
        return [
            "challenge_id": challenge_id as Any,
            "contact": contact?.toMap() as Any,
            "mfa_required": mfa_required as Any,
            "permissions": permissions?.toMap() as Any,
            "session": session?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthLoginResponse {
        return AuthLoginResponse(
            challenge_id: map["challenge_id"] as? String,
            contact: Contact.from(map: map["contact"] as! [String: Any]),
            mfa_required: map["mfa_required"] as? Bool,
            permissions: ContactPermissions.from(map: map["permissions"] as! [String: Any]),
            session: AuthSession.from(map: map["session"] as! [String: Any])
        )
    }
}
