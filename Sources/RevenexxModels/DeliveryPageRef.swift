import Foundation
import JSONCodable

/// Just enough of a published page to link to it. The block tree is not here — fetch it with `GET /pages/delivery/page`.
open class DeliveryPageRef: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case id = "id"
        case slug = "slug"
        case title = "title"
    }

    /// The page type, so a sitemap can group or a picker can filter.
    public let bundle: String?
    /// The page id, usable as `?id=` on the delivery route.
    public let id: String?
    /// The path segment to build the URL from. `null` for a page reachable only by id, which a sitemap should skip.
    public let slug: String?
    /// The page title in its source language — this projection is not language-resolved.
    public let title: String?

    init(
        bundle: String?,
        id: String?,
        slug: String?,
        title: String?
    ) {
        self.bundle = bundle
        self.id = id
        self.slug = slug
        self.title = title
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(bundle, forKey: .bundle)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(slug, forKey: .slug)
        try container.encodeIfPresent(title, forKey: .title)
    }

    public func toMap() -> [String: Any] {
        return [
            "bundle": bundle as Any,
            "id": id as Any,
            "slug": slug as Any,
            "title": title as Any
        ]
    }

    public static func from(map: [String: Any] ) -> DeliveryPageRef {
        return DeliveryPageRef(
            bundle: map["bundle"] as? String,
            id: map["id"] as? String,
            slug: map["slug"] as? String,
            title: map["title"] as? String
        )
    }
}
