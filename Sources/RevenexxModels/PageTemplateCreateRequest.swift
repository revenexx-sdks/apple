import Foundation
import JSONCodable

/// The blocks to freeze, and where the template should be offered.
open class PageTemplateCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case fieldName = "fieldName"
        case isDefault = "isDefault"
        case label = "label"
        case pageBundle = "pageBundle"
        case uuids = "uuids"
    }

    /// A sentence about when to reach for it.
    public let description: String?
    /// The field this template should be offered in. Null offers it in every field.
    public let fieldName: String?
    /// Whether a new page of that type should start from this template.
    public let isDefault: Bool?
    /// What the template is called in the picker.
    public let label: String
    /// The page type this template should be offered on. Omit to take the current page's own type.
    public let pageBundle: String?
    /// The blocks to serialize into the template, each with its whole subtree. They are read from the CURRENT edit state, so unpublished changes are included.
    public let uuids: [String]

    init(
        description: String?,
        fieldName: String?,
        isDefault: Bool?,
        label: String,
        pageBundle: String?,
        uuids: [String]
    ) {
        self.description = description
        self.fieldName = fieldName
        self.isDefault = isDefault
        self.label = label
        self.pageBundle = pageBundle
        self.uuids = uuids
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.fieldName = try container.decodeIfPresent(String.self, forKey: .fieldName)
        self.isDefault = try container.decodeIfPresent(Bool.self, forKey: .isDefault)
        self.label = try container.decode(String.self, forKey: .label)
        self.pageBundle = try container.decodeIfPresent(String.self, forKey: .pageBundle)
        self.uuids = try container.decode([String].self, forKey: .uuids)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(fieldName, forKey: .fieldName)
        try container.encodeIfPresent(isDefault, forKey: .isDefault)
        try container.encode(label, forKey: .label)
        try container.encodeIfPresent(pageBundle, forKey: .pageBundle)
        try container.encode(uuids, forKey: .uuids)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "fieldName": fieldName as Any,
            "isDefault": isDefault as Any,
            "label": label as Any,
            "pageBundle": pageBundle as Any,
            "uuids": uuids as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageTemplateCreateRequest {
        return PageTemplateCreateRequest(
            description: map["description"] as? String,
            fieldName: map["fieldName"] as? String,
            isDefault: map["isDefault"] as? Bool,
            label: map["label"] as! String,
            pageBundle: map["pageBundle"] as? String,
            uuids: map["uuids"] as! [String]
        )
    }
}
