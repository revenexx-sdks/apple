import Foundation
import JSONCodable

/// Bucket
open class Bucket: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case permissions = "$permissions"
        case updatedAt = "$updatedAt"
        case allowedFileExtensions = "allowedFileExtensions"
        case antivirus = "antivirus"
        case compression = "compression"
        case enabled = "enabled"
        case encryption = "encryption"
        case fileSecurity = "fileSecurity"
        case maximumFileSize = "maximumFileSize"
        case name = "name"
        case totalSize = "totalSize"
        case transformations = "transformations"
    }

    /// Bucket creation time in ISO 8601 format.
    public let createdAt: String
    /// Bucket ID.
    public let id: String
    /// Bucket permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
    public let permissions: [String]
    /// Bucket update date in ISO 8601 format.
    public let updatedAt: String
    /// Allowed file extensions.
    public let allowedFileExtensions: [String]
    /// Virus scanning is enabled.
    public let antivirus: Bool
    /// Compression algorithm chosen for compression. Will be one of none, [gzip](https://en.wikipedia.org/wiki/Gzip), or [zstd](https://en.wikipedia.org/wiki/Zstd).
    public let compression: String
    /// Bucket enabled.
    public let enabled: Bool
    /// Bucket is encrypted.
    public let encryption: Bool
    /// Whether file-level security is enabled. [Learn more about permissions](https://appwrite.io/docs/permissions).
    public let fileSecurity: Bool
    /// Maximum file size supported.
    public let maximumFileSize: Int
    /// Bucket name.
    public let name: String
    /// Total size of this bucket in bytes.
    public let totalSize: Int
    /// Image transformations are enabled.
    public let transformations: Bool

    init(
        createdAt: String,
        id: String,
        permissions: [String],
        updatedAt: String,
        allowedFileExtensions: [String],
        antivirus: Bool,
        compression: String,
        enabled: Bool,
        encryption: Bool,
        fileSecurity: Bool,
        maximumFileSize: Int,
        name: String,
        totalSize: Int,
        transformations: Bool
    ) {
        self.createdAt = createdAt
        self.id = id
        self.permissions = permissions
        self.updatedAt = updatedAt
        self.allowedFileExtensions = allowedFileExtensions
        self.antivirus = antivirus
        self.compression = compression
        self.enabled = enabled
        self.encryption = encryption
        self.fileSecurity = fileSecurity
        self.maximumFileSize = maximumFileSize
        self.name = name
        self.totalSize = totalSize
        self.transformations = transformations
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.permissions = try container.decode([String].self, forKey: .permissions)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.allowedFileExtensions = try container.decode([String].self, forKey: .allowedFileExtensions)
        self.antivirus = try container.decode(Bool.self, forKey: .antivirus)
        self.compression = try container.decode(String.self, forKey: .compression)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.encryption = try container.decode(Bool.self, forKey: .encryption)
        self.fileSecurity = try container.decode(Bool.self, forKey: .fileSecurity)
        self.maximumFileSize = try container.decode(Int.self, forKey: .maximumFileSize)
        self.name = try container.decode(String.self, forKey: .name)
        self.totalSize = try container.decode(Int.self, forKey: .totalSize)
        self.transformations = try container.decode(Bool.self, forKey: .transformations)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(permissions, forKey: .permissions)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(allowedFileExtensions, forKey: .allowedFileExtensions)
        try container.encode(antivirus, forKey: .antivirus)
        try container.encode(compression, forKey: .compression)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(encryption, forKey: .encryption)
        try container.encode(fileSecurity, forKey: .fileSecurity)
        try container.encode(maximumFileSize, forKey: .maximumFileSize)
        try container.encode(name, forKey: .name)
        try container.encode(totalSize, forKey: .totalSize)
        try container.encode(transformations, forKey: .transformations)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$permissions": permissions as Any,
            "$updatedAt": updatedAt as Any,
            "allowedFileExtensions": allowedFileExtensions as Any,
            "antivirus": antivirus as Any,
            "compression": compression as Any,
            "enabled": enabled as Any,
            "encryption": encryption as Any,
            "fileSecurity": fileSecurity as Any,
            "maximumFileSize": maximumFileSize as Any,
            "name": name as Any,
            "totalSize": totalSize as Any,
            "transformations": transformations as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Bucket {
        return Bucket(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            permissions: map["$permissions"] as! [String],
            updatedAt: map["$updatedAt"] as! String,
            allowedFileExtensions: map["allowedFileExtensions"] as! [String],
            antivirus: map["antivirus"] as! Bool,
            compression: map["compression"] as! String,
            enabled: map["enabled"] as! Bool,
            encryption: map["encryption"] as! Bool,
            fileSecurity: map["fileSecurity"] as! Bool,
            maximumFileSize: map["maximumFileSize"] as! Int,
            name: map["name"] as! String,
            totalSize: map["totalSize"] as! Int,
            transformations: map["transformations"] as! Bool
        )
    }
}
