import Foundation
import JSONCodable

/// 
open class SyncHistory: Codable {

    enum CodingKeys: String, CodingKey {
        case bytes_synced = "bytes_synced"
        case created_at = "created_at"
        case duration_ms = "duration_ms"
        case error = "error"
        case id = "id"
        case rule_id = "rule_id"
        case run_id = "run_id"
        case source_path = "source_path"
        case status = "status"
        case target_asset_id = "target_asset_id"
        case tenant_id = "tenant_id"
    }

    /// 
    public let bytes_synced: Int
    /// 
    public let created_at: String
    /// 
    public let duration_ms: Int
    /// 
    public let error: String
    /// 
    public let id: Int
    /// 
    public let rule_id: String
    /// 
    public let run_id: String
    /// 
    public let source_path: String
    /// 
    public let status: String
    /// 
    public let target_asset_id: String
    /// 
    public let tenant_id: String

    init(
        bytes_synced: Int,
        created_at: String,
        duration_ms: Int,
        error: String,
        id: Int,
        rule_id: String,
        run_id: String,
        source_path: String,
        status: String,
        target_asset_id: String,
        tenant_id: String
    ) {
        self.bytes_synced = bytes_synced
        self.created_at = created_at
        self.duration_ms = duration_ms
        self.error = error
        self.id = id
        self.rule_id = rule_id
        self.run_id = run_id
        self.source_path = source_path
        self.status = status
        self.target_asset_id = target_asset_id
        self.tenant_id = tenant_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bytes_synced = try container.decode(Int.self, forKey: .bytes_synced)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.duration_ms = try container.decode(Int.self, forKey: .duration_ms)
        self.error = try container.decode(String.self, forKey: .error)
        self.id = try container.decode(Int.self, forKey: .id)
        self.rule_id = try container.decode(String.self, forKey: .rule_id)
        self.run_id = try container.decode(String.self, forKey: .run_id)
        self.source_path = try container.decode(String.self, forKey: .source_path)
        self.status = try container.decode(String.self, forKey: .status)
        self.target_asset_id = try container.decode(String.self, forKey: .target_asset_id)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(bytes_synced, forKey: .bytes_synced)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(duration_ms, forKey: .duration_ms)
        try container.encode(error, forKey: .error)
        try container.encode(id, forKey: .id)
        try container.encode(rule_id, forKey: .rule_id)
        try container.encode(run_id, forKey: .run_id)
        try container.encode(source_path, forKey: .source_path)
        try container.encode(status, forKey: .status)
        try container.encode(target_asset_id, forKey: .target_asset_id)
        try container.encode(tenant_id, forKey: .tenant_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "bytes_synced": bytes_synced as Any,
            "created_at": created_at as Any,
            "duration_ms": duration_ms as Any,
            "error": error as Any,
            "id": id as Any,
            "rule_id": rule_id as Any,
            "run_id": run_id as Any,
            "source_path": source_path as Any,
            "status": status as Any,
            "target_asset_id": target_asset_id as Any,
            "tenant_id": tenant_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SyncHistory {
        return SyncHistory(
            bytes_synced: map["bytes_synced"] as! Int,
            created_at: map["created_at"] as! String,
            duration_ms: map["duration_ms"] as! Int,
            error: map["error"] as! String,
            id: map["id"] as! Int,
            rule_id: map["rule_id"] as! String,
            run_id: map["run_id"] as! String,
            source_path: map["source_path"] as! String,
            status: map["status"] as! String,
            target_asset_id: map["target_asset_id"] as! String,
            tenant_id: map["tenant_id"] as! String
        )
    }
}
