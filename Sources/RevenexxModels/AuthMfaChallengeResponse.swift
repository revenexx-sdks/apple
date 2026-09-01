import Foundation
import JSONCodable
import RevenexxEnums

/// The challenge, minus the code. The code is in the mail; a storefront that also received it would not be asking for a second factor.
open class AuthMfaChallengeResponse<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case expire = "expire"
        case mail = "mail"
        case userId = "userId"
        case data
    }

    /// The challenge — send it back as `challenge_id` with the code the buyer types.
    public let id: String?
    /// When the code stops working.
    public let expire: String?
    /// Which template the buyer received: 'tenant' is this shop's own, 'platform' the identity service's built-in one — the fallback when messaging could not be reached. The value is the same either way, so the flow works in both cases.
    public let mail: RevenexxEnums.AuthMailSource?
    /// The platform user it belongs to.
    public let userId: String?
    /// Additional properties
    public let data: T

    init(
        id: String?,
        expire: String?,
        mail: RevenexxEnums.AuthMailSource?,
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
            self.mail = RevenexxEnums.AuthMailSource(rawValue: mailString)
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

    public static func from(map: [String: Any] ) -> AuthMfaChallengeResponse {
        return AuthMfaChallengeResponse(
            id: map["$id"] as? String,
            expire: map["expire"] as? String,
            mail: map["mail"] as? String != nil ? AuthMailSource(rawValue: map["mail"] as! String) : nil,
            userId: map["userId"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
