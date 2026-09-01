import Foundation
import JSONCodable
import RevenexxEnums

/// The identity service's recovery token, minus its secret, plus which mail the customer got. The secret is stripped deliberately — it travels only in the mailed link, and a caller that had both would not need the mail at all. `mail` is `tenant` when this shop's own template went out and `platform` when the messaging service could not be reached and the identity service's built-in mail is the copy the buyer has; the link is the same either way.
open class AuthRecoveryResponse<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case expire = "expire"
        case mail = "mail"
        case userId = "userId"
        case data
    }

    /// The recovery that was created.
    public let id: String?
    /// When the link stops working. The mail says the same thing in words.
    public let expire: String?
    /// Which template the buyer received: 'tenant' is this shop's own, 'platform' the identity service's built-in one — the fallback when messaging could not be reached. The link is identical either way, so a reset works in both cases.
    public let mail: RevenexxEnums.RecoveryMailSource?
    /// The platform user it belongs to.
    public let userId: String?
    /// Additional properties
    public let data: T

    init(
        id: String?,
        expire: String?,
        mail: RevenexxEnums.RecoveryMailSource?,
        userId: String?,
        data: T
    ) {
        self.id = id
        self.expire = expire
        self.mail = mail
        self.userId = userId
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.expire = try container.decodeIfPresent(String.self, forKey: .expire)
        if let mailString = try container.decodeIfPresent(String.self, forKey: .mail) {
            self.mail = RevenexxEnums.RecoveryMailSource(rawValue: mailString)
        } else {
            self.mail = nil
        }
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(expire, forKey: .expire)
        try container.encodeIfPresent(mail?.rawValue, forKey: .mail)
        try container.encodeIfPresent(userId, forKey: .userId)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "$id": id as Any,
            "expire": expire as Any,
            "mail": mail?.rawValue as Any,
            "userId": userId as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> AuthRecoveryResponse {
        return AuthRecoveryResponse(
            id: map["$id"] as? String,
            expire: map["expire"] as? String,
            mail: map["mail"] as? String != nil ? RecoveryMailSource(rawValue: map["mail"] as! String) : nil,
            userId: map["userId"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
