import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — omitted fields keep their current value.
open class ProductsUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_values = "attribute_values"
        case completeness = "completeness"
        case deleted_at = "deleted_at"
        case enabled = "enabled"
        case family_id = "family_id"
        case family_variant_id = "family_variant_id"
        case kind = "kind"
        case parent_id = "parent_id"
        case quantified_associations = "quantified_associations"
        case sku = "sku"
        case tax_class = "tax_class"
    }

    /// Every attribute value the record carries, in ONE jsonb document — the core of an attribute-driven PIM. A record's properties are not columns here: they are rows in `attributes`, selected per family by `family_attributes`, and their values live under their attribute CODE inside this object.
    /// 
    /// Four buckets, and an attribute's own flags decide which one it writes to:
    /// 
    ///   `common`                    the attribute is neither localizable nor scopable — one value, full stop.
    ///                               `{"common": {"net_weight": 2.4, "colour": "black"}}`
    ///   `locale_specific`           `localizable`: one value per language tag.
    ///                               `{"locale_specific": {"de_DE": {"name": "Akku-Bohrschrauber"}}}`
    ///   `channel_specific`          `scopable`: one value per channel.
    ///                               `{"channel_specific": {"b2b": {"minimum_order_quantity": 6}}}`
    ///   `channel_locale_specific`   both: one value per channel AND language tag.
    ///                               `{"channel_locale_specific": {"b2b": {"de_DE": {"description": "…"}}}}`
    /// 
    /// A reader takes the most specific bucket that carries the code and falls back through locale, then channel, then `common`. `common` is always last and always consulted, because early imports wrote everything there whatever an attribute's flags said — a reader that skipped it reports an imported catalog as empty. `GET /products/attribute-schema` answers, per field, the exact path a value belongs at (`storage.path`) and that full fallback order (`from`), so no client has to re-derive any of this.
    /// 
    /// The value itself is whatever the attribute's `type` implies: a string, a number, a boolean, an option CODE for a select (never its label), a list of codes for a multi-select, `{"amount": …, "unit": …}` for a measure, a list of `{"amount": …, "currency": …}` for a price, an asset code for media.
    /// 
    /// Defaults to `{}`, and an empty object is a normal state — a record nobody has enriched yet. The declared type also admits an array only because every jsonb column of this app shares one mapping; an array is not meaningful here and every reader in this app treats a non-object as empty.
    public let attribute_values: [String: AnyCodable]?
    /// How much of what this product's family REQUIRES it actually carries — the number a merchandiser works down. `required` counts the attributes the family marks `is_required`, `filled` how many of those carry a value in ANY bucket, `ratio` is filled/required between 0 and 1 (a family that requires nothing is 1, not undefined), `missing` lists the codes with no value anywhere, sorted, and `computed_at` is when it was measured.
    /// 
    /// Written only by `POST /products/{id}/completeness` and by `POST /products/{id}/family`; a plain create or update never touches it, so it is null until one of the two has run. It also stays null for a product with no family — there is nothing to measure it against, and 0 % would be a lie.
    public let completeness: [String: AnyCodable]?
    /// When the product was soft-deleted. `GET /products/grid` and every category-rule evaluation exclude a row that carries one; `GET /products` does NOT — filter on it to read the live catalog.
    public let deleted_at: String?
    /// Whether the product is offered. A create defaults it from the `new_products_enabled_by_default` tenant setting rather than blindly to true, so an import does not publish twenty thousand unfinished products the moment it lands. An explicit value in the body always wins.
    public let enabled: Bool?
    /// The family that decides which attributes this product HAS. Without one nothing is required, completeness cannot be computed and the display name never resolves — `POST /products/{id}/family` is the call that sets it and computes completeness in the same step.
    public let family_id: String?
    /// Which variant structure of the family this product follows — the axes it splits on. Null on a simple product.
    public let family_variant_id: String?
    /// Where the product sits in the variant hierarchy. 'simple' stands on its own. 'model' carries the values its variants share and is never sold itself. 'variant' carries the axis values and points at its model through `parent_id`.
    public let kind: RevenexxEnums.ProductsKind?
    /// The product MODEL this variant belongs to. Only a `variant` carries one. Deleting the model leaves its variants behind with a null parent rather than deleting them.
    public let parent_id: String?
    /// The import-side mirror of associations that carry a quantity — a bundle, a bill of materials, a spare-parts set. NOTHING IN THIS APP READS OR WRITES IT: no route produces it, no route consumes it, and it is null on every product this app has created. The surface that IS served is relational — `product_associations`, whose `quantity` column holds the number, guarded by `association_types.is_quantified`.
    /// 
    /// It exists because a PIM import (Akeneo, BMEcat) carries these in one blob keyed by association type code, and the column lets that document round-trip instead of being dropped. The database enforces no shape on it, so what a reader finds is whatever the importer wrote; the example is the conventional form.
    public let quantified_associations: [String: AnyCodable]?
    /// The merchant's own article number — unique per tenant, and the value every integration (ERP, shop, feed, price list) joins on. The one identifier a person types, and the fallback this app shows when the catalog holds no name.
    public let sku: String?
    /// The tax class key the prices app resolves a VAT rate from. Free text here — the vocabulary belongs to the app that prices, and `POST /products/batch` exists to hand exactly this column to it in bulk.
    public let tax_class: String?

    init(
        attribute_values: [String: AnyCodable]?,
        completeness: [String: AnyCodable]?,
        deleted_at: String?,
        enabled: Bool?,
        family_id: String?,
        family_variant_id: String?,
        kind: RevenexxEnums.ProductsKind?,
        parent_id: String?,
        quantified_associations: [String: AnyCodable]?,
        sku: String?,
        tax_class: String?
    ) {
        self.attribute_values = attribute_values
        self.completeness = completeness
        self.deleted_at = deleted_at
        self.enabled = enabled
        self.family_id = family_id
        self.family_variant_id = family_variant_id
        self.kind = kind
        self.parent_id = parent_id
        self.quantified_associations = quantified_associations
        self.sku = sku
        self.tax_class = tax_class
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attribute_values)
        self.completeness = try container.decodeIfPresent([String: AnyCodable].self, forKey: .completeness)
        self.deleted_at = try container.decodeIfPresent(String.self, forKey: .deleted_at)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.family_id = try container.decodeIfPresent(String.self, forKey: .family_id)
        self.family_variant_id = try container.decodeIfPresent(String.self, forKey: .family_variant_id)
        if let kindString = try container.decodeIfPresent(String.self, forKey: .kind) {
            self.kind = RevenexxEnums.ProductsKind(rawValue: kindString)
        } else {
            self.kind = nil
        }
        self.parent_id = try container.decodeIfPresent(String.self, forKey: .parent_id)
        self.quantified_associations = try container.decodeIfPresent([String: AnyCodable].self, forKey: .quantified_associations)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute_values, forKey: .attribute_values)
        try container.encodeIfPresent(completeness, forKey: .completeness)
        try container.encodeIfPresent(deleted_at, forKey: .deleted_at)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(family_id, forKey: .family_id)
        try container.encodeIfPresent(family_variant_id, forKey: .family_variant_id)
        try container.encodeIfPresent(kind?.rawValue, forKey: .kind)
        try container.encodeIfPresent(parent_id, forKey: .parent_id)
        try container.encodeIfPresent(quantified_associations, forKey: .quantified_associations)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_values": attribute_values as Any,
            "completeness": completeness as Any,
            "deleted_at": deleted_at as Any,
            "enabled": enabled as Any,
            "family_id": family_id as Any,
            "family_variant_id": family_variant_id as Any,
            "kind": kind?.rawValue as Any,
            "parent_id": parent_id as Any,
            "quantified_associations": quantified_associations as Any,
            "sku": sku as Any,
            "tax_class": tax_class as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductsUpdateRequest {
        return ProductsUpdateRequest(
            attribute_values: map["attribute_values"] as? [String: AnyCodable],
            completeness: map["completeness"] as? [String: AnyCodable],
            deleted_at: map["deleted_at"] as? String,
            enabled: map["enabled"] as? Bool,
            family_id: map["family_id"] as? String,
            family_variant_id: map["family_variant_id"] as? String,
            kind: map["kind"] as? String != nil ? ProductsKind(rawValue: map["kind"] as! String) : nil,
            parent_id: map["parent_id"] as? String,
            quantified_associations: map["quantified_associations"] as? [String: AnyCodable],
            sku: map["sku"] as? String,
            tax_class: map["tax_class"] as? String
        )
    }
}
