import Foundation
import JSONCodable

/// 
open class SyncRuleResource: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case enabled = "enabled"
        case id = "id"
        case last_run_at = "last_run_at"
        case options = "options"
        case schedule = "schedule"
        case sftp_account_id = "sftp_account_id"
        case source_path = "source_path"
        case target_folder_id = "target_folder_id"
        case tenant_id = "tenant_id"
    }

    /// 
    public let created_at: String
    /// 
    public let enabled: Bool
    /// 
    public let id: String
    /// 
    public let last_run_at: String
    /// 
    public let options: [AnyCodable]
    /// 
    public let schedule: String
    /// 
    public let sftp_account_id: String
    /// 
    public let source_path: String
    /// 
    public let target_folder_id: String
    /// 
    public let tenant_id: String

    init(
        created_at: String,
        enabled: Bool,
        id: String,
        last_run_at: String,
        options: [AnyCodable],
        schedule: String,
        sftp_account_id: String,
        source_path: String,
        target_folder_id: String,
        tenant_id: String
    ) {
        self.created_at = created_at
        self.enabled = enabled
        self.id = id
        self.last_run_at = last_run_at
        self.options = options
        self.schedule = schedule
        self.sftp_account_id = sftp_account_id
        self.source_path = source_path
        self.target_folder_id = target_folder_id
        self.tenant_id = tenant_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.id = try container.decode(String.self, forKey: .id)
        self.last_run_at = try container.decode(String.self, forKey: .last_run_at)
        self.options = try container.decode([AnyCodable].self, forKey: .options)
        self.schedule = try container.decode(String.self, forKey: .schedule)
        self.sftp_account_id = try container.decode(String.self, forKey: .sftp_account_id)
        self.source_path = try container.decode(String.self, forKey: .source_path)
        self.target_folder_id = try container.decode(String.self, forKey: .target_folder_id)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(created_at, forKey: .created_at)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(id, forKey: .id)
        try container.encode(last_run_at, forKey: .last_run_at)
        try container.encode(options, forKey: .options)
        try container.encode(schedule, forKey: .schedule)
        try container.encode(sftp_account_id, forKey: .sftp_account_id)
        try container.encode(source_path, forKey: .source_path)
        try container.encode(target_folder_id, forKey: .target_folder_id)
        try container.encode(tenant_id, forKey: .tenant_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "enabled": enabled as Any,
            "id": id as Any,
            "last_run_at": last_run_at as Any,
            "options": options as Any,
            "schedule": schedule as Any,
            "sftp_account_id": sftp_account_id as Any,
            "source_path": source_path as Any,
            "target_folder_id": target_folder_id as Any,
            "tenant_id": tenant_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SyncRuleResource {
        return SyncRuleResource(
            created_at: map["created_at"] as! String,
            enabled: map["enabled"] as! Bool,
            id: map["id"] as! String,
            last_run_at: map["last_run_at"] as! String,
            options: (map["options"] as! [Any]).map { AnyCodable($0) },
            schedule: map["schedule"] as! String,
            sftp_account_id: map["sftp_account_id"] as! String,
            source_path: map["source_path"] as! String,
            target_folder_id: map["target_folder_id"] as! String,
            tenant_id: map["tenant_id"] as! String
        )
    }
}
