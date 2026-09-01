import Foundation
import JSONCodable

/// Baseline-IO-compatible column mapping. An empty object (or null) is identity: the full canonical shape, every field under its own name.
open class CartIoMapping: Codable {

    enum CodingKeys: String, CodingKey {
        case columns = "columns"
        case keys = "keys"
    }

    /// Renames, in order. On export the row is narrowed to these columns; on import a column that is not listed is ignored. Omit or leave empty for identity.
    public let columns: [CartIoMappingColumn]?
    /// Fields that identify a line in the payload — what the bundled quick-order template sets to ['sku'].
    public let keys: [String]?

    init(
        columns: [CartIoMappingColumn]?,
        keys: [String]?
    ) {
        self.columns = columns
        self.keys = keys
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.columns = try container.decodeIfPresent([CartIoMappingColumn].self, forKey: .columns)
        self.keys = try container.decodeIfPresent([String].self, forKey: .keys)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(columns, forKey: .columns)
        try container.encodeIfPresent(keys, forKey: .keys)
    }

    public func toMap() -> [String: Any] {
        return [
            "columns": columns?.map { $0.toMap() } as Any,
            "keys": keys as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartIoMapping {
        return CartIoMapping(
            columns: (map["columns"] as? [[String: Any]] ?? []).map { CartIoMappingColumn.from(map: $0) },
            keys: map["keys"] as? [String]
        )
    }
}
