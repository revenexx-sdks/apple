import Foundation
import JSONCodable

/// One block, ready to render: props resolved for the requested language, library references already expanded, scheduled blocks already filtered out.
open class DeliveryBlock: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case children = "children"
        case fragmentName = "fragmentName"
        case libraryItemId = "libraryItemId"
        case options = "options"
        case props = "props"
        case uuid = "uuid"
    }

    /// The block type. This is what a theme switches its component on.
    public let bundle: String?
    /// Nested blocks keyed by the field they sit in — `{ "columns": [...] }`. Empty object on a leaf block.
    public let children: [String: AnyCodable]?
    /// The theme fragment to render instead of a props-driven component. Theme-defined, like a bundle.
    public let fragmentName: String?
    /// The library item this block came from, or `null`. Its content is already inlined above — this is for cache invalidation and editor links, not for a second fetch.
    public let libraryItemId: String?
    /// Display options for this block, as a flat `option key → value` map.
    public let options: [String: AnyCodable]?
    /// The block's field values for the requested language, source values already overlaid with that language's overrides. Theme-defined keys.
    public let props: [String: AnyCodable]?
    /// The block uuid — stable across publishes, so it is safe to use as a render key or an anchor.
    public let uuid: String?

    init(
        bundle: String?,
        children: [String: AnyCodable]?,
        fragmentName: String?,
        libraryItemId: String?,
        options: [String: AnyCodable]?,
        props: [String: AnyCodable]?,
        uuid: String?
    ) {
        self.bundle = bundle
        self.children = children
        self.fragmentName = fragmentName
        self.libraryItemId = libraryItemId
        self.options = options
        self.props = props
        self.uuid = uuid
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.children = try container.decodeIfPresent([String: AnyCodable].self, forKey: .children)
        self.fragmentName = try container.decodeIfPresent(String.self, forKey: .fragmentName)
        self.libraryItemId = try container.decodeIfPresent(String.self, forKey: .libraryItemId)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.props = try container.decodeIfPresent([String: AnyCodable].self, forKey: .props)
        self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(bundle, forKey: .bundle)
        try container.encodeIfPresent(children, forKey: .children)
        try container.encodeIfPresent(fragmentName, forKey: .fragmentName)
        try container.encodeIfPresent(libraryItemId, forKey: .libraryItemId)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(props, forKey: .props)
        try container.encodeIfPresent(uuid, forKey: .uuid)
    }

    public func toMap() -> [String: Any] {
        return [
            "bundle": bundle as Any,
            "children": children as Any,
            "fragmentName": fragmentName as Any,
            "libraryItemId": libraryItemId as Any,
            "options": options as Any,
            "props": props as Any,
            "uuid": uuid as Any
        ]
    }

    public static func from(map: [String: Any] ) -> DeliveryBlock {
        return DeliveryBlock(
            bundle: map["bundle"] as? String,
            children: map["children"] as? [String: AnyCodable],
            fragmentName: map["fragmentName"] as? String,
            libraryItemId: map["libraryItemId"] as? String,
            options: map["options"] as? [String: AnyCodable],
            props: map["props"] as? [String: AnyCodable],
            uuid: map["uuid"] as? String
        )
    }
}
