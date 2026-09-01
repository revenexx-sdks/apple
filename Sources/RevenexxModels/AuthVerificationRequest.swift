import Foundation
import JSONCodable

/// 
open class AuthVerificationRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case user_id = "user_id"
    }

    /// Where the mailed link points. `userId`, `secret` and `expire` are appended as query parameters; the first two are what the confirm call takes.
    public let url: String
    /// The platform user whose address is being confirmed — `user_id` from the registration, or `session.userId` from a login.
    public let user_id: String

    init(
        url: String,
        user_id: String
    ) {
        self.url = url
        self.user_id = user_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.url = try container.decode(String.self, forKey: .url)
        self.user_id = try container.decode(String.self, forKey: .user_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(url, forKey: .url)
        try container.encode(user_id, forKey: .user_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "url": url as Any,
            "user_id": user_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthVerificationRequest {
        return AuthVerificationRequest(
            url: map["url"] as! String,
            user_id: map["user_id"] as! String
        )
    }
}
