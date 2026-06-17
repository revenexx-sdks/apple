import Foundation
import JSONCodable

/// 
open class AuthRecoveryConfirmRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case password = "password"
        case secret = "secret"
        case user_id = "user_id"
    }

    /// 
    public let password: String
    /// 
    public let secret: String
    /// 
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
