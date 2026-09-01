import Foundation
import JSONCodable

/// 
open class FolderResource: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case is_system = "is_system"
        case name = "name"
        case parent_id = "parent_id"
        case path = "path"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// 
    public let created_at: String
    /// 
    public let id: String
    /// 
    public let is_system: Bool
    /// 
    public let name: String
    /// 
    public let parent_id: String
    /// 
    public let path: String
    /// 
    public let tenant_id: String
    /// 
    public let updated_at: String

    init(
        created_at: String,
        id: String,
        is_system: Bool,
        name: String,
        parent_id: String,
        path: String,
        tenant_id: String,
        updated_at: String
    ) {
        self.created_at = created_at
        self.id = id
        self.is_system = is_system
        self.name = name
        self.parent_id = parent_id
        self.path = path
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.id = try container.decode(String.self, forKey: .id)
        self.is_system = try container.decode(Bool.self, forKey: .is_system)
        self.name = try container.decode(String.self, forKey: .name)
        self.parent_id = try container.decode(String.self, forKey: .parent_id)
        self.path = try container.decode(String.self, forKey: .path)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(created_at, forKey: .created_at)
        try container.encode(id, forKey: .id)
        try container.encode(is_system, forKey: .is_system)
        try container.encode(name, forKey: .name)
        try container.encode(parent_id, forKey: .parent_id)
        try container.encode(path, forKey: .path)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "is_system": is_system as Any,
            "name": name as Any,
            "parent_id": parent_id as Any,
            "path": path as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FolderResource {
        return FolderResource(
            created_at: map["created_at"] as! String,
            id: map["id"] as! String,
            is_system: map["is_system"] as! Bool,
            name: map["name"] as! String,
            parent_id: map["parent_id"] as! String,
            path: map["path"] as! String,
            tenant_id: map["tenant_id"] as! String,
            updated_at: map["updated_at"] as! String
        )
    }
}
