import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class FamiliesUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case image_attribute = "image_attribute"
        case label_attribute = "label_attribute"
        case labels = "labels"
    }

    /// 
    public let code: String?
    /// 
    public let image_attribute: String?
    /// 
    public let label_attribute: String?
    /// 
    public let labels: [String: AnyCodable]?

    init(
        code: String?,
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

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.image_attribute = try container.decodeIfPresent(String.self, forKey: .image_attribute)
        self.label_attribute = try container.decodeIfPresent(String.self, forKey: .label_attribute)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
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

    public static func from(map: [String: Any] ) -> FamiliesUpdateRequest {
        return FamiliesUpdateRequest(
            code: map["code"] as? String,
            image_attribute: map["image_attribute"] as? String,
            label_attribute: map["label_attribute"] as? String,
            labels: map["labels"] as? [String: AnyCodable]
        )
    }
}
