import Foundation
import JSONCodable

/// Template Variable
open class TemplateVariable: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case name = "name"
        case placeholder = "placeholder"
        case `required` = "required"
        case secret = "secret"
        case type = "type"
        case value = "value"
    }

    /// Variable Description.
    public let description: String
    /// Variable Name.
    public let name: String
    /// Variable Placeholder.
    public let placeholder: String
    /// Is the variable required?
    public let `required`: Bool
    /// Variable secret flag. Secret variables can only be updated or deleted, but never read.
    public let secret: Bool
    /// Variable Type.
    public let type: String
    /// Variable Value.
    public let value: String

    init(
        description: String,
        name: String,
        placeholder: String,
        `required`: Bool,
        secret: Bool,
        type: String,
        value: String
    ) {
        self.description = description
        self.name = name
        self.placeholder = placeholder
        self.`required` = `required`
        self.secret = secret
        self.type = type
        self.value = value
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decode(String.self, forKey: .description)
        self.name = try container.decode(String.self, forKey: .name)
        self.placeholder = try container.decode(String.self, forKey: .placeholder)
        self.`required` = try container.decode(Bool.self, forKey: .`required`)
        self.secret = try container.decode(Bool.self, forKey: .secret)
        self.type = try container.decode(String.self, forKey: .type)
        self.value = try container.decode(String.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(description, forKey: .description)
        try container.encode(name, forKey: .name)
        try container.encode(placeholder, forKey: .placeholder)
        try container.encode(`required`, forKey: .`required`)
        try container.encode(secret, forKey: .secret)
        try container.encode(type, forKey: .type)
        try container.encode(value, forKey: .value)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "name": name as Any,
            "placeholder": placeholder as Any,
            "required": `required` as Any,
            "secret": secret as Any,
            "type": type as Any,
            "value": value as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TemplateVariable {
        return TemplateVariable(
            description: map["description"] as! String,
            name: map["name"] as! String,
            placeholder: map["placeholder"] as! String,
            required: map["required"] as! Bool,
            secret: map["secret"] as! Bool,
            type: map["type"] as! String,
            value: map["value"] as! String
        )
    }
}
