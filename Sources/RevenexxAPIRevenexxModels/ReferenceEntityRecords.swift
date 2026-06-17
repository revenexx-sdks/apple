import Foundation
import JSONCodable

/// 
open class ReferenceEntityRecords: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_values = "attribute_values"
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case labels = "labels"
        case reference_entity_id = "reference_entity_id"
        case updated_at = "updated_at"
    }

    /// 
    public let attribute_values: [String: AnyCodable]?
    /// 
    public let code: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let reference_entity_id: String?
    /// 
    public let updated_at: String?

    init(
        attribute_values: [String: AnyCodable]?,
        code: String?,
        created_at: String?,
        id: String?,
        labels: [String: AnyCodable]?,
        reference_entity_id: String?,
        updated_at: String?
    ) {
        self.attribute_values = attribute_values
        self.code = code
        self.created_at = created_at
        self.id = id
        self.labels = labels
        self.reference_entity_id = reference_entity_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attribute_values)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.reference_entity_id = try container.decodeIfPresent(String.self, forKey: .reference_entity_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute_values, forKey: .attribute_values)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(reference_entity_id, forKey: .reference_entity_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_values": attribute_values as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "labels": labels as Any,
            "reference_entity_id": reference_entity_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReferenceEntityRecords {
        return ReferenceEntityRecords(
            attribute_values: map["attribute_values"] as? [String: AnyCodable],
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            reference_entity_id: map["reference_entity_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
