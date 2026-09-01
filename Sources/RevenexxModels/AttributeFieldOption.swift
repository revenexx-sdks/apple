import Foundation
import JSONCodable

/// 
open class AttributeFieldOption: Codable {

    enum CodingKeys: String, CodingKey {
        case label = "label"
        case swatch = "swatch"
        case value = "value"
    }

    /// What to show in the picker, already resolved for the requested locale.
    public let label: String?
    /// Colour/texture chip, when the option carries one — `{"hex": "#c0c0c0"}`.
    public let swatch: [String: AnyCodable]?
    /// The stored value — an `attribute_options.code`, or a `reference_entity_records.code` when the options ARE a reference entity. This, never the label, is what goes into `attribute_values`.
    public let value: String?

    init(
        label: String?,
        swatch: [String: AnyCodable]?,
        value: String?
    ) {
        self.label = label
        self.swatch = swatch
        self.value = value
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.swatch = try container.decodeIfPresent([String: AnyCodable].self, forKey: .swatch)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(swatch, forKey: .swatch)
        try container.encodeIfPresent(value, forKey: .value)
    }

    public func toMap() -> [String: Any] {
        return [
            "label": label as Any,
            "swatch": swatch as Any,
            "value": value as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeFieldOption {
        return AttributeFieldOption(
            label: map["label"] as? String,
            swatch: map["swatch"] as? [String: AnyCodable],
            value: map["value"] as? String
        )
    }
}
