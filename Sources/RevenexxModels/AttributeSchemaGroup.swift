import Foundation
import JSONCodable

/// 
open class AttributeSchemaGroup: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case label = "label"
        case position = "position"
    }

    /// The group code, which is what every field in the section carries as its `group`.
    public let code: String?
    /// The section heading, resolved for the requested locale.
    public let label: String?
    /// Where the section sits, ascending. The array is already in this order.
    public let position: Int?

    init(
        code: String?,
        label: String?,
        position: Int?
    ) {
        self.code = code
        self.label = label
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "label": label as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeSchemaGroup {
        return AttributeSchemaGroup(
            code: map["code"] as? String,
            label: map["label"] as? String,
            position: map["position"] as? Int
        )
    }
}
