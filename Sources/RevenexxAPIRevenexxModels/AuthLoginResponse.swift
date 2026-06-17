import Foundation
import JSONCodable

/// 
open class AuthLoginResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case contact = "contact"
        case session = "session"
    }

    /// 
    public let contact: Contact?
    /// 
    public let session: AuthSession?

    init(
        contact: Contact?,
        session: AuthSession?
    ) {
        self.contact = contact
        self.session = session
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact = try container.decodeIfPresent(Contact.self, forKey: .contact)
        self.session = try container.decodeIfPresent(AuthSession.self, forKey: .session)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(contact, forKey: .contact)
        try container.encodeIfPresent(session, forKey: .session)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact": contact.toMap() as Any,
            "session": session.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthLoginResponse {
        return AuthLoginResponse(
            contact: Contact.from(map: map["contact"] as! [String: Any]),
            session: AuthSession.from(map: map["session"] as! [String: Any])
        )
    }
}
