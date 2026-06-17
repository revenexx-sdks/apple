import Foundation
import JSONCodable

/// Framework Adapter
open class FrameworkAdapter: Codable {

    enum CodingKeys: String, CodingKey {
        case buildCommand = "buildCommand"
        case fallbackFile = "fallbackFile"
        case installCommand = "installCommand"
        case key = "key"
        case outputDirectory = "outputDirectory"
    }

    /// Default command to build site into output directory.
    public let buildCommand: String
    /// Name of fallback file to use instead of 404 page. If null, Appwrite 404 page will be displayed.
    public let fallbackFile: String
    /// Default command to download dependencies.
    public let installCommand: String
    /// Adapter key.
    public let key: String
    /// Default output directory of build.
    public let outputDirectory: String

    init(
        buildCommand: String,
        fallbackFile: String,
        installCommand: String,
        key: String,
        outputDirectory: String
    ) {
        self.buildCommand = buildCommand
        self.fallbackFile = fallbackFile
        self.installCommand = installCommand
        self.key = key
        self.outputDirectory = outputDirectory
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.buildCommand = try container.decode(String.self, forKey: .buildCommand)
        self.fallbackFile = try container.decode(String.self, forKey: .fallbackFile)
        self.installCommand = try container.decode(String.self, forKey: .installCommand)
        self.key = try container.decode(String.self, forKey: .key)
        self.outputDirectory = try container.decode(String.self, forKey: .outputDirectory)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(buildCommand, forKey: .buildCommand)
        try container.encode(fallbackFile, forKey: .fallbackFile)
        try container.encode(installCommand, forKey: .installCommand)
        try container.encode(key, forKey: .key)
        try container.encode(outputDirectory, forKey: .outputDirectory)
    }

    public func toMap() -> [String: Any] {
        return [
            "buildCommand": buildCommand as Any,
            "fallbackFile": fallbackFile as Any,
            "installCommand": installCommand as Any,
            "key": key as Any,
            "outputDirectory": outputDirectory as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FrameworkAdapter {
        return FrameworkAdapter(
            buildCommand: map["buildCommand"] as! String,
            fallbackFile: map["fallbackFile"] as! String,
            installCommand: map["installCommand"] as! String,
            key: map["key"] as! String,
            outputDirectory: map["outputDirectory"] as! String
        )
    }
}
