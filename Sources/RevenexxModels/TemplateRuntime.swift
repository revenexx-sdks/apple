import Foundation
import JSONCodable

/// Template Runtime
open class TemplateRuntime: Codable {

    enum CodingKeys: String, CodingKey {
        case commands = "commands"
        case entrypoint = "entrypoint"
        case name = "name"
        case providerRootDirectory = "providerRootDirectory"
    }

    /// The build command used to build the deployment.
    public let commands: String
    /// The entrypoint file used to execute the deployment.
    public let entrypoint: String
    /// Runtime Name.
    public let name: String
    /// Path to function in VCS (Version Control System) repository
    public let providerRootDirectory: String

    init(
        commands: String,
        entrypoint: String,
        name: String,
        providerRootDirectory: String
    ) {
        self.commands = commands
        self.entrypoint = entrypoint
        self.name = name
        self.providerRootDirectory = providerRootDirectory
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.commands = try container.decode(String.self, forKey: .commands)
        self.entrypoint = try container.decode(String.self, forKey: .entrypoint)
        self.name = try container.decode(String.self, forKey: .name)
        self.providerRootDirectory = try container.decode(String.self, forKey: .providerRootDirectory)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(commands, forKey: .commands)
        try container.encode(entrypoint, forKey: .entrypoint)
        try container.encode(name, forKey: .name)
        try container.encode(providerRootDirectory, forKey: .providerRootDirectory)
    }

    public func toMap() -> [String: Any] {
        return [
            "commands": commands as Any,
            "entrypoint": entrypoint as Any,
            "name": name as Any,
            "providerRootDirectory": providerRootDirectory as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TemplateRuntime {
        return TemplateRuntime(
            commands: map["commands"] as! String,
            entrypoint: map["entrypoint"] as! String,
            name: map["name"] as! String,
            providerRootDirectory: map["providerRootDirectory"] as! String
        )
    }
}
