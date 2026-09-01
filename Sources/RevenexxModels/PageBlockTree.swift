import Foundation
import JSONCodable

/// The block and everything under it, serialized. This is the payload: every page that references the item renders THIS tree, so editing it here changes every placement at once.
open class PageBlockTree: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case children = "children"
        case fragment_name = "fragment_name"
        case options = "options"
        case props = "props"
        case props_i18n = "props_i18n"
    }

    /// The block type — `hero`, `text`, `teaser`, whatever the active theme defines. It decides which component renders it and which props it carries.
    public let bundle: String?
    /// Nested blocks, keyed by the field they sit in — `{ "content": [...], "buttons": [...] }`. Absent on a leaf block.
    public let children: [String: AnyCodable]?
    /// The theme fragment this block renders instead of a props-driven component, or `null` for an ordinary block. Theme-defined, like a bundle.
    public let fragment_name: String?
    /// blökkli display options for this block, as a flat `option key → value` map (variant, spacing, background). Theme-defined, set by the `update_options` mutation.
    public let options: [String: AnyCodable]?
    /// The block's field values in the page's SOURCE language, as a flat `field name → value` map. The field names are the theme's; this app stores and replays them without reading one.
    public let props: [String: AnyCodable]?
    /// Per-language overrides of `props`, keyed by langcode: `{ "en": { "title": "About us" } }`. A field missing for a language falls back to `props`, which is why a half-translated page still renders.
    public let props_i18n: [String: AnyCodable]?

    init(
        bundle: String?,
        children: [String: AnyCodable]?,
        fragment_name: String?,
        options: [String: AnyCodable]?,
        props: [String: AnyCodable]?,
        props_i18n: [String: AnyCodable]?
    ) {
        self.bundle = bundle
        self.children = children
        self.fragment_name = fragment_name
        self.options = options
        self.props = props
        self.props_i18n = props_i18n
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.children = try container.decodeIfPresent([String: AnyCodable].self, forKey: .children)
        self.fragment_name = try container.decodeIfPresent(String.self, forKey: .fragment_name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.props = try container.decodeIfPresent([String: AnyCodable].self, forKey: .props)
        self.props_i18n = try container.decodeIfPresent([String: AnyCodable].self, forKey: .props_i18n)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(bundle, forKey: .bundle)
        try container.encodeIfPresent(children, forKey: .children)
        try container.encodeIfPresent(fragment_name, forKey: .fragment_name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(props, forKey: .props)
        try container.encodeIfPresent(props_i18n, forKey: .props_i18n)
    }

    public func toMap() -> [String: Any] {
        return [
            "bundle": bundle as Any,
            "children": children as Any,
            "fragment_name": fragment_name as Any,
            "options": options as Any,
            "props": props as Any,
            "props_i18n": props_i18n as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageBlockTree {
        return PageBlockTree(
            bundle: map["bundle"] as? String,
            children: map["children"] as? [String: AnyCodable],
            fragment_name: map["fragment_name"] as? String,
            options: map["options"] as? [String: AnyCodable],
            props: map["props"] as? [String: AnyCodable],
            props_i18n: map["props_i18n"] as? [String: AnyCodable]
        )
    }
}
