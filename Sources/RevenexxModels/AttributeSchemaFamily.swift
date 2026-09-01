import Foundation
import JSONCodable

/// The family the fields belong to, or null when none was named — then the answer is every attribute of the `entity_type`, which is what a reference entity or an asset family has instead of a family.
open class AttributeSchemaFamily: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case id = "id"
        case label = "label"
        case label_attribute = "label_attribute"
    }

    /// The family's code — the value `?family_code=` takes.
    public let code: String?
    /// The family's id.
    public let id: String?
    /// The family name, resolved for the requested locale.
    public let label: String?
    /// Which of these fields is the product's display name.
    public let label_attribute: String?

    init(
        code: String?,
        id: String?,
        label: String?,
        label_attribute: String?
    ) {
        self.code = code
        self.id = id
        self.label = label
        self.label_attribute = label_attribute
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.label_attribute = try container.decodeIfPresent(String.self, forKey: .label_attribute)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(label_attribute, forKey: .label_attribute)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "id": id as Any,
            "label": label as Any,
            "label_attribute": label_attribute as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeSchemaFamily {
        return AttributeSchemaFamily(
            code: map["code"] as? String,
            id: map["id"] as? String,
            label: map["label"] as? String,
            label_attribute: map["label_attribute"] as? String
        )
    }
}
