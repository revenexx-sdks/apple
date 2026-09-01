import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value. Every page that references this item renders the new tree the next time it is delivered, which is the whole point of the library and the whole risk of editing one.
open class PageLibraryItemUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case label = "label"
        case tree = "tree"
    }

    /// The block type this item instantiates. Changing it moves the item to a different part of the picker.
    public let bundle: String?
    /// What the item is called in the picker.
    public let label: String?
    /// A block and its whole subtree, serialized. Produced by the editor when a selection is made reusable or saved as a template, and instantiated back into real blocks when one is inserted.
    public let tree: PageBlockTree?

    init(
        bundle: String?,
        label: String?,
        tree: PageBlockTree?
    ) {
        self.bundle = bundle
        self.label = label
        self.tree = tree
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.tree = try container.decodeIfPresent(PageBlockTree.self, forKey: .tree)
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
            "tree": tree?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageLibraryItemUpdateRequest {
        return PageLibraryItemUpdateRequest(
            bundle: map["bundle"] as? String,
            label: map["label"] as? String,
            tree: PageBlockTree.from(map: map["tree"] as! [String: Any])
        )
    }
}
