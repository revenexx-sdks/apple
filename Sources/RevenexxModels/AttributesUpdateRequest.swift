import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class AttributesUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case config = "config"
        case entity_ref = "entity_ref"
        case entity_type = "entity_type"
        case group_id = "group_id"
        case is_filterable = "is_filterable"
        case is_unique = "is_unique"
        case labels = "labels"
        case localizable = "localizable"
        case position = "position"
        case scopable = "scopable"
        case type = "type"
        case usable_in_grid = "usable_in_grid"
        case validation = "validation"
    }

    /// The attribute's stable identifier — the KEY its value is stored under inside `attribute_values`, and the name a category rule addresses as `attribute:<code>`. Unique per (`entity_type`, `entity_ref`) in this tenant.
    public let code: String?
    /// Type-specific settings; which keys apply depends on `type`. The ones this app reads: `units` (the unit list a measure attribute offers) and `reference_entity` (which entity a reference attribute draws its options from). The ones the cockpit edits alongside them: `unit`, `metric_family`, `decimals_allowed`, `asset_family`, `max_file_size`, `allowed_extensions`.
    public let config: [String: AnyCodable]?
    /// Narrows `entity_type` to ONE reference entity or asset family, by its code — the attributes of `brand` rather than of every reference entity. Null for a plain product attribute.
    public let entity_ref: String?
    /// Which kind of record carries this attribute: 'product' for the catalog itself, 'reference_entity', 'asset' or 'category' for the other things in this app that have attributes. Deliberately carries no CHECK — a tenant that models a fifth kind is served on it too.
    public let entity_type: String?
    /// The `attribute_groups` row this attribute is filed under — the form section it appears in. Null is ungrouped, and an ungrouped field is rendered after every section that has a name.
    public let group_id: String?
    /// Offer this attribute as a filter in a product list. `GET /products/grid` reports exactly these attributes in its `filters` array, and nothing else reads the flag.
    public let is_filterable: Bool?
    /// Declares that the value identifies the product — an EAN, a manufacturer part number. It is metadata a form and an importer read: no database index enforces it, because the value lives inside jsonb rather than in a column.
    public let is_unique: Bool?
    /// The field label a person sees, keyed by language tag. Resolution falls back to English and then to the code, so an untranslated attribute is still renderable.
    public let labels: [String: AnyCodable]?
    /// True → the record holds ONE VALUE PER LOCALE, under `attribute_values.locale_specific.<locale>.<code>`. False → one value, under `attribute_values.common.<code>`. This flag is what decides where a write goes.
    public let localizable: Bool?
    /// Where the field sits inside its group. A family may override it for its own form through `family_attributes.position`; this is the attribute's default.
    public let position: Int?
    /// True → one value PER CHANNEL, under `attribute_values.channel_specific.<channel>.<code>`. Set together with `localizable` it means one value per channel AND locale, in `channel_locale_specific`.
    public let scopable: Bool?
    /// Which editor the value asks for — 'text', 'select', 'metric', 'price', 'asset_collection', 'reference_entity'. Carries no CHECK on purpose: an integrator adds a type, and `GET /products/attribute-schema` maps an unknown one onto a text field rather than refusing to answer.
    public let type: String?
    /// Show this attribute as a COLUMN in the product grid. `GET /products/grid` returns a column definition and a per-row value for exactly these.
    public let usable_in_grid: Bool?
    /// Limits a value has to satisfy, as a flat object. The seven keys a client can act on are `min`, `max`, `min_length`, `max_length`, `pattern`, `min_items`, `max_items` — `GET /products/attribute-schema` republishes those and leaves anything else the tenant stored untouched.
    public let validation: [String: AnyCodable]?

    init(
        code: String?,
        config: [String: AnyCodable]?,
        entity_ref: String?,
        entity_type: String?,
        group_id: String?,
        is_filterable: Bool?,
        is_unique: Bool?,
        labels: [String: AnyCodable]?,
        localizable: Bool?,
        position: Int?,
        scopable: Bool?,
        type: String?,
        usable_in_grid: Bool?,
        validation: [String: AnyCodable]?
    ) {
        self.code = code
        self.config = config
        self.entity_ref = entity_ref
        self.entity_type = entity_type
        self.group_id = group_id
        self.is_filterable = is_filterable
        self.is_unique = is_unique
        self.labels = labels
        self.localizable = localizable
        self.position = position
        self.scopable = scopable
        self.type = type
        self.usable_in_grid = usable_in_grid
        self.validation = validation
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.config = try container.decodeIfPresent([String: AnyCodable].self, forKey: .config)
        self.entity_ref = try container.decodeIfPresent(String.self, forKey: .entity_ref)
        self.entity_type = try container.decodeIfPresent(String.self, forKey: .entity_type)
        self.group_id = try container.decodeIfPresent(String.self, forKey: .group_id)
        self.is_filterable = try container.decodeIfPresent(Bool.self, forKey: .is_filterable)
        self.is_unique = try container.decodeIfPresent(Bool.self, forKey: .is_unique)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.localizable = try container.decodeIfPresent(Bool.self, forKey: .localizable)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.scopable = try container.decodeIfPresent(Bool.self, forKey: .scopable)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.usable_in_grid = try container.decodeIfPresent(Bool.self, forKey: .usable_in_grid)
        self.validation = try container.decodeIfPresent([String: AnyCodable].self, forKey: .validation)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(config, forKey: .config)
        try container.encodeIfPresent(entity_ref, forKey: .entity_ref)
        try container.encodeIfPresent(entity_type, forKey: .entity_type)
        try container.encodeIfPresent(group_id, forKey: .group_id)
        try container.encodeIfPresent(is_filterable, forKey: .is_filterable)
        try container.encodeIfPresent(is_unique, forKey: .is_unique)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(localizable, forKey: .localizable)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(scopable, forKey: .scopable)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(usable_in_grid, forKey: .usable_in_grid)
        try container.encodeIfPresent(validation, forKey: .validation)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "config": config as Any,
            "entity_ref": entity_ref as Any,
            "entity_type": entity_type as Any,
            "group_id": group_id as Any,
            "is_filterable": is_filterable as Any,
            "is_unique": is_unique as Any,
            "labels": labels as Any,
            "localizable": localizable as Any,
            "position": position as Any,
            "scopable": scopable as Any,
            "type": type as Any,
            "usable_in_grid": usable_in_grid as Any,
            "validation": validation as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributesUpdateRequest {
        return AttributesUpdateRequest(
            code: map["code"] as? String,
            config: map["config"] as? [String: AnyCodable],
            entity_ref: map["entity_ref"] as? String,
            entity_type: map["entity_type"] as? String,
            group_id: map["group_id"] as? String,
            is_filterable: map["is_filterable"] as? Bool,
            is_unique: map["is_unique"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            localizable: map["localizable"] as? Bool,
            position: map["position"] as? Int,
            scopable: map["scopable"] as? Bool,
            type: map["type"] as? String,
            usable_in_grid: map["usable_in_grid"] as? Bool,
            validation: map["validation"] as? [String: AnyCodable]
        )
    }
}
