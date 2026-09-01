import Foundation
import JSONCodable

/// A bulk job as returned by `/bulk-jobs`. Note that the row counts are
/// nested under `counts` — they are not top-level fields — and that the
/// response carries no `tenant_id` (the listing envelope does) and no
/// `updated_at`.
/// 
open class BulkJob: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case correlation_id = "correlation_id"
        case counts = "counts"
        case created_at = "created_at"
        case created_by = "created_by"
        case duration_ms = "duration_ms"
        case entity = "entity"
        case error_message = "error_message"
        case finished_at = "finished_at"
        case id = "id"
        case profile_id = "profile_id"
        case progress = "progress"
        case started_at = "started_at"
        case status = "status"
        case type = "type"
        case vendor = "vendor"
    }

    /// 
    public let app: String?
    /// 
    public let correlation_id: String?
    /// 
    public let counts: [String: AnyCodable]?
    /// 
    public let created_at: String?
    /// 
    public let created_by: String?
    /// 
    public let duration_ms: Int?
    /// 
    public let entity: String?
    /// 
    public let error_message: String?
    /// 
    public let finished_at: String?
    /// 
    public let id: String?
    /// 
    public let profile_id: String?
    /// Engine-reported progress. For an export this carries the
    /// `object_key` and `format` the result is written to.
    /// 
    public let progress: [String: AnyCodable]?
    /// 
    public let started_at: String?
    /// 
    public let status: BulkJobStatus?
    /// 
    public let type: BulkJobType?
    /// 
    public let vendor: String?

    init(
        app: String?,
        correlation_id: String?,
        counts: [String: AnyCodable]?,
        created_at: String?,
        created_by: String?,
        duration_ms: Int?,
        entity: String?,
        error_message: String?,
        finished_at: String?,
        id: String?,
        profile_id: String?,
        progress: [String: AnyCodable]?,
        started_at: String?,
        status: BulkJobStatus?,
        type: BulkJobType?,
        vendor: String?
    ) {
        self.app = app
        self.correlation_id = correlation_id
        self.counts = counts
        self.created_at = created_at
        self.created_by = created_by
        self.duration_ms = duration_ms
        self.entity = entity
        self.error_message = error_message
        self.finished_at = finished_at
        self.id = id
        self.profile_id = profile_id
        self.progress = progress
        self.started_at = started_at
        self.status = status
        self.type = type
        self.vendor = vendor
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.correlation_id = try container.decodeIfPresent(String.self, forKey: .correlation_id)
        self.counts = try container.decodeIfPresent([String: AnyCodable].self, forKey: .counts)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.created_by = try container.decodeIfPresent(String.self, forKey: .created_by)
        self.duration_ms = try container.decodeIfPresent(Int.self, forKey: .duration_ms)
        self.entity = try container.decodeIfPresent(String.self, forKey: .entity)
        self.error_message = try container.decodeIfPresent(String.self, forKey: .error_message)
        self.finished_at = try container.decodeIfPresent(String.self, forKey: .finished_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.profile_id = try container.decodeIfPresent(String.self, forKey: .profile_id)
        self.progress = try container.decodeIfPresent([String: AnyCodable].self, forKey: .progress)
        self.started_at = try container.decodeIfPresent(String.self, forKey: .started_at)
        self.status = try container.decodeIfPresent(BulkJobStatus.self, forKey: .status)
        self.type = try container.decodeIfPresent(BulkJobType.self, forKey: .type)
        self.vendor = try container.decodeIfPresent(String.self, forKey: .vendor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(correlation_id, forKey: .correlation_id)
        try container.encodeIfPresent(counts, forKey: .counts)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(created_by, forKey: .created_by)
        try container.encodeIfPresent(duration_ms, forKey: .duration_ms)
        try container.encodeIfPresent(entity, forKey: .entity)
        try container.encodeIfPresent(error_message, forKey: .error_message)
        try container.encodeIfPresent(finished_at, forKey: .finished_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(profile_id, forKey: .profile_id)
        try container.encodeIfPresent(progress, forKey: .progress)
        try container.encodeIfPresent(started_at, forKey: .started_at)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(vendor, forKey: .vendor)
    }

    public func toMap() -> [String: Any] {
        return [
            "app": app as Any,
            "correlation_id": correlation_id as Any,
            "counts": counts as Any,
            "created_at": created_at as Any,
            "created_by": created_by as Any,
            "duration_ms": duration_ms as Any,
            "entity": entity as Any,
            "error_message": error_message as Any,
            "finished_at": finished_at as Any,
            "id": id as Any,
            "profile_id": profile_id as Any,
            "progress": progress as Any,
            "started_at": started_at as Any,
            "status": status?.toMap() as Any,
            "type": type?.toMap() as Any,
            "vendor": vendor as Any
        ]
    }

    public static func from(map: [String: Any] ) -> BulkJob {
        return BulkJob(
            app: map["app"] as? String,
            correlation_id: map["correlation_id"] as? String,
            counts: map["counts"] as? [String: AnyCodable],
            created_at: map["created_at"] as? String,
            created_by: map["created_by"] as? String,
            duration_ms: map["duration_ms"] as? Int,
            entity: map["entity"] as? String,
            error_message: map["error_message"] as? String,
            finished_at: map["finished_at"] as? String,
            id: map["id"] as? String,
            profile_id: map["profile_id"] as? String,
            progress: map["progress"] as? [String: AnyCodable],
            started_at: map["started_at"] as? String,
            status: BulkJobStatus.from(map: map["status"] as! [String: Any]),
            type: BulkJobType.from(map: map["type"] as! [String: Any]),
            vendor: map["vendor"] as? String
        )
    }
}
