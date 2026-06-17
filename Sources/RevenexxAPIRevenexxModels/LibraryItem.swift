import Foundation
import JSONCodable

/// 
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

    /// 
    public let bundle: String?
    /// 
    public let created_at: String?
    /// 
    public let created_by: String?
    /// 
    public let deleted_at: String?
    /// 
    public let id: String?
    /// 
    public let label: String?
    /// 
    public let tree: [String: AnyCodable]?
    /// 
    public let updated_at: String?

    init(
        bundle: String?,
        created_at: String?,
        created_by: String?,
        deleted_at: String?,
        id: String?,
        label: String?,
        tree: [String: AnyCodable]?,
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
        self.tree = try container.decodeIfPresent([String: AnyCodable].self, forKey: .tree)
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
            "tree": tree as Any,
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
            tree: map["tree"] as? [String: AnyCodable],
            updated_at: map["updated_at"] as? String
        )
    }
}
