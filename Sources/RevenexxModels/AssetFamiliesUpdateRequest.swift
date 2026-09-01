import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class AssetFamiliesUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case labels = "labels"
        case naming_convention = "naming_convention"
    }

    /// The asset family's stable identifier — a class of media with one shared shape. Unique per tenant.
    public let code: String?
    /// What the asset family is called, per language tag.
    public let labels: [String: AnyCodable]?
    /// How a file of this family is named, so an import can bind a file to a product without a mapping table. `source` is the product value the file name is built from, `pattern` how it is assembled, `allowed_extensions` what may be uploaded.
    public let naming_convention: [String: AnyCodable]?

    init(
        code: String?,
        labels: [String: AnyCodable]?,
        naming_convention: [String: AnyCodable]?
    ) {
        self.code = code
        self.labels = labels
        self.naming_convention = naming_convention
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.naming_convention = try container.decodeIfPresent([String: AnyCodable].self, forKey: .naming_convention)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(naming_convention, forKey: .naming_convention)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "labels": labels as Any,
            "naming_convention": naming_convention as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AssetFamiliesUpdateRequest {
        return AssetFamiliesUpdateRequest(
            code: map["code"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            naming_convention: map["naming_convention"] as? [String: AnyCodable]
        )
    }
}
