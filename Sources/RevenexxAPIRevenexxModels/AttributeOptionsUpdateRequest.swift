import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class AttributeOptionsUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_id = "attribute_id"
        case code = "code"
        case labels = "labels"
        case position = "position"
        case swatch = "swatch"
    }

    /// 
    public let attribute_id: String?
    /// 
    public let code: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let position: Int?
    /// 
    public let swatch: [String: AnyCodable]?

    init(
        attribute_id: String?,
        code: String?,
        labels: [String: AnyCodable]?,
        position: Int?,
        swatch: [String: AnyCodable]?
    ) {
        self.attribute_id = attribute_id
        self.code = code
        self.labels = labels
        self.position = position
        self.swatch = swatch
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_id = try container.decodeIfPresent(String.self, forKey: .attribute_id)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.swatch = try container.decodeIfPresent([String: AnyCodable].self, forKey: .swatch)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute_id, forKey: .attribute_id)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(swatch, forKey: .swatch)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_id": attribute_id as Any,
            "code": code as Any,
            "labels": labels as Any,
            "position": position as Any,
            "swatch": swatch as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeOptionsUpdateRequest {
        return AttributeOptionsUpdateRequest(
            attribute_id: map["attribute_id"] as? String,
            code: map["code"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            swatch: map["swatch"] as? [String: AnyCodable]
        )
    }
}
