import Foundation
import JSONCodable

/// 
open class AuditEntry: Codable {

    enum CodingKeys: String, CodingKey {
        case action = "action"
        case changes = "changes"
        case created_at = "created_at"
        case id = "id"
        case resource_id = "resource_id"
        case resource_key = "resource_key"
        case resource_type = "resource_type"
        case subject = "subject"
        case tenant_id = "tenant_id"
    }

    /// 
    public let action: String
    /// 
    public let changes: [AnyCodable]
    /// 
    public let created_at: String
    /// 
    public let id: String
    /// 
    public let resource_id: String
    /// 
    public let resource_key: String
    /// 
    public let resource_type: String
    /// 
    public let subject: String
    /// 
    public let tenant_id: String

    init(
        action: String,
        changes: [AnyCodable],
        created_at: String,
        id: String,
        resource_id: String,
        resource_key: String,
        resource_type: String,
        subject: String,
        tenant_id: String
    ) {
        self.action = action
        self.changes = changes
        self.created_at = created_at
        self.id = id
        self.resource_id = resource_id
        self.resource_key = resource_key
        self.resource_type = resource_type
        self.subject = subject
        self.tenant_id = tenant_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.action = try container.decode(String.self, forKey: .action)
        self.changes = try container.decode([AnyCodable].self, forKey: .changes)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.id = try container.decode(String.self, forKey: .id)
        self.resource_id = try container.decode(String.self, forKey: .resource_id)
        self.resource_key = try container.decode(String.self, forKey: .resource_key)
        self.resource_type = try container.decode(String.self, forKey: .resource_type)
        self.subject = try container.decode(String.self, forKey: .subject)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(action, forKey: .action)
        try container.encode(changes, forKey: .changes)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(id, forKey: .id)
        try container.encode(resource_id, forKey: .resource_id)
        try container.encode(resource_key, forKey: .resource_key)
        try container.encode(resource_type, forKey: .resource_type)
        try container.encode(subject, forKey: .subject)
        try container.encode(tenant_id, forKey: .tenant_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "action": action as Any,
            "changes": changes as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "resource_id": resource_id as Any,
            "resource_key": resource_key as Any,
            "resource_type": resource_type as Any,
            "subject": subject as Any,
            "tenant_id": tenant_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuditEntry {
        return AuditEntry(
            action: map["action"] as! String,
            changes: (map["changes"] as! [Any]).map { AnyCodable($0) },
            created_at: map["created_at"] as! String,
            id: map["id"] as! String,
            resource_id: map["resource_id"] as! String,
            resource_key: map["resource_key"] as! String,
            resource_type: map["resource_type"] as! String,
            subject: map["subject"] as! String,
            tenant_id: map["tenant_id"] as! String
        )
    }
}
