import Foundation
import JSONCodable

/// No body. Everything this needs is the path id and what the catalog already holds; send `{}`.
open class ProductCompletenessRequest: Codable {

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

    public static func from(map: [String: Any] ) -> ProductCompletenessRequest {
        return ProductCompletenessRequest()
    }
}
