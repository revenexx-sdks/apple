import Foundation
import JSONCodable

/// 
open class Products: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_values = "attribute_values"
        case completeness = "completeness"
        case created_at = "created_at"
        case deleted_at = "deleted_at"
        case enabled = "enabled"
        case family_id = "family_id"
        case family_variant_id = "family_variant_id"
        case id = "id"
        case kind = "kind"
        case parent_id = "parent_id"
        case quantified_associations = "quantified_associations"
        case sku = "sku"
        case tax_class = "tax_class"
        case updated_at = "updated_at"
    }

    /// 
    public let attribute_values: [String: AnyCodable]?
    /// 
    public let completeness: [String: AnyCodable]?
    /// 
    public let created_at: String?
    /// 
    public let deleted_at: String?
    /// 
    public let enabled: Bool?
    /// 
    public let family_id: String?
    /// 
    public let family_variant_id: String?
    /// 
    public let id: String?
    /// 
    public let kind: String?
    /// 
    public let parent_id: String?
    /// 
    public let quantified_associations: [String: AnyCodable]?
    /// 
    public let sku: String?
    /// 
    public let tax_class: String?
    /// 
    public let updated_at: String?

    init(
        attribute_values: [String: AnyCodable]?,
        completeness: [String: AnyCodable]?,
        created_at: String?,
        deleted_at: String?,
        enabled: Bool?,
        family_id: String?,
        family_variant_id: String?,
        id: String?,
        kind: String?,
        parent_id: String?,
        quantified_associations: [String: AnyCodable]?,
        sku: String?,
        tax_class: String?,
        updated_at: String?
    ) {
        self.attribute_values = attribute_values
        self.completeness = completeness
        self.created_at = created_at
        self.deleted_at = deleted_at
        self.enabled = enabled
        self.family_id = family_id
        self.family_variant_id = family_variant_id
        self.id = id
        self.kind = kind
        self.parent_id = parent_id
        self.quantified_associations = quantified_associations
        self.sku = sku
        self.tax_class = tax_class
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attribute_values)
        self.completeness = try container.decodeIfPresent([String: AnyCodable].self, forKey: .completeness)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.deleted_at = try container.decodeIfPresent(String.self, forKey: .deleted_at)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.family_id = try container.decodeIfPresent(String.self, forKey: .family_id)
        self.family_variant_id = try container.decodeIfPresent(String.self, forKey: .family_variant_id)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.parent_id = try container.decodeIfPresent(String.self, forKey: .parent_id)
        self.quantified_associations = try container.decodeIfPresent([String: AnyCodable].self, forKey: .quantified_associations)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute_values, forKey: .attribute_values)
        try container.encodeIfPresent(completeness, forKey: .completeness)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(deleted_at, forKey: .deleted_at)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(family_id, forKey: .family_id)
        try container.encodeIfPresent(family_variant_id, forKey: .family_variant_id)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(parent_id, forKey: .parent_id)
        try container.encodeIfPresent(quantified_associations, forKey: .quantified_associations)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_values": attribute_values as Any,
            "completeness": completeness as Any,
            "created_at": created_at as Any,
            "deleted_at": deleted_at as Any,
            "enabled": enabled as Any,
            "family_id": family_id as Any,
            "family_variant_id": family_variant_id as Any,
            "id": id as Any,
            "kind": kind as Any,
            "parent_id": parent_id as Any,
            "quantified_associations": quantified_associations as Any,
            "sku": sku as Any,
            "tax_class": tax_class as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Products {
        return Products(
            attribute_values: map["attribute_values"] as? [String: AnyCodable],
            completeness: map["completeness"] as? [String: AnyCodable],
            created_at: map["created_at"] as? String,
            deleted_at: map["deleted_at"] as? String,
            enabled: map["enabled"] as? Bool,
            family_id: map["family_id"] as? String,
            family_variant_id: map["family_variant_id"] as? String,
            id: map["id"] as? String,
            kind: map["kind"] as? String,
            parent_id: map["parent_id"] as? String,
            quantified_associations: map["quantified_associations"] as? [String: AnyCodable],
            sku: map["sku"] as? String,
            tax_class: map["tax_class"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
