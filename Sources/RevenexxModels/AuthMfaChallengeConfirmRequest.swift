import Foundation
import JSONCodable

/// 
open class AuthMfaChallengeConfirmRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case challenge_id = "challenge_id"
        case code = "code"
        case session_secret = "session_secret"
        case user_id = "user_id"
    }

    /// The `$id` the send answered with.
    public let challenge_id: String
    /// What the buyer typed.
    public let code: String
    /// The same session the challenge was created with.
    public let session_secret: String
    /// The platform user, for the caller's own bookkeeping. The challenge already knows whose it is.
    public let user_id: String?

    init(
        challenge_id: String,
        code: String,
        session_secret: String,
        user_id: String?
    ) {
        self.challenge_id = challenge_id
        self.code = code
        self.session_secret = session_secret
        self.user_id = user_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.challenge_id = try container.decode(String.self, forKey: .challenge_id)
        self.code = try container.decode(String.self, forKey: .code)
        self.session_secret = try container.decode(String.self, forKey: .session_secret)
        self.user_id = try container.decodeIfPresent(String.self, forKey: .user_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(challenge_id, forKey: .challenge_id)
        try container.encode(code, forKey: .code)
        try container.encode(session_secret, forKey: .session_secret)
        try container.encodeIfPresent(user_id, forKey: .user_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "challenge_id": challenge_id as Any,
            "code": code as Any,
            "session_secret": session_secret as Any,
            "user_id": user_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthMfaChallengeConfirmRequest {
        return AuthMfaChallengeConfirmRequest(
            challenge_id: map["challenge_id"] as! String,
            code: map["code"] as! String,
            session_secret: map["session_secret"] as! String,
            user_id: map["user_id"] as? String
        )
    }
}
