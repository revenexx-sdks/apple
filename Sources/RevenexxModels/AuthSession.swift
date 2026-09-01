import Foundation
import JSONCodable

/// Platform auth session. Treat `secret` as a credential — the trusted BFF stores it server-side (HTTP-only cookie), never in the browser.
open class AuthSession: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case expire = "expire"
        case provider = "provider"
        case secret = "secret"
        case userId = "userId"
    }

    /// The session id. Send it back as `session_id` to log out, or to have `/auth/me` check that the session is still alive.
    public let id: String?
    /// When the session stops being valid on its own.
    public let expire: String?
    /// How the session was created. Server-minted sessions from this route are not the browser-facing email/password ones, so this says which mechanism issued it.
    public let provider: String?
    /// The session CREDENTIAL. Whoever holds it is logged in — the BFF keeps it server-side (an HTTP-only cookie), never in the browser and never in a log.
    public let secret: String?
    /// The platform user this session belongs to — the `user_id` every other auth route takes. NOT the contact id: the contact is in `contact`.
    public let userId: String?

    init(
        id: String?,
        expire: String?,
        provider: String?,
        secret: String?,
        userId: String?
    ) {
        self.id = id
        self.expire = expire
        self.provider = provider
        self.secret = secret
        self.userId = userId
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.expire = try container.decodeIfPresent(String.self, forKey: .expire)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.secret = try container.decodeIfPresent(String.self, forKey: .secret)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(expire, forKey: .expire)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(secret, forKey: .secret)
        try container.encodeIfPresent(userId, forKey: .userId)
    }

    public func toMap() -> [String: Any] {
        return [
            "$id": id as Any,
            "expire": expire as Any,
            "provider": provider as Any,
            "secret": secret as Any,
            "userId": userId as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthSession {
        return AuthSession(
            id: map["$id"] as? String,
            expire: map["expire"] as? String,
            provider: map["provider"] as? String,
            secret: map["secret"] as? String,
            userId: map["userId"] as? String
        )
    }
}
