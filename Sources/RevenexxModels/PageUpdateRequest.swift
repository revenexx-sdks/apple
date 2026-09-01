import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — only title, slug, status, meta and bundle are applied; other keys are ignored. The page's CONTENT is never edited here: blocks change through the editor's mutation log.
open class PageUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case meta = "meta"
        case slug = "slug"
        case status = "status"
        case title = "title"
    }

    /// The page type. Changing it changes which template the theme renders.
    public let bundle: String?
    /// The page's metadata bag. Replaced wholesale, not merged.
    public let meta: [String: AnyCodable]?
    /// The path segment the storefront routes it under. Sending a slug another live page holds answers 409; sending null makes the page unreachable by path.
    public let slug: String?
    /// The lifecycle status. Setting `published` here does NOT publish content — delivery still needs a revision, which only `POST /pages/editor/{page_id}/publish` writes.
    public let status: RevenexxEnums.PageStatus?
    /// The page title in its source language.
    public let title: String?

    init(
        bundle: String?,
        meta: [String: AnyCodable]?,
        slug: String?,
        status: RevenexxEnums.PageStatus?,
        title: String?
    ) {
        self.bundle = bundle
        self.meta = meta
        self.slug = slug
        self.status = status
        self.title = title
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.meta = try container.decodeIfPresent([String: AnyCodable].self, forKey: .meta)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.PageStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(bundle, forKey: .bundle)
        try container.encodeIfPresent(meta, forKey: .meta)
        try container.encodeIfPresent(slug, forKey: .slug)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(title, forKey: .title)
    }

    public func toMap() -> [String: Any] {
        return [
            "bundle": bundle as Any,
            "meta": meta as Any,
            "slug": slug as Any,
            "status": status?.rawValue as Any,
            "title": title as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageUpdateRequest {
        return PageUpdateRequest(
            bundle: map["bundle"] as? String,
            meta: map["meta"] as? [String: AnyCodable],
            slug: map["slug"] as? String,
            status: map["status"] as? String != nil ? PageStatus(rawValue: map["status"] as! String) : nil,
            title: map["title"] as? String
        )
    }
}
