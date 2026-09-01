import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — omitted fields keep their current value.
open class IoProfileUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case apply_mode = "apply_mode"
        case direction = "direction"
        case entity = "entity"
        case format = "format"
        case is_template = "is_template"
        case mapping = "mapping"
        case name = "name"
        case options = "options"
    }

    /// What an import does with the lines the target cart already has: 'replace' clears them first, 'insert' and 'append' both add and behave identically today. Read only when the import names a target_cart_id. Default 'insert'.
    public let apply_mode: RevenexxEnums.CartIoApplyMode?
    /// Which way this profile runs. A profile only ever runs in the direction it declares: handing an import profile to carts.export is a 400, and the other way round.
    public let direction: RevenexxEnums.CartIoDirection?
    /// What the profile carries: whole carts (the `{cart, items}` document) or bare cart lines. Default 'carts'.
    public let entity: RevenexxEnums.CartIoEntity?
    /// The wire format. 'json' is the canonical, re-importable document; 'csv' is the spreadsheet form, and only line fields survive it. Default 'json'.
    public let format: RevenexxEnums.CartIoFormat?
    /// One of the bundled templates. Set by carts.io.profiles.defaults; a profile a merchant writes is not one.
    public let is_template: Bool?
    /// Baseline-IO-compatible column mapping. An empty object (or null) is identity: the full canonical shape, every field under its own name.
    public let mapping: CartIoMapping?
    /// What a merchant picks this profile by. Unique within the tenant — reusing a name is a 409.
    public let name: String?
    /// Free-form options carried with the profile. The four bundled templates put one human sentence under `description` and nothing else; no other key is read by this app, so anything a merchant needs alongside a profile can live here.
    public let options: [String: AnyCodable]?

    init(
        apply_mode: RevenexxEnums.CartIoApplyMode?,
        direction: RevenexxEnums.CartIoDirection?,
        entity: RevenexxEnums.CartIoEntity?,
        format: RevenexxEnums.CartIoFormat?,
        is_template: Bool?,
        mapping: CartIoMapping?,
        name: String?,
        options: [String: AnyCodable]?
    ) {
        self.apply_mode = apply_mode
        self.direction = direction
        self.entity = entity
        self.format = format
        self.is_template = is_template
        self.mapping = mapping
        self.name = name
        self.options = options
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let apply_modeString = try container.decodeIfPresent(String.self, forKey: .apply_mode) {
            self.apply_mode = RevenexxEnums.CartIoApplyMode(rawValue: apply_modeString)
        } else {
            self.apply_mode = nil
        }
        if let directionString = try container.decodeIfPresent(String.self, forKey: .direction) {
            self.direction = RevenexxEnums.CartIoDirection(rawValue: directionString)
        } else {
            self.direction = nil
        }
        if let entityString = try container.decodeIfPresent(String.self, forKey: .entity) {
            self.entity = RevenexxEnums.CartIoEntity(rawValue: entityString)
        } else {
            self.entity = nil
        }
        if let formatString = try container.decodeIfPresent(String.self, forKey: .format) {
            self.format = RevenexxEnums.CartIoFormat(rawValue: formatString)
        } else {
            self.format = nil
        }
        self.is_template = try container.decodeIfPresent(Bool.self, forKey: .is_template)
        self.mapping = try container.decodeIfPresent(CartIoMapping.self, forKey: .mapping)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(apply_mode?.rawValue, forKey: .apply_mode)
        try container.encodeIfPresent(direction?.rawValue, forKey: .direction)
        try container.encodeIfPresent(entity?.rawValue, forKey: .entity)
        try container.encodeIfPresent(format?.rawValue, forKey: .format)
        try container.encodeIfPresent(is_template, forKey: .is_template)
        try container.encodeIfPresent(mapping, forKey: .mapping)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
    }

    public func toMap() -> [String: Any] {
        return [
            "apply_mode": apply_mode?.rawValue as Any,
            "direction": direction?.rawValue as Any,
            "entity": entity?.rawValue as Any,
            "format": format?.rawValue as Any,
            "is_template": is_template as Any,
            "mapping": mapping?.toMap() as Any,
            "name": name as Any,
            "options": options as Any
        ]
    }

    public static func from(map: [String: Any] ) -> IoProfileUpdateRequest {
        return IoProfileUpdateRequest(
            apply_mode: map["apply_mode"] as? String != nil ? CartIoApplyMode(rawValue: map["apply_mode"] as! String) : nil,
            direction: map["direction"] as? String != nil ? CartIoDirection(rawValue: map["direction"] as! String) : nil,
            entity: map["entity"] as? String != nil ? CartIoEntity(rawValue: map["entity"] as! String) : nil,
            format: map["format"] as? String != nil ? CartIoFormat(rawValue: map["format"] as! String) : nil,
            is_template: map["is_template"] as? Bool,
            mapping: CartIoMapping.from(map: map["mapping"] as! [String: Any]),
            name: map["name"] as? String,
            options: map["options"] as? [String: AnyCodable]
        )
    }
}
