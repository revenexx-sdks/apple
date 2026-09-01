import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ProductLabel: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute = "attribute"
        case attribute_from = "attribute_from"
        case id = "id"
        case label = "label"
        case locale = "locale"
        case sku = "sku"
        case source = "source"
    }

    /// The attribute code the name was read from.
    public let attribute: String?
    /// How that attribute was chosen: 'family' is the product's own `families.label_attribute`, 'setting' the tenant's `default_label_attribute`, 'convention' the built-in fallback to `name` when neither says anything.
    public let attribute_from: RevenexxEnums.ProductLabelAttributeSource?
    /// The product's id.
    public let id: String?
    /// The name to show. Never empty — read `source` before treating it as a name, because `sku` there means this is the SKU standing in for one.
    public let label: String?
    /// Which locale the value came out of, when it came from a locale bucket. Null for a value in `common` and for the SKU fallback.
    public let locale: String?
    /// The SKU, which is also the fallback shown as `label` when the catalog holds no name.
    public let sku: String?
    /// Which bucket of attribute_values the name came from. 'sku' means the catalog holds no name for this product — show that as a missing name, not as a name.
    public let source: RevenexxEnums.ProductLabelSource?

    init(
        attribute: String?,
        attribute_from: RevenexxEnums.ProductLabelAttributeSource?,
        id: String?,
        label: String?,
        locale: String?,
        sku: String?,
        source: RevenexxEnums.ProductLabelSource?
    ) {
        self.attribute = attribute
        self.attribute_from = attribute_from
        self.id = id
        self.label = label
        self.locale = locale
        self.sku = sku
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute = try container.decodeIfPresent(String.self, forKey: .attribute)
        if let attribute_fromString = try container.decodeIfPresent(String.self, forKey: .attribute_from) {
            self.attribute_from = RevenexxEnums.ProductLabelAttributeSource(rawValue: attribute_fromString)
        } else {
            self.attribute_from = nil
        }
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.ProductLabelSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute, forKey: .attribute)
        try container.encodeIfPresent(attribute_from?.rawValue, forKey: .attribute_from)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(locale, forKey: .locale)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute": attribute as Any,
            "attribute_from": attribute_from?.rawValue as Any,
            "id": id as Any,
            "label": label as Any,
            "locale": locale as Any,
            "sku": sku as Any,
            "source": source?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductLabel {
        return ProductLabel(
            attribute: map["attribute"] as? String,
            attribute_from: map["attribute_from"] as? String != nil ? ProductLabelAttributeSource(rawValue: map["attribute_from"] as! String) : nil,
            id: map["id"] as? String,
            label: map["label"] as? String,
            locale: map["locale"] as? String,
            sku: map["sku"] as? String,
            source: map["source"] as? String != nil ? ProductLabelSource(rawValue: map["source"] as! String) : nil
        )
    }
}
