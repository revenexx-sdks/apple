import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ProductGridColumn: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case label = "label"
        case source = "source"
        case type = "type"
    }

    /// The key to read out of a row: a column name for the fixed columns, an attribute code for the rest (then it is a key of the row's `attributes` object).
    public let code: String?
    /// The attribute's i18n labels, or a plain title for the fixed columns.
    public let label: [String: AnyCodable]?
    /// Where the value comes from: 'column' is a plain products column, 'attribute' a key inside `attribute_values`, 'resolved' something this route computed (the display name).
    public let source: RevenexxEnums.ProductGridColumnSource?
    /// Which control renders the cell — the same widget vocabulary `GET /products/attribute-schema` uses, so one renderer serves both.
    public let type: String?

    init(
        code: String?,
        label: [String: AnyCodable]?,
        source: RevenexxEnums.ProductGridColumnSource?,
        type: String?
    ) {
        self.code = code
        self.label = label
        self.source = source
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.label = try container.decodeIfPresent([String: AnyCodable].self, forKey: .label)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.ProductGridColumnSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
        try container.encodeIfPresent(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "label": label as Any,
            "source": source?.rawValue as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductGridColumn {
        return ProductGridColumn(
            code: map["code"] as? String,
            label: map["label"] as? [String: AnyCodable],
            source: map["source"] as? String != nil ? ProductGridColumnSource(rawValue: map["source"] as! String) : nil,
            type: map["type"] as? String
        )
    }
}
