import Foundation
import JSONCodable

/// 
open class ProductGridFilter: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case label = "label"
        case type = "type"
    }

    /// The attribute code to filter on.
    public let code: String?
    /// The attribute's i18n labels, for the filter's own caption.
    public let label: [String: AnyCodable]?
    /// Which control the filter asks for — the same widget vocabulary the columns use.
    public let type: String?

    init(
        code: String?,
        label: [String: AnyCodable]?,
        type: String?
    ) {
        self.code = code
        self.label = label
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.label = try container.decodeIfPresent([String: AnyCodable].self, forKey: .label)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "label": label as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductGridFilter {
        return ProductGridFilter(
            code: map["code"] as? String,
            label: map["label"] as? [String: AnyCodable],
            type: map["type"] as? String
        )
    }
}
