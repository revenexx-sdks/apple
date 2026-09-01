import Foundation
import JSONCodable

/// The identity service's answer, forwarded verbatim.
open class AuthMfaChallengeConfirmResponse<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case data
    }

    /// The challenge that was answered.
    public let id: String?
    /// Additional properties
    public let data: T

    init(
        id: String?,
        data: T
    ) {
        self.id = id
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "$id": id as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> AuthMfaChallengeConfirmResponse {
        return AuthMfaChallengeConfirmResponse(
            id: map["$id"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
