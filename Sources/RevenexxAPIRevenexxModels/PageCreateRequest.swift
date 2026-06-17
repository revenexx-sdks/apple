import Foundation
import JSONCodable

/// 
open class PageCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case hostOptions = "hostOptions"
        case meta = "meta"
        case slug = "slug"
        case sourceLanguage = "sourceLanguage"
        case title = "title"
    }

    /// 
    public let bundle: String?
    /// 
    public let hostOptions: [String: AnyCodable]?
    /// 
    public let meta: [String: AnyCodable]?
    /// 
    public let slug: String?
    /// 
    public let sourceLanguage: String?
    /// 
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
