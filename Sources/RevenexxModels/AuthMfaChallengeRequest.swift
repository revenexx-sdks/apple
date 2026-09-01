import Foundation
import JSONCodable

/// 
open class AuthMfaChallengeRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case factor = "factor"
        case user_id = "user_id"
    }

    /// Which factor to challenge. Defaults to `email`, the only one this route mails.
    public let factor: String?
    /// The platform user being challenged.
    public let user_id: String

    init(
        factor: String?,
        user_id: String
    ) {
        self.factor = factor
        self.user_id = user_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.factor = try container.decodeIfPresent(String.self, forKey: .factor)
        self.user_id = try container.decode(String.self, forKey: .user_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(factor, forKey: .factor)
        try container.encode(user_id, forKey: .user_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "factor": factor as Any,
            "user_id": user_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthMfaChallengeRequest {
        return AuthMfaChallengeRequest(
            factor: map["factor"] as? String,
            user_id: map["user_id"] as! String
        )
    }
}
