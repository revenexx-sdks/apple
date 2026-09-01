import Foundation
import JSONCodable
import RevenexxEnums

/// Where the value lives. Absent on an app whose custom fields are plain columns — then the field name IS the column.
open class AttributeFieldStorage: Codable {

    enum CodingKeys: String, CodingKey {
        case bucket = "bucket"
        case column = "column"
        case path = "path"
    }

    /// Which scope bucket this attribute writes to, implied by localizable/scopable.
    public let bucket: RevenexxEnums.AttributeValueBucket?
    /// The jsonb column holding the values (`attribute_values`).
    public let column: String?
    /// The exact key path for the requested context, or null when the request named no locale/channel and the bucket needs one. Null means: read-only until a context is chosen.
    public let path: [String]?

    init(
        bucket: RevenexxEnums.AttributeValueBucket?,
        column: String?,
        path: [String]?
    ) {
        self.bucket = bucket
        self.column = column
        self.path = path
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let bucketString = try container.decodeIfPresent(String.self, forKey: .bucket) {
            self.bucket = RevenexxEnums.AttributeValueBucket(rawValue: bucketString)
        } else {
            self.bucket = nil
        }
        self.column = try container.decodeIfPresent(String.self, forKey: .column)
        self.path = try container.decodeIfPresent([String].self, forKey: .path)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(bucket?.rawValue, forKey: .bucket)
        try container.encodeIfPresent(column, forKey: .column)
        try container.encodeIfPresent(path, forKey: .path)
    }

    public func toMap() -> [String: Any] {
        return [
            "bucket": bucket?.rawValue as Any,
            "column": column as Any,
            "path": path as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeFieldStorage {
        return AttributeFieldStorage(
            bucket: map["bucket"] as? String != nil ? AttributeValueBucket(rawValue: map["bucket"] as! String) : nil,
            column: map["column"] as? String,
            path: map["path"] as? [String]
        )
    }
}
