import Foundation
import JSONCodable
import RevenexxEnums

/// One addressable page of the storefront: its metadata and publish pointer. Its CONTENT is not here — blocks live behind the editor and delivery routes.
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

    /// Identifiers of findings the blökkli analyze feature was told to stop reporting for this page. Written by the `set_ignored_analyze` mutation and carried through publish, so dismissing a finding survives the next edit.
    public let analyze_ignored: [String]?
    /// The page TYPE, e.g. `standard` or a landing-page type the theme defines. It decides which fields the editor offers and which template the theme renders; the value set belongs to the active theme, not to this app.
    public let bundle: String?
    /// When the page was created.
    public let created_at: String?
    /// The user id that created the page.
    public let created_by: String?
    /// The tombstone. A soft-deleted page is never listed, never delivered and answers 404 — and it drops out of the unique slug index at once, so deleting a page frees its slug immediately.
    public let deleted_at: String?
    /// Page-level blökkli display options, as a flat `option key → value` map — the options that belong to the PAGE rather than to a block (background, width, whether the header is shown). The keys are defined by the theme; this app stores whatever the `update_host_options` mutation set.
    public let host_options: [String: AnyCodable]?
    /// The page id. Every editor and delivery route addresses a page by it, and it never changes — publishing replaces a page's blocks, never the page.
    public let id: String?
    /// The page's free-form metadata bag — SEO fields, social preview data, whatever the theme asks the editor for. Nothing in this app reads a key of it: it is stored, versioned into revisions and handed back to the renderer untouched, so the theme owns its shape.
    public let meta: [String: AnyCodable]?
    /// The revision the storefront is currently serving. `null` means nothing has ever been published, and delivery answers 404 for the page even when `status` says `published`.
    public let published_revision_id: String?
    /// The path segment the storefront routes this page under, without a leading slash. Unique per tenant among live pages, and `null` for a page that is only ever reached by id. `GET /pages/delivery/page?slug=` matches it first and the translations second.
    public let slug: String?
    /// The language the page was authored in. It is the fallback for every field a translation leaves empty, so a page never renders as a hole.
    public let source_language: String?
    /// Where the page sits in the editorial lifecycle. Only `published` is ever delivered, and only together with a `published_revision_id`.
    public let status: RevenexxEnums.PageStatus?
    /// The page title as an editor typed it, in the page's source language. Publishing overwrites it with the title the edit state carries, so this is always the last published (or last saved) wording.
    public let title: String?
    /// When the page last changed. The default sort of `GET /pages/pages` is this column descending, because "what did we touch last" is the question an editorial list is opened with.
    public let updated_at: String?
    /// The user id that last changed the page — set by an update, a soft delete and by publishing.
    public let updated_by: String?

    init(
        analyze_ignored: [String]?,
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
        status: RevenexxEnums.PageStatus?,
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

        self.analyze_ignored = try container.decodeIfPresent([String].self, forKey: .analyze_ignored)
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
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.PageStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
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
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
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
            "status": status?.rawValue as Any,
            "title": title as Any,
            "updated_at": updated_at as Any,
            "updated_by": updated_by as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Page {
        return Page(
            analyze_ignored: map["analyze_ignored"] as? [String],
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
            status: map["status"] as? String != nil ? PageStatus(rawValue: map["status"] as! String) : nil,
            title: map["title"] as? String,
            updated_at: map["updated_at"] as? String,
            updated_by: map["updated_by"] as? String
        )
    }
}
