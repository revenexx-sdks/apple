import Foundation
import JSONCodable

/// One reusable block. Every page that references it renders THIS tree, so editing the item changes every placement at once.
open class LibraryItem: Codable {

    enum CodingKeys: String, CodingKey {
        case bundle = "bundle"
        case created_at = "created_at"
        case created_by = "created_by"
        case deleted_at = "deleted_at"
        case id = "id"
        case label = "label"
        case tree = "tree"
        case updated_at = "updated_at"
    }

    /// The block type this item instantiates. The library picker filters by it, so an item only ever appears where its bundle is allowed. Theme-defined.
    public let bundle: String?
    /// When the item entered the library.
    public let created_at: String?
    /// The user id that made the block reusable.
    public let created_by: String?
    /// The tombstone. A soft-deleted item is never listed or handed out, and a block still referencing it keeps rendering its own last state rather than breaking.
    public let deleted_at: String?
    /// The library item id. A block references it to become an instance of the item rather than a copy.
    public let id: String?
    /// What the item is called in the library picker. This is the only thing an editor sees before inserting it, so it carries the whole description.
    public let label: String?
    /// The block and everything under it, serialized. This is the payload: every page that references the item renders THIS tree, so editing it here changes every placement at once.
    public let tree: PageBlockTree?
    /// When the item last changed — i.e. when every page referencing it last changed with it.
    public let updated_at: String?

    init(
        bundle: String?,
        created_at: String?,
        created_by: String?,
        deleted_at: String?,
        id: String?,
        label: String?,
        tree: PageBlockTree?,
        updated_at: String?
    ) {
        self.bundle = bundle
        self.created_at = created_at
        self.created_by = created_by
        self.deleted_at = deleted_at
        self.id = id
        self.label = label
        self.tree = tree
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.created_by = try container.decodeIfPresent(String.self, forKey: .created_by)
        self.deleted_at = try container.decodeIfPresent(String.self, forKey: .deleted_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.tree = try container.decodeIfPresent(PageBlockTree.self, forKey: .tree)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(bundle, forKey: .bundle)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(created_by, forKey: .created_by)
        try container.encodeIfPresent(deleted_at, forKey: .deleted_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(tree, forKey: .tree)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "bundle": bundle as Any,
            "created_at": created_at as Any,
            "created_by": created_by as Any,
            "deleted_at": deleted_at as Any,
            "id": id as Any,
            "label": label as Any,
            "tree": tree?.toMap() as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LibraryItem {
        return LibraryItem(
            bundle: map["bundle"] as? String,
            created_at: map["created_at"] as? String,
            created_by: map["created_by"] as? String,
            deleted_at: map["deleted_at"] as? String,
            id: map["id"] as? String,
            label: map["label"] as? String,
            tree: PageBlockTree.from(map: map["tree"] as! [String: Any]),
            updated_at: map["updated_at"] as? String
        )
    }
}
