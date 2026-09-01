import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `reference_entity_records` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class ReferenceEntityRecordsFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_values = "attribute_values"
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case labels = "labels"
        case reference_entity_id = "reference_entity_id"
        case updated_at = "updated_at"
        case data
    }

    /// The literal `?attribute_values=` value this call was understood to carry.
    public let attribute_values: String?
    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?labels=` value this call was understood to carry.
    public let labels: String?
    /// The literal `?reference_entity_id=` value this call was understood to carry.
    public let reference_entity_id: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        attribute_values: String?,
        code: String?,
        created_at: String?,
        id: String?,
        labels: String?,
        reference_entity_id: String?,
        updated_at: String?,
        data: T
    ) {
        self.attribute_values = attribute_values
        self.code = code
        self.created_at = created_at
        self.id = id
        self.labels = labels
        self.reference_entity_id = reference_entity_id
        self.updated_at = updated_at
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_values = try container.decodeIfPresent(String.self, forKey: .attribute_values)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.reference_entity_id = try container.decodeIfPresent(String.self, forKey: .reference_entity_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
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
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_values": attribute_values as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "labels": labels as Any,
            "reference_entity_id": reference_entity_id as Any,
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> ReferenceEntityRecordsFilter {
        return ReferenceEntityRecordsFilter(
            attribute_values: map["attribute_values"] as? String,
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? String,
            reference_entity_id: map["reference_entity_id"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
