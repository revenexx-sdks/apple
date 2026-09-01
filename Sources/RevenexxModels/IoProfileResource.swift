import Foundation
import JSONCodable
import RevenexxEnums

/// A saved profile. Mirrors the controller's presenter exactly — there
/// are no `created_at` / `updated_at` fields on this resource.
/// 
open class IoProfileResource: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case apply_mode = "apply_mode"
        case created_by = "created_by"
        case direction = "direction"
        case entity = "entity"
        case format = "format"
        case id = "id"
        case mapping = "mapping"
        case markets = "markets"
        case name = "name"
        case options = "options"
        case vendor = "vendor"
    }

    /// 
    public let app: String?
    /// 
    public let apply_mode: RevenexxEnums.IoProfileResourceApplyMode?
    /// 
    public let created_by: String?
    /// 
    public let direction: RevenexxEnums.IoProfileResourceDirection?
    /// 
    public let entity: String?
    /// 
    public let format: IoProfileFormat?
    /// 
    public let id: String?
    /// 
    public let mapping: [String: AnyCodable]?
    /// `null` means global — offered for every market.
    public let markets: [String]?
    /// 
    public let name: String?
    /// 
    public let options: [String: AnyCodable]?
    /// 
    public let vendor: String?

    init(
        app: String?,
        apply_mode: RevenexxEnums.IoProfileResourceApplyMode?,
        created_by: String?,
        direction: RevenexxEnums.IoProfileResourceDirection?,
        entity: String?,
        format: IoProfileFormat?,
        id: String?,
        mapping: [String: AnyCodable]?,
        markets: [String]?,
        name: String?,
        options: [String: AnyCodable]?,
        vendor: String?
    ) {
        self.app = app
        self.apply_mode = apply_mode
        self.created_by = created_by
        self.direction = direction
        self.entity = entity
        self.format = format
        self.id = id
        self.mapping = mapping
        self.markets = markets
        self.name = name
        self.options = options
        self.vendor = vendor
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        if let apply_modeString = try container.decodeIfPresent(String.self, forKey: .apply_mode) {
            self.apply_mode = RevenexxEnums.IoProfileResourceApplyMode(rawValue: apply_modeString)
        } else {
            self.apply_mode = nil
        }
        self.created_by = try container.decodeIfPresent(String.self, forKey: .created_by)
        if let directionString = try container.decodeIfPresent(String.self, forKey: .direction) {
            self.direction = RevenexxEnums.IoProfileResourceDirection(rawValue: directionString)
        } else {
            self.direction = nil
        }
        self.entity = try container.decodeIfPresent(String.self, forKey: .entity)
        self.format = try container.decodeIfPresent(IoProfileFormat.self, forKey: .format)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.mapping = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mapping)
        self.markets = try container.decodeIfPresent([String].self, forKey: .markets)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.vendor = try container.decodeIfPresent(String.self, forKey: .vendor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(apply_mode?.rawValue, forKey: .apply_mode)
        try container.encodeIfPresent(created_by, forKey: .created_by)
        try container.encodeIfPresent(direction?.rawValue, forKey: .direction)
        try container.encodeIfPresent(entity, forKey: .entity)
        try container.encodeIfPresent(format, forKey: .format)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(mapping, forKey: .mapping)
        try container.encodeIfPresent(markets, forKey: .markets)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(vendor, forKey: .vendor)
    }

    public func toMap() -> [String: Any] {
        return [
            "app": app as Any,
            "apply_mode": apply_mode?.rawValue as Any,
            "created_by": created_by as Any,
            "direction": direction?.rawValue as Any,
            "entity": entity as Any,
            "format": format?.toMap() as Any,
            "id": id as Any,
            "mapping": mapping as Any,
            "markets": markets as Any,
            "name": name as Any,
            "options": options as Any,
            "vendor": vendor as Any
        ]
    }

    public static func from(map: [String: Any] ) -> IoProfileResource {
        return IoProfileResource(
            app: map["app"] as? String,
            apply_mode: map["apply_mode"] as? String != nil ? IoProfileResourceApplyMode(rawValue: map["apply_mode"] as! String) : nil,
            created_by: map["created_by"] as? String,
            direction: map["direction"] as? String != nil ? IoProfileResourceDirection(rawValue: map["direction"] as! String) : nil,
            entity: map["entity"] as? String,
            format: IoProfileFormat.from(map: map["format"] as! [String: Any]),
            id: map["id"] as? String,
            mapping: map["mapping"] as? [String: AnyCodable],
            markets: map["markets"] as? [String],
            name: map["name"] as? String,
            options: map["options"] as? [String: AnyCodable],
            vendor: map["vendor"] as? String
        )
    }
}
