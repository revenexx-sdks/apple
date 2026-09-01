import Foundation
import JSONCodable

/// 
open class AuthMagicLinkConfirmRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case secret = "secret"
        case user_id = "user_id"
    }

    /// The one-time secret the mailed link carried. Spent on first use and expiring, so a second attempt with the same one is a 401 rather than a second session.
    public let secret: String
    /// The `userId` the mailed link carried.
    public let user_id: String

    init(
        secret: String,
        user_id: String
    ) {
        self.secret = secret
        self.user_id = user_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.secret = try container.decode(String.self, forKey: .secret)
        self.user_id = try container.decode(String.self, forKey: .user_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(secret, forKey: .secret)
        try container.encode(user_id, forKey: .user_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "secret": secret as Any,
            "user_id": user_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthMagicLinkConfirmRequest {
        return AuthMagicLinkConfirmRequest(
            secret: map["secret"] as! String,
            user_id: map["user_id"] as! String
        )
    }
}
