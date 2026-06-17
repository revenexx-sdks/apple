import Foundation
import JSONCodable

/// Uniform gateway error response.
open class Error: Codable {

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "message"
    }

    /// 
    public let error: Bool
    /// 
    public let message: String

    init(
        error: Bool,
        message: String
    ) {
        self.error = error
        self.message = message
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.error = try container.decode(Bool.self, forKey: .error)
        self.message = try container.decode(String.self, forKey: .message)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(error, forKey: .error)
        try container.encode(message, forKey: .message)
    }

    public func toMap() -> [String: Any] {
        return [
            "error": error as Any,
            "message": message as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Error {
        return Error(
            error: map["error"] as! Bool,
            message: map["message"] as! String
        )
    }
}
