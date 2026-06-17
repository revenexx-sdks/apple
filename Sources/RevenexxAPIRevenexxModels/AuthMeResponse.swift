import Foundation
import JSONCodable

/// 
open class AuthMeResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case contact = "contact"
        case user = "user"
    }

    /// 
    public let contact: Contact?
    /// 
    public let user: [String: AnyCodable]?

    init(
        contact: Contact?,
        user: [String: AnyCodable]?
    ) {
        self.contact = contact
        self.user = user
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact = try container.decodeIfPresent(Contact.self, forKey: .contact)
        self.user = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(contact, forKey: .contact)
        try container.encodeIfPresent(user, forKey: .user)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact": contact.toMap() as Any,
            "user": user as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthMeResponse {
        return AuthMeResponse(
            contact: Contact.from(map: map["contact"] as! [String: Any]),
            user: map["user"] as? [String: AnyCodable]
        )
    }
}
