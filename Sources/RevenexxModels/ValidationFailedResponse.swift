import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ValidationFailedResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case errors = "errors"
        case status = "status"
    }

    /// 
    public let errors: [String]?
    /// 
    public let status: RevenexxEnums.ValidationFailedResponseStatus?

    init(
        errors: [String]?,
        status: RevenexxEnums.ValidationFailedResponseStatus?
    ) {
        self.errors = errors
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.errors = try container.decodeIfPresent([String].self, forKey: .errors)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.ValidationFailedResponseStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(errors, forKey: .errors)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "errors": errors as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ValidationFailedResponse {
        return ValidationFailedResponse(
            errors: map["errors"] as? [String],
            status: map["status"] as? String != nil ? ValidationFailedResponseStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
