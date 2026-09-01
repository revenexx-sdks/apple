import Foundation
import JSONCodable

/// 
open class AuthRecoveryConfirmRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case password = "password"
        case secret = "secret"
        case user_id = "user_id"
    }

    /// The new password. It replaces the old one immediately; existing sessions are the identity service's business, not this app's.
    public let password: String
    /// The one-time secret from the mailed link. Only that value works — it is spent on first use and expires, and anything else is a 401, so no example here would be anything but a call that fails.
    public let secret: String
    /// The `userId` the mailed link carried.
    public let user_id: String

    init(
        password: String,
        secret: String,
        user_id: String
    ) {
        self.password = password
        self.secret = secret
        self.user_id = user_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.password = try container.decode(String.self, forKey: .password)
        self.secret = try container.decode(String.self, forKey: .secret)
        self.user_id = try container.decode(String.self, forKey: .user_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(password, forKey: .password)
        try container.encode(secret, forKey: .secret)
        try container.encode(user_id, forKey: .user_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "password": password as Any,
            "secret": secret as Any,
            "user_id": user_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthRecoveryConfirmRequest {
        return AuthRecoveryConfirmRequest(
            password: map["password"] as! String,
            secret: map["secret"] as! String,
            user_id: map["user_id"] as! String
        )
    }
}
