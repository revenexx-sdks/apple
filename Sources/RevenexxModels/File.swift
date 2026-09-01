import Foundation
import JSONCodable

/// File
open class File: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case permissions = "$permissions"
        case updatedAt = "$updatedAt"
        case bucketId = "bucketId"
        case chunksTotal = "chunksTotal"
        case chunksUploaded = "chunksUploaded"
        case compression = "compression"
        case encryption = "encryption"
        case mimeType = "mimeType"
        case name = "name"
        case signature = "signature"
        case sizeOriginal = "sizeOriginal"
    }

    /// File creation date in ISO 8601 format.
    public let createdAt: String
    /// File ID.
    public let id: String
    /// File permissions. Each entry is a permission string: an action wrapping a role, e.g. `read("any")`, `update("user:abc")`, `delete("team:abc/owner")`. Actions are `read`, `create`, `update`, `delete` and the aggregate `write` (= create + update + delete); the role inside the quotes takes the form described under “Role strings” in this document's introduction.
    public let permissions: [String]
    /// File update date in ISO 8601 format.
    public let updatedAt: String
    /// Bucket ID.
    public let bucketId: String
    /// Total number of chunks available
    public let chunksTotal: Int
    /// Total number of chunks uploaded
    public let chunksUploaded: Int
    /// Compression algorithm used for the file. Will be one of none, [gzip](https://en.wikipedia.org/wiki/Gzip), or [zstd](https://en.wikipedia.org/wiki/Zstd).
    public let compression: String
    /// Whether file contents are encrypted at rest.
    public let encryption: Bool
    /// File mime type.
    public let mimeType: String
    /// File name.
    public let name: String
    /// File MD5 signature.
    public let signature: String
    /// File original size in bytes.
    public let sizeOriginal: Int

    init(
        createdAt: String,
        id: String,
        permissions: [String],
        updatedAt: String,
        bucketId: String,
        chunksTotal: Int,
        chunksUploaded: Int,
        compression: String,
        encryption: Bool,
        mimeType: String,
        name: String,
        signature: String,
        sizeOriginal: Int
    ) {
        self.createdAt = createdAt
        self.id = id
        self.permissions = permissions
        self.updatedAt = updatedAt
        self.bucketId = bucketId
        self.chunksTotal = chunksTotal
        self.chunksUploaded = chunksUploaded
        self.compression = compression
        self.encryption = encryption
        self.mimeType = mimeType
        self.name = name
        self.signature = signature
        self.sizeOriginal = sizeOriginal
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.permissions = try container.decode([String].self, forKey: .permissions)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.bucketId = try container.decode(String.self, forKey: .bucketId)
        self.chunksTotal = try container.decode(Int.self, forKey: .chunksTotal)
        self.chunksUploaded = try container.decode(Int.self, forKey: .chunksUploaded)
        self.compression = try container.decode(String.self, forKey: .compression)
        self.encryption = try container.decode(Bool.self, forKey: .encryption)
        self.mimeType = try container.decode(String.self, forKey: .mimeType)
        self.name = try container.decode(String.self, forKey: .name)
        self.signature = try container.decode(String.self, forKey: .signature)
        self.sizeOriginal = try container.decode(Int.self, forKey: .sizeOriginal)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(permissions, forKey: .permissions)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(bucketId, forKey: .bucketId)
        try container.encode(chunksTotal, forKey: .chunksTotal)
        try container.encode(chunksUploaded, forKey: .chunksUploaded)
        try container.encode(compression, forKey: .compression)
        try container.encode(encryption, forKey: .encryption)
        try container.encode(mimeType, forKey: .mimeType)
        try container.encode(name, forKey: .name)
        try container.encode(signature, forKey: .signature)
        try container.encode(sizeOriginal, forKey: .sizeOriginal)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$permissions": permissions as Any,
            "$updatedAt": updatedAt as Any,
            "bucketId": bucketId as Any,
            "chunksTotal": chunksTotal as Any,
            "chunksUploaded": chunksUploaded as Any,
            "compression": compression as Any,
            "encryption": encryption as Any,
            "mimeType": mimeType as Any,
            "name": name as Any,
            "signature": signature as Any,
            "sizeOriginal": sizeOriginal as Any
        ]
    }

    public static func from(map: [String: Any] ) -> File {
        return File(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            permissions: map["$permissions"] as! [String],
            updatedAt: map["$updatedAt"] as! String,
            bucketId: map["bucketId"] as! String,
            chunksTotal: map["chunksTotal"] as! Int,
            chunksUploaded: map["chunksUploaded"] as! Int,
            compression: map["compression"] as! String,
            encryption: map["encryption"] as! Bool,
            mimeType: map["mimeType"] as! String,
            name: map["name"] as! String,
            signature: map["signature"] as! String,
            sizeOriginal: map["sizeOriginal"] as! Int
        )
    }
}
