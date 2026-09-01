import Foundation
import JSONCodable
import RevenexxEnums

/// ColumnString
open class ColumnString: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case updatedAt = "$updatedAt"
        case array = "array"
        case encrypt = "encrypt"
        case error = "error"
        case key = "key"
        case `required` = "required"
        case size = "size"
        case status = "status"
        case type = "type"
    }

    /// Column creation date in ISO 8601 format.
    public let createdAt: String
    /// Column update date in ISO 8601 format.
    public let updatedAt: String
    /// Is column an array?
    public let array: Bool?
    /// Defines whether this column is encrypted or not.
    public let encrypt: Bool?
    /// Error message. Displays error generated on failure of creating or deleting an column.
    public let error: String
    /// Column Key.
    public let key: String
    /// Is column required?
    public let `required`: Bool
    /// Column size.
    public let size: Int
    /// Column status. Possible values: `available`, `processing`, `deleting`, `stuck`, or `failed`
    public let status: RevenexxEnums.ColumnStringStatus
    /// Column type.
    public let type: String

    init(
        createdAt: String,
        updatedAt: String,
        array: Bool?,
        encrypt: Bool?,
        error: String,
        key: String,
        `required`: Bool,
        size: Int,
        status: RevenexxEnums.ColumnStringStatus,
        type: String
    ) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.array = array
        self.encrypt = encrypt
        self.error = error
        self.key = key
        self.`required` = `required`
        self.size = size
        self.status = status
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.array = try container.decodeIfPresent(Bool.self, forKey: .array)
        self.encrypt = try container.decodeIfPresent(Bool.self, forKey: .encrypt)
        self.error = try container.decode(String.self, forKey: .error)
        self.key = try container.decode(String.self, forKey: .key)
        self.`required` = try container.decode(Bool.self, forKey: .`required`)
        self.size = try container.decode(Int.self, forKey: .size)
        self.status = RevenexxEnums.ColumnStringStatus(rawValue: try container.decode(String.self, forKey: .status))!
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(array, forKey: .array)
        try container.encodeIfPresent(encrypt, forKey: .encrypt)
        try container.encode(error, forKey: .error)
        try container.encode(key, forKey: .key)
        try container.encode(`required`, forKey: .`required`)
        try container.encode(size, forKey: .size)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$updatedAt": updatedAt as Any,
            "array": array as Any,
            "encrypt": encrypt as Any,
            "error": error as Any,
            "key": key as Any,
            "required": `required` as Any,
            "size": size as Any,
            "status": status.rawValue as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ColumnString {
        return ColumnString(
            createdAt: map["$createdAt"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            array: map["array"] as? Bool,
            encrypt: map["encrypt"] as? Bool,
            error: map["error"] as! String,
            key: map["key"] as! String,
            required: map["required"] as! Bool,
            size: map["size"] as! Int,
            status: ColumnStringStatus(rawValue: map["status"] as! String)!,
            type: map["type"] as! String
        )
    }
}
