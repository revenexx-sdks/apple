import Foundation
import JSONCodable

/// No payload — releasing the hold is a pure state transition, and it clears hold_reason with it. Send {}.
open class OrderUnholdRequest: Codable {

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

    public static func from(map: [String: Any] ) -> OrderUnholdRequest {
        return OrderUnholdRequest()
    }
}
