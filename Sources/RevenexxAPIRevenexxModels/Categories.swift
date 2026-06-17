import Foundation
import JSONCodable

/// 
open class Categories: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case labels = "labels"
        case parent_id = "parent_id"
        case path = "path"
        case position = "position"
        case updated_at = "updated_at"
        case values = "values"
    }

    /// 
    public let code: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let parent_id: String?
    /// 
    public let path: String?
    /// 
    public let position: Int?
    /// 
    public let updated_at: String?
    /// 
    public let values: [String: AnyCodable]?

    init(
        code: String?,
        created_at: String?,
        id: String?,
        labels: [String: AnyCodable]?,
        parent_id: String?,
        path: String?,
        position: Int?,
        updated_at: String?,
        values: [String: AnyCodable]?
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.labels = labels
        self.parent_id = parent_id
        self.path = path
        self.position = position
        self.updated_at = updated_at
        self.values = values
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.parent_id = try container.decodeIfPresent(String.self, forKey: .parent_id)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(parent_id, forKey: .parent_id)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(values, forKey: .values)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "labels": labels as Any,
            "parent_id": parent_id as Any,
            "path": path as Any,
            "position": position as Any,
            "updated_at": updated_at as Any,
            "values": values as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Categories {
        return Categories(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            parent_id: map["parent_id"] as? String,
            path: map["path"] as? String,
            position: map["position"] as? Int,
            updated_at: map["updated_at"] as? String,
            values: map["values"] as? [String: AnyCodable]
        )
    }
}
