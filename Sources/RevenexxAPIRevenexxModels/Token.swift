import Foundation
import JSONCodable

/// Token
open class Token: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case expire = "expire"
        case phrase = "phrase"
        case secret = "secret"
        case userId = "userId"
    }

    /// Token creation date in ISO 8601 format.
    public let createdAt: String
    /// Token ID.
    public let id: String
    /// Token expiration date in ISO 8601 format.
    public let expire: String
    /// Security phrase of a token. Empty if security phrase was not requested when creating a token. It includes randomly generated phrase which is also sent in the external resource such as email.
    public let phrase: String
    /// Token secret key. This will return an empty string unless the response is returned using an API key or as part of a webhook payload.
    public let secret: String
    /// User ID.
    public let userId: String

    init(
        createdAt: String,
        id: String,
        expire: String,
        phrase: String,
        secret: String,
        userId: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.expire = expire
        self.phrase = phrase
        self.secret = secret
        self.userId = userId
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.expire = try container.decode(String.self, forKey: .expire)
        self.phrase = try container.decode(String.self, forKey: .phrase)
        self.secret = try container.decode(String.self, forKey: .secret)
        self.userId = try container.decode(String.self, forKey: .userId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(expire, forKey: .expire)
        try container.encode(phrase, forKey: .phrase)
        try container.encode(secret, forKey: .secret)
        try container.encode(userId, forKey: .userId)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "expire": expire as Any,
            "phrase": phrase as Any,
            "secret": secret as Any,
            "userId": userId as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Token {
        return Token(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            expire: map["expire"] as! String,
            phrase: map["phrase"] as! String,
            secret: map["secret"] as! String,
            userId: map["userId"] as! String
        )
    }
}
