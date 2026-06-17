import Foundation
import JSONCodable

/// 
open class AuthMeRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case session_id = "session_id"
        case user_id = "user_id"
    }

    /// Optional session to verify — answers 401 when the session is expired or revoked.
    public let session_id: String?
    /// 
    public let user_id: String

    init(
        session_id: String?,
        user_id: String
    ) {
        self.session_id = session_id
        self.user_id = user_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.session_id = try container.decodeIfPresent(String.self, forKey: .session_id)
        self.user_id = try container.decode(String.self, forKey: .user_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(session_id, forKey: .session_id)
        try container.encode(user_id, forKey: .user_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "session_id": session_id as Any,
            "user_id": user_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthMeRequest {
        return AuthMeRequest(
            session_id: map["session_id"] as? String,
            user_id: map["user_id"] as! String
        )
    }
}
