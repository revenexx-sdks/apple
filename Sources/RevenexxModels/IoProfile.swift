import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class IoProfile: Codable {

    enum CodingKeys: String, CodingKey {
        case apply_mode = "apply_mode"
        case created_at = "created_at"
        case direction = "direction"
        case entity = "entity"
        case format = "format"
        case id = "id"
        case is_template = "is_template"
        case mapping = "mapping"
        case name = "name"
        case options = "options"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// What an import does with the lines the target cart already has. 'replace' clears them first; 'insert' and 'append' both add, and behave identically today. Read only by carts.import, and only when the call names a target_cart_id — an import that creates its own cart has nothing to apply a mode to.
    public let apply_mode: RevenexxEnums.CartIoApplyMode?
    /// When the profile was created — for the bundled templates, when the app was installed.
    public let created_at: String?
    /// Which way this profile runs. A profile only ever runs in the direction it declares: handing an import profile to carts.export is a 400, and the other way round.
    public let direction: RevenexxEnums.CartIoDirection?
    /// What the profile carries: whole carts ('carts' — the `{cart, items}` document) or bare cart lines ('cart_items' — the spreadsheet a buyer quick-orders from).
    public let entity: RevenexxEnums.CartIoEntity?
    /// The wire format. 'json' is the canonical, re-importable document; 'csv' is the spreadsheet form, and only line fields survive it.
    public let format: RevenexxEnums.CartIoFormat?
    /// The profile, as carts.export and carts.import name it in `profile_id`.
    public let id: String?
    /// One of the profiles this app ships with, seeded by carts.io.profiles.defaults. A profile a merchant wrote is not one, so this is how a UI separates "what came with the app" from "what we built".
    public let is_template: Bool?
    /// Baseline-IO-compatible column mapping. An empty object (or null) is identity: the full canonical shape, every field under its own name.
    public let mapping: CartIoMapping?
    /// What a merchant picks this profile by. Unique within the tenant — reusing a name is a 409 — and the four bundled templates use it as their identity, so seeding is idempotent by name.
    public let name: String?
    /// Free-form options carried with the profile. The four bundled templates put one human sentence under `description` and nothing else; no other key is read by this app, so anything a merchant needs alongside a profile can live here.
    public let options: [String: AnyCodable]?
    /// The tenant this row belongs to, echoed by the data plane.
    public let tenant_id: String?
    /// When the profile last changed.
    public let updated_at: String?

    init(
        apply_mode: RevenexxEnums.CartIoApplyMode?,
        created_at: String?,
        direction: RevenexxEnums.CartIoDirection?,
        entity: RevenexxEnums.CartIoEntity?,
        format: RevenexxEnums.CartIoFormat?,
        id: String?,
        is_template: Bool?,
        mapping: CartIoMapping?,
        name: String?,
        options: [String: AnyCodable]?,
        tenant_id: String?,
        updated_at: String?
    ) {
        self.apply_mode = apply_mode
        self.created_at = created_at
        self.direction = direction
        self.entity = entity
        self.format = format
        self.id = id
        self.is_template = is_template
        self.mapping = mapping
        self.name = name
        self.options = options
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let apply_modeString = try container.decodeIfPresent(String.self, forKey: .apply_mode) {
            self.apply_mode = RevenexxEnums.CartIoApplyMode(rawValue: apply_modeString)
        } else {
            self.apply_mode = nil
        }
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
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
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_template = try container.decodeIfPresent(Bool.self, forKey: .is_template)
        self.mapping = try container.decodeIfPresent(CartIoMapping.self, forKey: .mapping)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(apply_mode?.rawValue, forKey: .apply_mode)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(direction?.rawValue, forKey: .direction)
        try container.encodeIfPresent(entity?.rawValue, forKey: .entity)
        try container.encodeIfPresent(format?.rawValue, forKey: .format)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_template, forKey: .is_template)
        try container.encodeIfPresent(mapping, forKey: .mapping)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "apply_mode": apply_mode?.rawValue as Any,
            "created_at": created_at as Any,
            "direction": direction?.rawValue as Any,
            "entity": entity?.rawValue as Any,
            "format": format?.rawValue as Any,
            "id": id as Any,
            "is_template": is_template as Any,
            "mapping": mapping?.toMap() as Any,
            "name": name as Any,
            "options": options as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> IoProfile {
        return IoProfile(
            apply_mode: map["apply_mode"] as? String != nil ? CartIoApplyMode(rawValue: map["apply_mode"] as! String) : nil,
            created_at: map["created_at"] as? String,
            direction: map["direction"] as? String != nil ? CartIoDirection(rawValue: map["direction"] as! String) : nil,
            entity: map["entity"] as? String != nil ? CartIoEntity(rawValue: map["entity"] as! String) : nil,
            format: map["format"] as? String != nil ? CartIoFormat(rawValue: map["format"] as! String) : nil,
            id: map["id"] as? String,
            is_template: map["is_template"] as? Bool,
            mapping: CartIoMapping.from(map: map["mapping"] as! [String: Any]),
            name: map["name"] as? String,
            options: map["options"] as? [String: AnyCodable],
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
