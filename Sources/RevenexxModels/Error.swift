import Foundation
import JSONCodable

/// Uniform error response. The same shape is emitted by the gateway and by the apps behind it, so one parser covers the whole API.
open class Error: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case error = "error"
        case message = "message"
    }

    /// Machine-readable discriminator, e.g. not_found, invalid_value, unique_violation.
    public let code: String?
    /// Human-readable message. Was a boolean on gateway-emitted errors before; it is a string everywhere now.
    public let error: String
    /// Deprecated duplicate of `error`, kept so existing readers keep working. Read `error`.
    public let message: String?

    init(
        code: String?,
        error: String,
        message: String?
    ) {
        self.code = code
        self.error = error
        self.message = message
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.error = try container.decode(String.self, forKey: .error)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encode(error, forKey: .error)
        try container.encodeIfPresent(message, forKey: .message)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "error": error as Any,
            "message": message as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Error {
        return Error(
            code: map["code"] as? String,
            error: map["error"] as! String,
            message: map["message"] as? String
        )
    }
}
