import Foundation
import JSONCodable

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
        case updated_at = "updated_at"
    }

    /// 
    public let apply_mode: String?
    /// 
    public let created_at: String?
    /// 
    public let direction: String?
    /// 
    public let entity: String?
    /// 
    public let format: String?
    /// 
    public let id: String?
    /// 
    public let is_template: Bool?
    /// 
    public let mapping: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let options: [String: AnyCodable]?
    /// 
    public let updated_at: String?

    init(
        apply_mode: String?,
        created_at: String?,
        direction: String?,
        entity: String?,
        format: String?,
        id: String?,
        is_template: Bool?,
        mapping: [String: AnyCodable]?,
        name: String?,
        options: [String: AnyCodable]?,
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
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.apply_mode = try container.decodeIfPresent(String.self, forKey: .apply_mode)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.direction = try container.decodeIfPresent(String.self, forKey: .direction)
        self.entity = try container.decodeIfPresent(String.self, forKey: .entity)
        self.format = try container.decodeIfPresent(String.self, forKey: .format)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_template = try container.decodeIfPresent(Bool.self, forKey: .is_template)
        self.mapping = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mapping)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(apply_mode, forKey: .apply_mode)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(direction, forKey: .direction)
        try container.encodeIfPresent(entity, forKey: .entity)
        try container.encodeIfPresent(format, forKey: .format)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_template, forKey: .is_template)
        try container.encodeIfPresent(mapping, forKey: .mapping)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "apply_mode": apply_mode as Any,
            "created_at": created_at as Any,
            "direction": direction as Any,
            "entity": entity as Any,
            "format": format as Any,
            "id": id as Any,
            "is_template": is_template as Any,
            "mapping": mapping as Any,
            "name": name as Any,
            "options": options as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> IoProfile {
        return IoProfile(
            apply_mode: map["apply_mode"] as? String,
            created_at: map["created_at"] as? String,
            direction: map["direction"] as? String,
            entity: map["entity"] as? String,
            format: map["format"] as? String,
            id: map["id"] as? String,
            is_template: map["is_template"] as? Bool,
            mapping: map["mapping"] as? [String: AnyCodable],
            name: map["name"] as? String,
            options: map["options"] as? [String: AnyCodable],
            updated_at: map["updated_at"] as? String
        )
    }
}
