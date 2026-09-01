import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value. A template is a COPY source, so changing it never reaches the pages already made from it.
open class PageTemplateUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case field_name = "field_name"
        case is_default = "is_default"
        case label = "label"
        case page_bundle = "page_bundle"
        case tree = "tree"
    }

    /// A sentence about when to reach for it, shown next to the label.
    public let description: String?
    /// The field this template is offered in. Null offers it in every field.
    public let field_name: String?
    /// Whether a new page of this bundle starts from this template.
    public let is_default: Bool?
    /// What the template is called in the picker.
    public let label: String?
    /// The page type this template is offered on. Null offers it on every page type.
    public let page_bundle: String?
    /// The blocks the template inserts, in order. Replaces the stored tree completely.
    public let tree: [PageBlockTree]?

    init(
        description: String?,
        field_name: String?,
        is_default: Bool?,
        label: String?,
        page_bundle: String?,
        tree: [PageBlockTree]?
    ) {
        self.description = description
        self.field_name = field_name
        self.is_default = is_default
        self.label = label
        self.page_bundle = page_bundle
        self.tree = tree
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.field_name = try container.decodeIfPresent(String.self, forKey: .field_name)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.page_bundle = try container.decodeIfPresent(String.self, forKey: .page_bundle)
        self.tree = try container.decodeIfPresent([PageBlockTree].self, forKey: .tree)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(field_name, forKey: .field_name)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(page_bundle, forKey: .page_bundle)
        try container.encodeIfPresent(tree, forKey: .tree)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "field_name": field_name as Any,
            "is_default": is_default as Any,
            "label": label as Any,
            "page_bundle": page_bundle as Any,
            "tree": tree?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageTemplateUpdateRequest {
        return PageTemplateUpdateRequest(
            description: map["description"] as? String,
            field_name: map["field_name"] as? String,
            is_default: map["is_default"] as? Bool,
            label: map["label"] as? String,
            page_bundle: map["page_bundle"] as? String,
            tree: (map["tree"] as? [[String: Any]] ?? []).map { PageBlockTree.from(map: $0) }
        )
    }
}
