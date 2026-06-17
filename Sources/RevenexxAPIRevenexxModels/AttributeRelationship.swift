import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// AttributeRelationship
open class AttributeRelationship: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case updatedAt = "$updatedAt"
        case array = "array"
        case error = "error"
        case key = "key"
        case onDelete = "onDelete"
        case relatedCollection = "relatedCollection"
        case relationType = "relationType"
        case `required` = "required"
        case side = "side"
        case status = "status"
        case twoWay = "twoWay"
        case twoWayKey = "twoWayKey"
        case type = "type"
    }

    /// Attribute creation date in ISO 8601 format.
    public let createdAt: String
    /// Attribute update date in ISO 8601 format.
    public let updatedAt: String
    /// Is attribute an array?
    public let array: Bool?
    /// Error message. Displays error generated on failure of creating or deleting an attribute.
    public let error: String
    /// Attribute Key.
    public let key: String
    /// How deleting the parent document will propagate to child documents.
    public let onDelete: String
    /// The ID of the related collection.
    public let relatedCollection: String
    /// The type of the relationship.
    public let relationType: String
    /// Is attribute required?
    public let `required`: Bool
    /// Whether this is the parent or child side of the relationship
    public let side: String
    /// Attribute status. Possible values: `available`, `processing`, `deleting`, `stuck`, or `failed`
    public let status: Revenexx API — revenexxEnums.AttributeRelationshipStatus
    /// Is the relationship two-way?
    public let twoWay: Bool
    /// The key of the two-way relationship.
    public let twoWayKey: String
    /// Attribute type.
    public let type: String

    init(
        createdAt: String,
        updatedAt: String,
        array: Bool?,
        error: String,
        key: String,
        onDelete: String,
        relatedCollection: String,
        relationType: String,
        `required`: Bool,
        side: String,
        status: Revenexx API — revenexxEnums.AttributeRelationshipStatus,
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
        self.relatedCollection = relatedCollection
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
        self.relatedCollection = try container.decode(String.self, forKey: .relatedCollection)
        self.relationType = try container.decode(String.self, forKey: .relationType)
        self.`required` = try container.decode(Bool.self, forKey: .`required`)
        self.side = try container.decode(String.self, forKey: .side)
        self.status = Revenexx API — revenexxEnums.AttributeRelationshipStatus(rawValue: try container.decode(String.self, forKey: .status))!
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
        try container.encode(relatedCollection, forKey: .relatedCollection)
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
            "relatedCollection": relatedCollection as Any,
            "relationType": relationType as Any,
            "required": `required` as Any,
            "side": side as Any,
            "status": status.rawValue as Any,
            "twoWay": twoWay as Any,
            "twoWayKey": twoWayKey as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeRelationship {
        return AttributeRelationship(
            createdAt: map["$createdAt"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            array: map["array"] as? Bool,
            error: map["error"] as! String,
            key: map["key"] as! String,
            onDelete: map["onDelete"] as! String,
            relatedCollection: map["relatedCollection"] as! String,
            relationType: map["relationType"] as! String,
            required: map["required"] as! Bool,
            side: map["side"] as! String,
            status: AttributeRelationshipStatus(rawValue: map["status"] as! String)!,
            twoWay: map["twoWay"] as! Bool,
            twoWayKey: map["twoWayKey"] as! String,
            type: map["type"] as! String
        )
    }
}
