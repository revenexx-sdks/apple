import Foundation
import JSONCodable

/// Omit the body entirely to resume an unfinished pass, or start a fresh one when the last completed.
open class CategoryRecomputeRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case cursor = "cursor"
    }

    /// The `cursor` a previous call returned, to continue that pass. Send `null` explicitly to restart from the beginning; omit the field to let the app decide (resume if a pass is in flight, otherwise start fresh). Anything that is not a string or null is a 400.
    public let cursor: String?

    init(
        cursor: String?
    ) {
        self.cursor = cursor
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cursor, forKey: .cursor)
    }

    public func toMap() -> [String: Any] {
        return [
            "cursor": cursor as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CategoryRecomputeRequest {
        return CategoryRecomputeRequest(
            cursor: map["cursor"] as? String
        )
    }
}
