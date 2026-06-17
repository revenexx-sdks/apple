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

    /// 
    public let code: String?
    /// 
    public let config: [String: AnyCodable]?
    /// 
    public let entity_ref: String?
    /// 
    public let entity_type: String?
    /// 
    public let group_id: String?
    /// 
    public let is_filterable: Bool?
    /// 
    public let is_unique: Bool?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let localizable: Bool?
    /// 
    public let position: Int?
    /// 
    public let scopable: Bool?
    /// 
    public let type: String?
    /// 
    public let usable_in_grid: Bool?
    /// 
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
