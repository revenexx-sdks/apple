import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// 
open class IoProfileCreateRequest: Codable {

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

    /// Default &#039;insert&#039;.
    public let apply_mode: Revenexx API — revenexxEnums.CartIoApplyMode?
    /// 
    public let direction: Revenexx API — revenexxEnums.CartIoDirection
    /// Default &#039;carts&#039;.
    public let entity: Revenexx API — revenexxEnums.CartIoEntity?
    /// Default &#039;json&#039;.
    public let format: Revenexx API — revenexxEnums.CartIoFormat?
    /// 
    public let is_template: Bool?
    /// Column mapping (Baseline-IO-compatible).
    public let mapping: [String: AnyCodable]?
    /// 
    public let name: String
    /// 
    public let options: [String: AnyCodable]?

    init(
        apply_mode: Revenexx API — revenexxEnums.CartIoApplyMode?,
        direction: Revenexx API — revenexxEnums.CartIoDirection,
        entity: Revenexx API — revenexxEnums.CartIoEntity?,
        format: Revenexx API — revenexxEnums.CartIoFormat?,
        is_template: Bool?,
        mapping: [String: AnyCodable]?,
        name: String,
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
            self.apply_mode = Revenexx API — revenexxEnums.CartIoApplyMode(rawValue: apply_modeString)
        } else {
            self.apply_mode = nil
        }
        self.direction = Revenexx API — revenexxEnums.CartIoDirection(rawValue: try container.decode(String.self, forKey: .direction))!
        if let entityString = try container.decodeIfPresent(String.self, forKey: .entity) {
            self.entity = Revenexx API — revenexxEnums.CartIoEntity(rawValue: entityString)
        } else {
            self.entity = nil
        }
        if let formatString = try container.decodeIfPresent(String.self, forKey: .format) {
            self.format = Revenexx API — revenexxEnums.CartIoFormat(rawValue: formatString)
        } else {
            self.format = nil
        }
        self.is_template = try container.decodeIfPresent(Bool.self, forKey: .is_template)
        self.mapping = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mapping)
        self.name = try container.decode(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(apply_mode?.rawValue, forKey: .apply_mode)
        try container.encode(direction.rawValue, forKey: .direction)
        try container.encodeIfPresent(entity?.rawValue, forKey: .entity)
        try container.encodeIfPresent(format?.rawValue, forKey: .format)
        try container.encodeIfPresent(is_template, forKey: .is_template)
        try container.encodeIfPresent(mapping, forKey: .mapping)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
    }

    public func toMap() -> [String: Any] {
        return [
            "apply_mode": apply_mode?.rawValue as Any,
            "direction": direction.rawValue as Any,
            "entity": entity?.rawValue as Any,
            "format": format?.rawValue as Any,
            "is_template": is_template as Any,
            "mapping": mapping as Any,
            "name": name as Any,
            "options": options as Any
        ]
    }

    public static func from(map: [String: Any] ) -> IoProfileCreateRequest {
        return IoProfileCreateRequest(
            apply_mode: map["apply_mode"] as? String != nil ? CartIoApplyMode(rawValue: map["apply_mode"] as! String) : nil,
            direction: CartIoDirection(rawValue: map["direction"] as! String)!,
            entity: map["entity"] as? String != nil ? CartIoEntity(rawValue: map["entity"] as! String) : nil,
            format: map["format"] as? String != nil ? CartIoFormat(rawValue: map["format"] as! String) : nil,
            is_template: map["is_template"] as? Bool,
            mapping: map["mapping"] as? [String: AnyCodable],
            name: map["name"] as! String,
            options: map["options"] as? [String: AnyCodable]
        )
    }
}
