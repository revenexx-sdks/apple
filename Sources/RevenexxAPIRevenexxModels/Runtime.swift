import Foundation
import JSONCodable

/// Runtime
open class Runtime: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case base = "base"
        case image = "image"
        case key = "key"
        case logo = "logo"
        case name = "name"
        case supports = "supports"
        case version = "version"
    }

    /// Runtime ID.
    public let id: String
    /// Base Docker image used to build the runtime.
    public let base: String
    /// Image name of Docker Hub.
    public let image: String
    /// Parent runtime key.
    public let key: String
    /// Name of the logo image.
    public let logo: String
    /// Runtime Name.
    public let name: String
    /// List of supported architectures.
    public let supports: [String]
    /// Runtime version.
    public let version: String

    init(
        id: String,
        base: String,
        image: String,
        key: String,
        logo: String,
        name: String,
        supports: [String],
        version: String
    ) {
        self.id = id
        self.base = base
        self.image = image
        self.key = key
        self.logo = logo
        self.name = name
        self.supports = supports
        self.version = version
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.base = try container.decode(String.self, forKey: .base)
        self.image = try container.decode(String.self, forKey: .image)
        self.key = try container.decode(String.self, forKey: .key)
        self.logo = try container.decode(String.self, forKey: .logo)
        self.name = try container.decode(String.self, forKey: .name)
        self.supports = try container.decode([String].self, forKey: .supports)
        self.version = try container.decode(String.self, forKey: .version)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(base, forKey: .base)
        try container.encode(image, forKey: .image)
        try container.encode(key, forKey: .key)
        try container.encode(logo, forKey: .logo)
        try container.encode(name, forKey: .name)
        try container.encode(supports, forKey: .supports)
        try container.encode(version, forKey: .version)
    }

    public func toMap() -> [String: Any] {
        return [
            "$id": id as Any,
            "base": base as Any,
            "image": image as Any,
            "key": key as Any,
            "logo": logo as Any,
            "name": name as Any,
            "supports": supports as Any,
            "version": version as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Runtime {
        return Runtime(
            id: map["$id"] as! String,
            base: map["base"] as! String,
            image: map["image"] as! String,
            key: map["key"] as! String,
            logo: map["logo"] as! String,
            name: map["name"] as! String,
            supports: map["supports"] as! [String],
            version: map["version"] as! String
        )
    }
}
