import Foundation
import JSONCodable

/// 
open class AuthOtpRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case email = "email"
    }

    /// Who to send the code to. As with the sign-in link, an unknown address creates an account rather than failing.
    public let email: String

    init(
        email: String
    ) {
        self.email = email
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decode(String.self, forKey: .email)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
    }

    public func toMap() -> [String: Any] {
        return [
            "email": email as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthOtpRequest {
        return AuthOtpRequest(
            email: map["email"] as! String
        )
    }
}
