import Foundation
import JSONCodable

/// 
open class AuthRegisterResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case contact = "contact"
        case user_id = "user_id"
    }

    /// 
    public let contact: Contact?
    /// 
    public let user_id: String?

    init(
        contact: Contact?,
        user_id: String?
    ) {
        self.contact = contact
        self.user_id = user_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact = try container.decodeIfPresent(Contact.self, forKey: .contact)
        self.user_id = try container.decodeIfPresent(String.self, forKey: .user_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(contact, forKey: .contact)
        try container.encodeIfPresent(user_id, forKey: .user_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact": contact.toMap() as Any,
            "user_id": user_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthRegisterResponse {
        return AuthRegisterResponse(
            contact: Contact.from(map: map["contact"] as! [String: Any]),
            user_id: map["user_id"] as? String
        )
    }
}
