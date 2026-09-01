import Foundation
import JSONCodable

/// 
open class FamiliesCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case image_attribute = "image_attribute"
        case label_attribute = "label_attribute"
        case labels = "labels"
    }

    /// The family's stable identifier — which set of attributes a product of this family HAS. Unique per tenant, and the value `GET /products/attribute-schema?family_code=` resolves.
    public let code: String
    /// Which attribute code carries the product's main image — the one a grid thumbnail and a picker read.
    public let image_attribute: String?
    /// Which attribute CODE carries the display name of a product in this family. A product's name is an attribute, not a column, and which attribute it is, is per family. Null falls back to the `default_label_attribute` setting and then to the conventional `name`.
    public let label_attribute: String?
    /// What the family is called, per language tag — the name an operator picks from, while the code is what everything else joins on.
    public let labels: [String: AnyCodable]?

    init(
        code: String,
        image_attribute: String?,
        label_attribute: String?,
        labels: [String: AnyCodable]?
    ) {
        self.code = code
        self.image_attribute = image_attribute
        self.label_attribute = label_attribute
        self.labels = labels
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.image_attribute = try container.decodeIfPresent(String.self, forKey: .image_attribute)
        self.label_attribute = try container.decodeIfPresent(String.self, forKey: .label_attribute)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(image_attribute, forKey: .image_attribute)
        try container.encodeIfPresent(label_attribute, forKey: .label_attribute)
        try container.encodeIfPresent(labels, forKey: .labels)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "image_attribute": image_attribute as Any,
            "label_attribute": label_attribute as Any,
            "labels": labels as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FamiliesCreateRequest {
        return FamiliesCreateRequest(
            code: map["code"] as! String,
            image_attribute: map["image_attribute"] as? String,
            label_attribute: map["label_attribute"] as? String,
            labels: map["labels"] as? [String: AnyCodable]
        )
    }
}
