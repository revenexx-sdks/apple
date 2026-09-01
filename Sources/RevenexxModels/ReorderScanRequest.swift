import Foundation
import JSONCodable

/// No fields — send `{}`. What counts as low follows each row's own `reorder_point` and the market's `reorder_point_default`, exactly as GET /inventories/reorder-alerts computes it.
open class ReorderScanRequest: Codable {

    // A schema with no declared properties still has to answer the calls its
    // referencing models make. Every model that holds this one as a sub-schema
    // emits `values?.toMap()` and `Type.from(map:)`, so omitting them here does
    // not just make this model bare — it stops the *other* model compiling.
    // CartVocabularyValue is declared `type: array` in the spec, so it arrives
    // with its fields under `items` and none of its own; the array shape is not
    // modelled, hence the empty map.
    public func toMap() -> [String: Any] {
        return [:]
    }

    public static func from(map: [String: Any] ) -> ReorderScanRequest {
        return ReorderScanRequest()
    }
}
