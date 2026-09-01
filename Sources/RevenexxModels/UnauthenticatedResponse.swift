import Foundation
import JSONCodable

/// 
open class UnauthenticatedResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }

    /// 
    public let message: String?

    init(
        message: String?
    ) {
        self.message = message
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(message, forKey: .message)
    }

    public func toMap() -> [String: Any] {
        return [
            "message": message as Any
        ]
    }

    public static func from(map: [String: Any] ) -> UnauthenticatedResponse {
        return UnauthenticatedResponse(
            message: map["message"] as? String
        )
    }
}
