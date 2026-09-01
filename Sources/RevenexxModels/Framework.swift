import Foundation
import JSONCodable

/// Framework
open class Framework: Codable {

    enum CodingKeys: String, CodingKey {
        case adapters = "adapters"
        case buildRuntime = "buildRuntime"
        case key = "key"
        case name = "name"
        case runtimes = "runtimes"
    }

    /// List of supported adapters.
    public let adapters: [FrameworkAdapter]
    /// Default runtime version.
    public let buildRuntime: String
    /// Framework key.
    public let key: String
    /// Framework Name.
    public let name: String
    /// List of supported runtime versions.
    public let runtimes: [String]

    init(
        adapters: [FrameworkAdapter],
        buildRuntime: String,
        key: String,
        name: String,
        runtimes: [String]
    ) {
        self.adapters = adapters
        self.buildRuntime = buildRuntime
        self.key = key
        self.name = name
        self.runtimes = runtimes
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.adapters = try container.decode([FrameworkAdapter].self, forKey: .adapters)
        self.buildRuntime = try container.decode(String.self, forKey: .buildRuntime)
        self.key = try container.decode(String.self, forKey: .key)
        self.name = try container.decode(String.self, forKey: .name)
        self.runtimes = try container.decode([String].self, forKey: .runtimes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(adapters, forKey: .adapters)
        try container.encode(buildRuntime, forKey: .buildRuntime)
        try container.encode(key, forKey: .key)
        try container.encode(name, forKey: .name)
        try container.encode(runtimes, forKey: .runtimes)
    }

    public func toMap() -> [String: Any] {
        return [
            "adapters": adapters.map { $0.toMap() } as Any,
            "buildRuntime": buildRuntime as Any,
            "key": key as Any,
            "name": name as Any,
            "runtimes": runtimes as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Framework {
        return Framework(
            adapters: (map["adapters"] as! [[String: Any]]).map { FrameworkAdapter.from(map: $0) },
            buildRuntime: map["buildRuntime"] as! String,
            key: map["key"] as! String,
            name: map["name"] as! String,
            runtimes: map["runtimes"] as! [String]
        )
    }
}
