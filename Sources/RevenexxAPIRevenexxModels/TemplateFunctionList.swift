import Foundation
import JSONCodable

/// Function Templates List
open class TemplateFunctionList: Codable {

    enum CodingKeys: String, CodingKey {
        case templates = "templates"
        case total = "total"
    }

    /// List of templates.
    public let templates: [TemplateFunction]
    /// Total number of templates that matched your query.
    public let total: Int

    init(
        templates: [TemplateFunction],
        total: Int
    ) {
        self.templates = templates
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.templates = try container.decode([TemplateFunction].self, forKey: .templates)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(templates, forKey: .templates)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "templates": templates.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TemplateFunctionList {
        return TemplateFunctionList(
            templates: (map["templates"] as! [[String: Any]]).map { TemplateFunction.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
