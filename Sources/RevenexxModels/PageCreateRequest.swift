import Foundation
import JSONCodable

/// A new page. Only the title is yours to supply — everything else has a tenant default behind it.
open class PageCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case hostOptions = "hostOptions"
        case meta = "meta"
        case slug = "slug"
        case sourceLanguage = "sourceLanguage"
        case title = "title"
    }

    /// The page type. Omit to take the default_page_bundle setting.
    public let bundle: String?
    /// Page-level blökkli display options as a flat `option key → value` map. Theme-defined; usually left out and set later from the editor.
    public let hostOptions: [String: AnyCodable]?
    /// The page's metadata bag (SEO and social fields). Stored and handed back untouched — this app reads no key of it, so the theme decides what goes in.
    public let meta: [String: AnyCodable]?
    /// The path segment the storefront routes it under, without a leading slash. Unique per tenant among live pages; omit or send null for a page reached only by id. Nothing here derives one from the title.
    public let slug: String?
    /// The language you are authoring in, and the fallback for every later translation. Omit to take the default_source_language setting for the request market.
    public let sourceLanguage: String?
    /// What the page is called, in its source language. Shown in the editorial list and searched by `?q=`.
    public let title: String

    init(
        bundle: String?,
        hostOptions: [String: AnyCodable]?,
        meta: [String: AnyCodable]?,
        slug: String?,
        sourceLanguage: String?,
        title: String
    ) {
        self.bundle = bundle
        self.hostOptions = hostOptions
        self.meta = meta
        self.slug = slug
        self.sourceLanguage = sourceLanguage
        self.title = title
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.hostOptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .hostOptions)
        self.meta = try container.decodeIfPresent([String: AnyCodable].self, forKey: .meta)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        self.sourceLanguage = try container.decodeIfPresent(String.self, forKey: .sourceLanguage)
        self.title = try container.decode(String.self, forKey: .title)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(bundle, forKey: .bundle)
        try container.encodeIfPresent(hostOptions, forKey: .hostOptions)
        try container.encodeIfPresent(meta, forKey: .meta)
        try container.encodeIfPresent(slug, forKey: .slug)
        try container.encodeIfPresent(sourceLanguage, forKey: .sourceLanguage)
        try container.encode(title, forKey: .title)
    }

    public func toMap() -> [String: Any] {
        return [
            "bundle": bundle as Any,
            "hostOptions": hostOptions as Any,
            "meta": meta as Any,
            "slug": slug as Any,
            "sourceLanguage": sourceLanguage as Any,
            "title": title as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageCreateRequest {
        return PageCreateRequest(
            bundle: map["bundle"] as? String,
            hostOptions: map["hostOptions"] as? [String: AnyCodable],
            meta: map["meta"] as? [String: AnyCodable],
            slug: map["slug"] as? String,
            sourceLanguage: map["sourceLanguage"] as? String,
            title: map["title"] as! String
        )
    }
}
