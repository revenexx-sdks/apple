import Foundation
import JSONCodable

/// 
open class Page: Codable {

    enum CodingKeys: String, CodingKey {
        case analyze_ignored = "analyze_ignored"
        case bundle = "bundle"
        case created_at = "created_at"
        case created_by = "created_by"
        case deleted_at = "deleted_at"
        case host_options = "host_options"
        case id = "id"
        case meta = "meta"
        case published_revision_id = "published_revision_id"
        case slug = "slug"
        case source_language = "source_language"
        case status = "status"
        case title = "title"
        case updated_at = "updated_at"
        case updated_by = "updated_by"
    }

    /// 
    public let analyze_ignored: [String: AnyCodable]?
    /// 
    public let bundle: String?
    /// 
    public let created_at: String?
    /// 
    public let created_by: String?
    /// 
    public let deleted_at: String?
    /// 
    public let host_options: [String: AnyCodable]?
    /// 
    public let id: String?
    /// 
    public let meta: [String: AnyCodable]?
    /// 
    public let published_revision_id: String?
    /// 
    public let slug: String?
    /// 
    public let source_language: String?
    /// 
    public let status: String?
    /// 
    public let title: String?
    /// 
    public let updated_at: String?
    /// 
    public let updated_by: String?

    init(
        analyze_ignored: [String: AnyCodable]?,
        bundle: String?,
        created_at: String?,
        created_by: String?,
        deleted_at: String?,
        host_options: [String: AnyCodable]?,
        id: String?,
        meta: [String: AnyCodable]?,
        published_revision_id: String?,
        slug: String?,
        source_language: String?,
        status: String?,
        title: String?,
        updated_at: String?,
        updated_by: String?
    ) {
        self.analyze_ignored = analyze_ignored
        self.bundle = bundle
        self.created_at = created_at
        self.created_by = created_by
        self.deleted_at = deleted_at
        self.host_options = host_options
        self.id = id
        self.meta = meta
        self.published_revision_id = published_revision_id
        self.slug = slug
        self.source_language = source_language
        self.status = status
        self.title = title
        self.updated_at = updated_at
        self.updated_by = updated_by
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.analyze_ignored = try container.decodeIfPresent([String: AnyCodable].self, forKey: .analyze_ignored)
        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.created_by = try container.decodeIfPresent(String.self, forKey: .created_by)
        self.deleted_at = try container.decodeIfPresent(String.self, forKey: .deleted_at)
        self.host_options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .host_options)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.meta = try container.decodeIfPresent([String: AnyCodable].self, forKey: .meta)
        self.published_revision_id = try container.decodeIfPresent(String.self, forKey: .published_revision_id)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        self.source_language = try container.decodeIfPresent(String.self, forKey: .source_language)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.updated_by = try container.decodeIfPresent(String.self, forKey: .updated_by)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(analyze_ignored, forKey: .analyze_ignored)
        try container.encodeIfPresent(bundle, forKey: .bundle)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(created_by, forKey: .created_by)
        try container.encodeIfPresent(deleted_at, forKey: .deleted_at)
        try container.encodeIfPresent(host_options, forKey: .host_options)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(meta, forKey: .meta)
        try container.encodeIfPresent(published_revision_id, forKey: .published_revision_id)
        try container.encodeIfPresent(slug, forKey: .slug)
        try container.encodeIfPresent(source_language, forKey: .source_language)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(updated_by, forKey: .updated_by)
    }

    public func toMap() -> [String: Any] {
        return [
            "analyze_ignored": analyze_ignored as Any,
            "bundle": bundle as Any,
            "created_at": created_at as Any,
            "created_by": created_by as Any,
            "deleted_at": deleted_at as Any,
            "host_options": host_options as Any,
            "id": id as Any,
            "meta": meta as Any,
            "published_revision_id": published_revision_id as Any,
            "slug": slug as Any,
            "source_language": source_language as Any,
            "status": status as Any,
            "title": title as Any,
            "updated_at": updated_at as Any,
            "updated_by": updated_by as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Page {
        return Page(
            analyze_ignored: map["analyze_ignored"] as? [String: AnyCodable],
            bundle: map["bundle"] as? String,
            created_at: map["created_at"] as? String,
            created_by: map["created_by"] as? String,
            deleted_at: map["deleted_at"] as? String,
            host_options: map["host_options"] as? [String: AnyCodable],
            id: map["id"] as? String,
            meta: map["meta"] as? [String: AnyCodable],
            published_revision_id: map["published_revision_id"] as? String,
            slug: map["slug"] as? String,
            source_language: map["source_language"] as? String,
            status: map["status"] as? String,
            title: map["title"] as? String,
            updated_at: map["updated_at"] as? String,
            updated_by: map["updated_by"] as? String
        )
    }
}
