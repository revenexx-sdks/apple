import Foundation
import JSONCodable

/// The identity service's answer, forwarded verbatim: the spent verification token.
open class AuthVerificationConfirmResponse<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case userId = "userId"
        case data
    }

    /// The verification that was confirmed.
    public let id: String?
    /// The platform user whose address is now confirmed.
    public let userId: String?
    /// Additional properties
    public let data: T

    init(
        id: String?,
        userId: String?,
        data: T
    ) {
        self.id = id
        self.userId = userId
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(userId, forKey: .userId)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "$id": id as Any,
            "userId": userId as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> AuthVerificationConfirmResponse {
        return AuthVerificationConfirmResponse(
            id: map["$id"] as? String,
            userId: map["userId"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
