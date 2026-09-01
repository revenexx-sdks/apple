import Foundation
import JSONCodable

/// One renderable field. A superset of the manifest's `Field`: the three additions (`localized`, `channel_scoped`, `storage`) carry what a static manifest never has to say, because a manifest's fields are columns and these are keys inside one.
open class AttributeField: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_scoped = "channel_scoped"
        case from = "from"
        case group = "group"
        case group_label = "group_label"
        case label = "label"
        case localized = "localized"
        case name = "name"
        case options = "options"
        case position = "position"
        case readonly = "readonly"
        case readonly_reason = "readonly_reason"
        case reference_entity = "reference_entity"
        case `required` = "required"
        case storage = "storage"
        case type = "type"
        case unique = "unique"
        case units = "units"
        case validation = "validation"
    }

    /// One value per channel rather than one value.
    public let channel_scoped: Bool?
    /// Dotted read paths, most specific first — the documented precedence (channel+locale → locale → channel → common). `common` is always last and always present, because early imports wrote there whatever the attribute's flags say.
    public let from: [String]?
    /// Attribute-group code — the section this field belongs in.
    public let group: String?
    /// That section's heading, resolved for the requested locale — so a form can be built without reading `attribute_groups` as well.
    public let group_label: String?
    /// Resolved for the requested locale, falling back to English, then to the code.
    public let label: String?
    /// One value per locale rather than one value.
    public let localized: Bool?
    /// The attribute code — the key the value is stored under.
    public let name: String?
    /// Present on select / multi-select. Two sources, one shape: rows of `attribute_options` for an enumeration the attribute owns, or the records of a reference entity for an attribute that points at one. Empty is an answer: the list has no members yet.
    public let options: [AttributeFieldOption]?
    /// The family's ordering of this attribute, falling back to the attribute's own.
    public let position: Int?
    /// The field must not be edited in this context. Today the one cause is a variant axis on a product model; `readonly_reason` says which.
    public let readonly: Bool?
    /// Why the field is locked — a variant axis on a product model is set on its variants.
    public let readonly_reason: String?
    /// Present when the options ARE a reference entity's records: the code of that entity, so a client can offer to manage the values rather than only pick from them.
    public let reference_entity: String?
    /// The family's `is_required`, narrowed to the requested channel when `required_channels` names any.
    public let `required`: Bool?
    /// Where the value lives. Absent on an app whose custom fields are plain columns — then the field name IS the column.
    public let storage: AttributeFieldStorage?
    /// The control to draw. Mapped from `attributes.type`, which carries no CHECK on purpose — an unknown type answers 'text' rather than nothing.
    public let type: String?
    /// The attribute's `is_unique` — the value is meant to identify the product. Advisory: no index enforces it, so a client that cares has to check.
    public let unique: Bool?
    /// Offered units of a `measure` field, from the attribute's `config.units`.
    public let units: [String]?
    /// The limits the value has to satisfy, ready to hand to a form validator. Only the seven keys below are republished; anything else the tenant stored in `attributes.validation` stays there.
    public let validation: AttributeFieldValidation?

    init(
        channel_scoped: Bool?,
        from: [String]?,
        group: String?,
        group_label: String?,
        label: String?,
        localized: Bool?,
        name: String?,
        options: [AttributeFieldOption]?,
        position: Int?,
        readonly: Bool?,
        readonly_reason: String?,
        reference_entity: String?,
        `required`: Bool?,
        storage: AttributeFieldStorage?,
        type: String?,
        unique: Bool?,
        units: [String]?,
        validation: AttributeFieldValidation?
    ) {
        self.channel_scoped = channel_scoped
        self.from = from
        self.group = group
        self.group_label = group_label
        self.label = label
        self.localized = localized
        self.name = name
        self.options = options
        self.position = position
        self.readonly = readonly
        self.readonly_reason = readonly_reason
        self.reference_entity = reference_entity
        self.`required` = `required`
        self.storage = storage
        self.type = type
        self.unique = unique
        self.units = units
        self.validation = validation
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel_scoped = try container.decodeIfPresent(Bool.self, forKey: .channel_scoped)
        self.from = try container.decodeIfPresent([String].self, forKey: .from)
        self.group = try container.decodeIfPresent(String.self, forKey: .group)
        self.group_label = try container.decodeIfPresent(String.self, forKey: .group_label)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.localized = try container.decodeIfPresent(Bool.self, forKey: .localized)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([AttributeFieldOption].self, forKey: .options)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.readonly = try container.decodeIfPresent(Bool.self, forKey: .readonly)
        self.readonly_reason = try container.decodeIfPresent(String.self, forKey: .readonly_reason)
        self.reference_entity = try container.decodeIfPresent(String.self, forKey: .reference_entity)
        self.`required` = try container.decodeIfPresent(Bool.self, forKey: .`required`)
        self.storage = try container.decodeIfPresent(AttributeFieldStorage.self, forKey: .storage)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.unique = try container.decodeIfPresent(Bool.self, forKey: .unique)
        self.units = try container.decodeIfPresent([String].self, forKey: .units)
        self.validation = try container.decodeIfPresent(AttributeFieldValidation.self, forKey: .validation)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel_scoped, forKey: .channel_scoped)
        try container.encodeIfPresent(from, forKey: .from)
        try container.encodeIfPresent(group, forKey: .group)
        try container.encodeIfPresent(group_label, forKey: .group_label)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(localized, forKey: .localized)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(readonly, forKey: .readonly)
        try container.encodeIfPresent(readonly_reason, forKey: .readonly_reason)
        try container.encodeIfPresent(reference_entity, forKey: .reference_entity)
        try container.encodeIfPresent(`required`, forKey: .`required`)
        try container.encodeIfPresent(storage, forKey: .storage)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(unique, forKey: .unique)
        try container.encodeIfPresent(units, forKey: .units)
        try container.encodeIfPresent(validation, forKey: .validation)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel_scoped": channel_scoped as Any,
            "from": from as Any,
            "group": group as Any,
            "group_label": group_label as Any,
            "label": label as Any,
            "localized": localized as Any,
            "name": name as Any,
            "options": options?.map { $0.toMap() } as Any,
            "position": position as Any,
            "readonly": readonly as Any,
            "readonly_reason": readonly_reason as Any,
            "reference_entity": reference_entity as Any,
            "required": `required` as Any,
            "storage": storage?.toMap() as Any,
            "type": type as Any,
            "unique": unique as Any,
            "units": units as Any,
            "validation": validation?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeField {
        return AttributeField(
            channel_scoped: map["channel_scoped"] as? Bool,
            from: map["from"] as? [String],
            group: map["group"] as? String,
            group_label: map["group_label"] as? String,
            label: map["label"] as? String,
            localized: map["localized"] as? Bool,
            name: map["name"] as? String,
            options: (map["options"] as? [[String: Any]] ?? []).map { AttributeFieldOption.from(map: $0) },
            position: map["position"] as? Int,
            readonly: map["readonly"] as? Bool,
            readonly_reason: map["readonly_reason"] as? String,
            reference_entity: map["reference_entity"] as? String,
            required: map["required"] as? Bool,
            storage: AttributeFieldStorage.from(map: map["storage"] as! [String: Any]),
            type: map["type"] as? String,
            unique: map["unique"] as? Bool,
            units: map["units"] as? [String],
            validation: AttributeFieldValidation.from(map: map["validation"] as! [String: Any])
        )
    }
}
