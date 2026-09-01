import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `attributes` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class AttributesFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case config = "config"
        case created_at = "created_at"
        case entity_ref = "entity_ref"
        case entity_type = "entity_type"
        case group_id = "group_id"
        case id = "id"
        case is_filterable = "is_filterable"
        case is_unique = "is_unique"
        case labels = "labels"
        case localizable = "localizable"
        case position = "position"
        case scopable = "scopable"
        case type = "type"
        case updated_at = "updated_at"
        case usable_in_grid = "usable_in_grid"
        case validation = "validation"
        case data
    }

    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?config=` value this call was understood to carry.
    public let config: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?entity_ref=` value this call was understood to carry.
    public let entity_ref: String?
    /// The literal `?entity_type=` value this call was understood to carry.
    public let entity_type: String?
    /// The literal `?group_id=` value this call was understood to carry.
    public let group_id: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?is_filterable=` value this call was understood to carry.
    public let is_filterable: String?
    /// The literal `?is_unique=` value this call was understood to carry.
    public let is_unique: String?
    /// The literal `?labels=` value this call was understood to carry.
    public let labels: String?
    /// The literal `?localizable=` value this call was understood to carry.
    public let localizable: String?
    /// The literal `?position=` value this call was understood to carry.
    public let position: String?
    /// The literal `?scopable=` value this call was understood to carry.
    public let scopable: String?
    /// The literal `?type=` value this call was understood to carry.
    public let type: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// The literal `?usable_in_grid=` value this call was understood to carry.
    public let usable_in_grid: String?
    /// The literal `?validation=` value this call was understood to carry.
    public let validation: String?
    /// Additional properties
    public let data: T

    init(
        code: String?,
        config: String?,
        created_at: String?,
        entity_ref: String?,
        entity_type: String?,
        group_id: String?,
        id: String?,
        is_filterable: String?,
        is_unique: String?,
        labels: String?,
        localizable: String?,
        position: String?,
        scopable: String?,
        type: String?,
        updated_at: String?,
        usable_in_grid: String?,
        validation: String?,
        data: T
    ) {
        self.code = code
        self.config = config
        self.created_at = created_at
        self.entity_ref = entity_ref
        self.entity_type = entity_type
        self.group_id = group_id
        self.id = id
        self.is_filterable = is_filterable
        self.is_unique = is_unique
        self.labels = labels
        self.localizable = localizable
        self.position = position
        self.scopable = scopable
        self.type = type
        self.updated_at = updated_at
        self.usable_in_grid = usable_in_grid
        self.validation = validation
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.config = try container.decodeIfPresent(String.self, forKey: .config)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.entity_ref = try container.decodeIfPresent(String.self, forKey: .entity_ref)
        self.entity_type = try container.decodeIfPresent(String.self, forKey: .entity_type)
        self.group_id = try container.decodeIfPresent(String.self, forKey: .group_id)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_filterable = try container.decodeIfPresent(String.self, forKey: .is_filterable)
        self.is_unique = try container.decodeIfPresent(String.self, forKey: .is_unique)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.localizable = try container.decodeIfPresent(String.self, forKey: .localizable)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.scopable = try container.decodeIfPresent(String.self, forKey: .scopable)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.usable_in_grid = try container.decodeIfPresent(String.self, forKey: .usable_in_grid)
        self.validation = try container.decodeIfPresent(String.self, forKey: .validation)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(config, forKey: .config)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(entity_ref, forKey: .entity_ref)
        try container.encodeIfPresent(entity_type, forKey: .entity_type)
        try container.encodeIfPresent(group_id, forKey: .group_id)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_filterable, forKey: .is_filterable)
        try container.encodeIfPresent(is_unique, forKey: .is_unique)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(localizable, forKey: .localizable)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(scopable, forKey: .scopable)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(usable_in_grid, forKey: .usable_in_grid)
        try container.encodeIfPresent(validation, forKey: .validation)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "config": config as Any,
            "created_at": created_at as Any,
            "entity_ref": entity_ref as Any,
            "entity_type": entity_type as Any,
            "group_id": group_id as Any,
            "id": id as Any,
            "is_filterable": is_filterable as Any,
            "is_unique": is_unique as Any,
            "labels": labels as Any,
            "localizable": localizable as Any,
            "position": position as Any,
            "scopable": scopable as Any,
            "type": type as Any,
            "updated_at": updated_at as Any,
            "usable_in_grid": usable_in_grid as Any,
            "validation": validation as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> AttributesFilter {
        return AttributesFilter(
            code: map["code"] as? String,
            config: map["config"] as? String,
            created_at: map["created_at"] as? String,
            entity_ref: map["entity_ref"] as? String,
            entity_type: map["entity_type"] as? String,
            group_id: map["group_id"] as? String,
            id: map["id"] as? String,
            is_filterable: map["is_filterable"] as? String,
            is_unique: map["is_unique"] as? String,
            labels: map["labels"] as? String,
            localizable: map["localizable"] as? String,
            position: map["position"] as? String,
            scopable: map["scopable"] as? String,
            type: map["type"] as? String,
            updated_at: map["updated_at"] as? String,
            usable_in_grid: map["usable_in_grid"] as? String,
            validation: map["validation"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
