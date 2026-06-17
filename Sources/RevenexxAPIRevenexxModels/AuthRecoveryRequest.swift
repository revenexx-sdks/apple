import Foundation
import JSONCodable

/// 
open class AuthRecoveryRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case url = "url"
    }

    /// 
    public let email: String
    /// Redirect URL carrying userId + secret.
    public let url: String

    init(
        email: String,
        url: String
    ) {
        self.email = email
        self.url = url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decode(String.self, forKey: .email)
        self.url = try container.decode(String.self, forKey: .url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
        try container.encode(url, forKey: .url)
    }

    public func toMap() -> [String: Any] {
        return [
            "email": email as Any,
            "url": url as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthRecoveryRequest {
        return AuthRecoveryRequest(
            email: map["email"] as! String,
            url: map["url"] as! String
        )
    }
}
