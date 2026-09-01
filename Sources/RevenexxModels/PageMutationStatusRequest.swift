import Foundation
import JSONCodable

/// Which entry of the history to switch, and to what.
open class PageMutationStatusRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case enabled = "enabled"
        case index = "index"
        case langcode = "langcode"
    }

    /// Whether the entry takes part in the replay.
    public let enabled: Bool
    /// The position in the mutation log to switch. Unknown positions answer 404.
    public let index: Int
    /// Which language the returned state should be resolved for.
    public let langcode: String?

    init(
        enabled: Bool,
        index: Int,
        langcode: String?
    ) {
        self.enabled = enabled
        self.index = index
        self.langcode = langcode
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.index = try container.decode(Int.self, forKey: .index)
        self.langcode = try container.decodeIfPresent(String.self, forKey: .langcode)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(enabled, forKey: .enabled)
        try container.encode(index, forKey: .index)
        try container.encodeIfPresent(langcode, forKey: .langcode)
    }

    public func toMap() -> [String: Any] {
        return [
            "enabled": enabled as Any,
            "index": index as Any,
            "langcode": langcode as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageMutationStatusRequest {
        return PageMutationStatusRequest(
            enabled: map["enabled"] as! Bool,
            index: map["index"] as! Int,
            langcode: map["langcode"] as? String
        )
    }
}
