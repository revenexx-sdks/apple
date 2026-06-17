import Foundation
import JSONCodable

/// 
open class AuthLoginRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
    }

    /// 
    public let email: String
    /// 
    public let password: String

    init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }

    public func toMap() -> [String: Any] {
        return [
            "email": email as Any,
            "password": password as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthLoginRequest {
        return AuthLoginRequest(
            email: map["email"] as! String,
            password: map["password"] as! String
        )
    }
}
