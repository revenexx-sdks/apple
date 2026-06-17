import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// ColumnDatetime
open class ColumnDatetime: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case updatedAt = "$updatedAt"
        case array = "array"
        case error = "error"
        case format = "format"
        case key = "key"
        case `required` = "required"
        case status = "status"
        case type = "type"
    }

    /// Column creation date in ISO 8601 format.
    public let createdAt: String
    /// Column update date in ISO 8601 format.
    public let updatedAt: String
    /// Is column an array?
    public let array: Bool?
    /// Error message. Displays error generated on failure of creating or deleting an column.
    public let error: String
    /// ISO 8601 format.
    public let format: String
    /// Column Key.
    public let key: String
    /// Is column required?
    public let `required`: Bool
    /// Column status. Possible values: `available`, `processing`, `deleting`, `stuck`, or `failed`
    public let status: Revenexx API — revenexxEnums.ColumnDatetimeStatus
    /// Column type.
    public let type: String

    init(
        createdAt: String,
        updatedAt: String,
        array: Bool?,
        error: String,
        format: String,
        key: String,
        `required`: Bool,
        status: Revenexx API — revenexxEnums.ColumnDatetimeStatus,
        type: String
    ) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.array = array
        self.error = error
        self.format = format
        self.key = key
        self.`required` = `required`
        self.status = status
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.array = try container.decodeIfPresent(Bool.self, forKey: .array)
        self.error = try container.decode(String.self, forKey: .error)
        self.format = try container.decode(String.self, forKey: .format)
        self.key = try container.decode(String.self, forKey: .key)
        self.`required` = try container.decode(Bool.self, forKey: .`required`)
        self.status = Revenexx API — revenexxEnums.ColumnDatetimeStatus(rawValue: try container.decode(String.self, forKey: .status))!
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(array, forKey: .array)
        try container.encode(error, forKey: .error)
        try container.encode(format, forKey: .format)
        try container.encode(key, forKey: .key)
        try container.encode(`required`, forKey: .`required`)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$updatedAt": updatedAt as Any,
            "array": array as Any,
            "error": error as Any,
            "format": format as Any,
            "key": key as Any,
            "required": `required` as Any,
            "status": status.rawValue as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ColumnDatetime {
        return ColumnDatetime(
            createdAt: map["$createdAt"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            array: map["array"] as? Bool,
            error: map["error"] as! String,
            format: map["format"] as! String,
            key: map["key"] as! String,
            required: map["required"] as! Bool,
            status: ColumnDatetimeStatus(rawValue: map["status"] as! String)!,
            type: map["type"] as! String
        )
    }
}
