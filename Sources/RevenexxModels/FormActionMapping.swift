import Foundation
import JSONCodable

/// 
open class FormActionMapping: Codable {

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case target = "target"
    }

    /// The key in the submission `data` — i.e. the `name` of a definition node.
    public let source: String?
    /// The column of the target entity it is written to.
    public let target: String?

    init(
        source: String?,
        target: String?
    ) {
        self.source = source
        self.target = target
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        self.target = try container.decodeIfPresent(String.self, forKey: .target)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(target, forKey: .target)
    }

    public func toMap() -> [String: Any] {
        return [
            "source": source as Any,
            "target": target as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormActionMapping {
        return FormActionMapping(
            source: map["source"] as? String,
            target: map["target"] as? String
        )
    }
}
