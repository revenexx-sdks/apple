import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class PageLibraryItemUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case label = "label"
        case tree = "tree"
    }

    /// 
    public let bundle: String?
    /// 
    public let label: String?
    /// Serialized block tree ({ bundle, props, props_i18n, options, children }).
    public let tree: [String: AnyCodable]?

    init(
        bundle: String?,
        label: String?,
        tree: [String: AnyCodable]?
    ) {
        self.bundle = bundle
        self.label = label
        self.tree = tree
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.tree = try container.decodeIfPresent([String: AnyCodable].self, forKey: .tree)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(bundle, forKey: .bundle)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(tree, forKey: .tree)
    }

    public func toMap() -> [String: Any] {
        return [
            "bundle": bundle as Any,
            "label": label as Any,
            "tree": tree as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageLibraryItemUpdateRequest {
        return PageLibraryItemUpdateRequest(
            bundle: map["bundle"] as? String,
            label: map["label"] as? String,
            tree: map["tree"] as? [String: AnyCodable]
        )
    }
}
