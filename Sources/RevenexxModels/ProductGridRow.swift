import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ProductGridRow: Codable {

    enum CodingKeys: String, CodingKey {
        case attributes = "attributes"
        case completeness = "completeness"
        case enabled = "enabled"
        case family_code = "family_code"
        case family_id = "family_id"
        case id = "id"
        case kind = "kind"
        case label = "label"
        case label_attribute = "label_attribute"
        case label_source = "label_source"
        case sku = "sku"
        case updated_at = "updated_at"
    }

    /// The grid cells: one key per attribute code that `columns` lists with `source: "attribute"`, holding the value already resolved out of `attribute_values` for the requested context. A code the product carries no value for is null rather than absent, so a row is the same shape whatever it holds. The keys are the tenant's own attribute codes, which is why this object has no fixed properties — read `columns` for the set.
    public let attributes: [String: AnyCodable]?
    /// The stored `products.completeness` document, verbatim. Null means it has never been computed — not that the product is empty.
    public let completeness: [String: AnyCodable]?
    /// Whether the product is offered.
    public let enabled: Bool?
    /// That family's code, resolved here so a grid can show and group by it without a second read.
    public let family_code: String?
    /// The product's family. Null is the state that makes completeness impossible.
    public let family_id: String?
    /// The product's id — what a row click navigates with.
    public let id: String?
    /// 'simple', 'model' or 'variant' — a model is a row a person should not price or sell.
    public let kind: String?
    /// The resolved display name. Never empty; read `label_source` before showing it as a name.
    public let label: String?
    /// Which attribute code the name was read from, per this product's family.
    public let label_attribute: String?
    /// Which bucket of attribute_values the name came from. 'sku' means the catalog holds no name for this product — show that as a missing name, not as a name.
    public let label_source: RevenexxEnums.ProductLabelSource?
    /// The merchant's article number.
    public let sku: String?
    /// When the product row was last written — the column a "recently changed" sort uses.
    public let updated_at: String?

    init(
        attributes: [String: AnyCodable]?,
        completeness: [String: AnyCodable]?,
        enabled: Bool?,
        family_code: String?,
        family_id: String?,
        id: String?,
        kind: String?,
        label: String?,
        label_attribute: String?,
        label_source: RevenexxEnums.ProductLabelSource?,
        sku: String?,
        updated_at: String?
    ) {
        self.attributes = attributes
        self.completeness = completeness
        self.enabled = enabled
        self.family_code = family_code
        self.family_id = family_id
        self.id = id
        self.kind = kind
        self.label = label
        self.label_attribute = label_attribute
        self.label_source = label_source
        self.sku = sku
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attributes = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attributes)
        self.completeness = try container.decodeIfPresent([String: AnyCodable].self, forKey: .completeness)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.family_code = try container.decodeIfPresent(String.self, forKey: .family_code)
        self.family_id = try container.decodeIfPresent(String.self, forKey: .family_id)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.label_attribute = try container.decodeIfPresent(String.self, forKey: .label_attribute)
        if let label_sourceString = try container.decodeIfPresent(String.self, forKey: .label_source) {
            self.label_source = RevenexxEnums.ProductLabelSource(rawValue: label_sourceString)
        } else {
            self.label_source = nil
        }
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attributes, forKey: .attributes)
        try container.encodeIfPresent(completeness, forKey: .completeness)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(family_code, forKey: .family_code)
        try container.encodeIfPresent(family_id, forKey: .family_id)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(label_attribute, forKey: .label_attribute)
        try container.encodeIfPresent(label_source?.rawValue, forKey: .label_source)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "attributes": attributes as Any,
            "completeness": completeness as Any,
            "enabled": enabled as Any,
            "family_code": family_code as Any,
            "family_id": family_id as Any,
            "id": id as Any,
            "kind": kind as Any,
            "label": label as Any,
            "label_attribute": label_attribute as Any,
            "label_source": label_source?.rawValue as Any,
            "sku": sku as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductGridRow {
        return ProductGridRow(
            attributes: map["attributes"] as? [String: AnyCodable],
            completeness: map["completeness"] as? [String: AnyCodable],
            enabled: map["enabled"] as? Bool,
            family_code: map["family_code"] as? String,
            family_id: map["family_id"] as? String,
            id: map["id"] as? String,
            kind: map["kind"] as? String,
            label: map["label"] as? String,
            label_attribute: map["label_attribute"] as? String,
            label_source: map["label_source"] as? String != nil ? ProductLabelSource(rawValue: map["label_source"] as! String) : nil,
            sku: map["sku"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
