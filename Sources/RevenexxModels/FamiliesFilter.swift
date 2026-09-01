import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `families` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class FamiliesFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case image_attribute = "image_attribute"
        case label_attribute = "label_attribute"
        case labels = "labels"
        case updated_at = "updated_at"
        case data
    }

    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?image_attribute=` value this call was understood to carry.
    public let image_attribute: String?
    /// The literal `?label_attribute=` value this call was understood to carry.
    public let label_attribute: String?
    /// The literal `?labels=` value this call was understood to carry.
    public let labels: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        code: String?,
        created_at: String?,
        id: String?,
        image_attribute: String?,
        label_attribute: String?,
        labels: String?,
        updated_at: String?,
        data: T
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.image_attribute = image_attribute
        self.label_attribute = label_attribute
        self.labels = labels
        self.updated_at = updated_at
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.image_attribute = try container.decodeIfPresent(String.self, forKey: .image_attribute)
        self.label_attribute = try container.decodeIfPresent(String.self, forKey: .label_attribute)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(image_attribute, forKey: .image_attribute)
        try container.encodeIfPresent(label_attribute, forKey: .label_attribute)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "image_attribute": image_attribute as Any,
            "label_attribute": label_attribute as Any,
            "labels": labels as Any,
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FamiliesFilter {
        return FamiliesFilter(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            image_attribute: map["image_attribute"] as? String,
            label_attribute: map["label_attribute"] as? String,
            labels: map["labels"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
