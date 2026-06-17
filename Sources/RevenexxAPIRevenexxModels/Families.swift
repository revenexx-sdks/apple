import Foundation
import JSONCodable

/// 
open class Families: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case image_attribute = "image_attribute"
        case label_attribute = "label_attribute"
        case labels = "labels"
        case updated_at = "updated_at"
    }

    /// 
    public let code: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let image_attribute: String?
    /// 
    public let label_attribute: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        id: String?,
        image_attribute: String?,
        label_attribute: String?,
        labels: [String: AnyCodable]?,
        updated_at: String?
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.image_attribute = image_attribute
        self.label_attribute = label_attribute
        self.labels = labels
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.image_attribute = try container.decodeIfPresent(String.self, forKey: .image_attribute)
        self.label_attribute = try container.decodeIfPresent(String.self, forKey: .label_attribute)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
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
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "image_attribute": image_attribute as Any,
            "label_attribute": label_attribute as Any,
            "labels": labels as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Families {
        return Families(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            image_attribute: map["image_attribute"] as? String,
            label_attribute: map["label_attribute"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            updated_at: map["updated_at"] as? String
        )
    }
}
