import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// ColumnRelationship
open class ColumnRelationship: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case updatedAt = "$updatedAt"
        case array = "array"
        case error = "error"
        case key = "key"
        case onDelete = "onDelete"
        case relatedTable = "relatedTable"
        case relationType = "relationType"
        case `required` = "required"
        case side = "side"
        case status = "status"
        case twoWay = "twoWay"
        case twoWayKey = "twoWayKey"
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
    /// Column Key.
    public let key: String
    /// How deleting the parent document will propagate to child documents.
    public let onDelete: String
    /// The ID of the related table.
    public let relatedTable: String
    /// The type of the relationship.
    public let relationType: String
    /// Is column required?
    public let `required`: Bool
    /// Whether this is the parent or child side of the relationship
    public let side: String
    /// Column status. Possible values: `available`, `processing`, `deleting`, `stuck`, or `failed`
    public let status: Revenexx API — revenexxEnums.ColumnRelationshipStatus
    /// Is the relationship two-way?
    public let twoWay: Bool
    /// The key of the two-way relationship.
    public let twoWayKey: String
    /// Column type.
    public let type: String

    init(
        createdAt: String,
        updatedAt: String,
        array: Bool?,
        error: String,
        key: String,
        onDelete: String,
        relatedTable: String,
        relationType: String,
        `required`: Bool,
        side: String,
        status: Revenexx API — revenexxEnums.ColumnRelationshipStatus,
        twoWay: Bool,
        twoWayKey: String,
        type: String
    ) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.array = array
        self.error = error
        self.key = key
        self.onDelete = onDelete
        self.relatedTable = relatedTable
        self.relationType = relationType
        self.`required` = `required`
        self.side = side
        self.status = status
        self.twoWay = twoWay
        self.twoWayKey = twoWayKey
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.array = try container.decodeIfPresent(Bool.self, forKey: .array)
        self.error = try container.decode(String.self, forKey: .error)
        self.key = try container.decode(String.self, forKey: .key)
        self.onDelete = try container.decode(String.self, forKey: .onDelete)
        self.relatedTable = try container.decode(String.self, forKey: .relatedTable)
        self.relationType = try container.decode(String.self, forKey: .relationType)
        self.`required` = try container.decode(Bool.self, forKey: .`required`)
        self.side = try container.decode(String.self, forKey: .side)
        self.status = Revenexx API — revenexxEnums.ColumnRelationshipStatus(rawValue: try container.decode(String.self, forKey: .status))!
        self.twoWay = try container.decode(Bool.self, forKey: .twoWay)
        self.twoWayKey = try container.decode(String.self, forKey: .twoWayKey)
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(array, forKey: .array)
        try container.encode(error, forKey: .error)
        try container.encode(key, forKey: .key)
        try container.encode(onDelete, forKey: .onDelete)
        try container.encode(relatedTable, forKey: .relatedTable)
        try container.encode(relationType, forKey: .relationType)
        try container.encode(`required`, forKey: .`required`)
        try container.encode(side, forKey: .side)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(twoWay, forKey: .twoWay)
        try container.encode(twoWayKey, forKey: .twoWayKey)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$updatedAt": updatedAt as Any,
            "array": array as Any,
            "error": error as Any,
            "key": key as Any,
            "onDelete": onDelete as Any,
            "relatedTable": relatedTable as Any,
            "relationType": relationType as Any,
            "required": `required` as Any,
            "side": side as Any,
            "status": status.rawValue as Any,
            "twoWay": twoWay as Any,
            "twoWayKey": twoWayKey as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ColumnRelationship {
        return ColumnRelationship(
            createdAt: map["$createdAt"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            array: map["array"] as? Bool,
            error: map["error"] as! String,
            key: map["key"] as! String,
            onDelete: map["onDelete"] as! String,
            relatedTable: map["relatedTable"] as! String,
            relationType: map["relationType"] as! String,
            required: map["required"] as! Bool,
            side: map["side"] as! String,
            status: ColumnRelationshipStatus(rawValue: map["status"] as! String)!,
            twoWay: map["twoWay"] as! Bool,
            twoWayKey: map["twoWayKey"] as! String,
            type: map["type"] as! String
        )
    }
}
