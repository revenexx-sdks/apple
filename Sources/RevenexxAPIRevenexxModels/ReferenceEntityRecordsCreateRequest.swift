import Foundation
import JSONCodable

/// 
open class ReferenceEntityRecordsCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_values = "attribute_values"
        case code = "code"
        case labels = "labels"
        case reference_entity_id = "reference_entity_id"
    }

    /// 
    public let attribute_values: [String: AnyCodable]?
    /// 
    public let code: String
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let reference_entity_id: String

    init(
        attribute_values: [String: AnyCodable]?,
        code: String,
        labels: [String: AnyCodable]?,
        reference_entity_id: String
    ) {
        self.attribute_values = attribute_values
        self.code = code
        self.labels = labels
        self.reference_entity_id = reference_entity_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attribute_values)
        self.code = try container.decode(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.reference_entity_id = try container.decode(String.self, forKey: .reference_entity_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute_values, forKey: .attribute_values)
        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encode(reference_entity_id, forKey: .reference_entity_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_values": attribute_values as Any,
            "code": code as Any,
            "labels": labels as Any,
            "reference_entity_id": reference_entity_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReferenceEntityRecordsCreateRequest {
        return ReferenceEntityRecordsCreateRequest(
            attribute_values: map["attribute_values"] as? [String: AnyCodable],
            code: map["code"] as! String,
            labels: map["labels"] as? [String: AnyCodable],
            reference_entity_id: map["reference_entity_id"] as! String
        )
    }
}
