import Foundation
import JSONCodable

/// 
open class Template: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case created_by = "created_by"
        case description = "description"
        case field_name = "field_name"
        case id = "id"
        case is_default = "is_default"
        case label = "label"
        case page_bundle = "page_bundle"
        case tree = "tree"
        case updated_at = "updated_at"
    }

    /// 
    public let created_at: String?
    /// 
    public let created_by: String?
    /// 
    public let description: String?
    /// 
    public let field_name: String?
    /// 
    public let id: String?
    /// 
    public let is_default: Bool?
    /// 
    public let label: String?
    /// 
    public let page_bundle: String?
    /// 
    public let tree: [String: AnyCodable]?
    /// 
    public let updated_at: String?

    init(
        created_at: String?,
        created_by: String?,
        description: String?,
        field_name: String?,
        id: String?,
        is_default: Bool?,
        label: String?,
        page_bundle: String?,
        tree: [String: AnyCodable]?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.created_by = created_by
        self.description = description
        self.field_name = field_name
        self.id = id
        self.is_default = is_default
        self.label = label
        self.page_bundle = page_bundle
        self.tree = tree
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.created_by = try container.decodeIfPresent(String.self, forKey: .created_by)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.field_name = try container.decodeIfPresent(String.self, forKey: .field_name)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.page_bundle = try container.decodeIfPresent(String.self, forKey: .page_bundle)
        self.tree = try container.decodeIfPresent([String: AnyCodable].self, forKey: .tree)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(created_by, forKey: .created_by)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(field_name, forKey: .field_name)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(page_bundle, forKey: .page_bundle)
        try container.encodeIfPresent(tree, forKey: .tree)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "created_by": created_by as Any,
            "description": description as Any,
            "field_name": field_name as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "label": label as Any,
            "page_bundle": page_bundle as Any,
            "tree": tree as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Template {
        return Template(
            created_at: map["created_at"] as? String,
            created_by: map["created_by"] as? String,
            description: map["description"] as? String,
            field_name: map["field_name"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            label: map["label"] as? String,
            page_bundle: map["page_bundle"] as? String,
            tree: map["tree"] as? [String: AnyCodable],
            updated_at: map["updated_at"] as? String
        )
    }
}
