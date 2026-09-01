import Foundation
import JSONCodable

/// What to record about this publication.
open class PagePublishRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case force = "force"
        case label = "label"
    }

    /// Publish despite violations. Without it a page with unresolved violations answers 422 and nothing is written.
    public let force: Bool?
    /// What to call this publication in the page's history — "Autumn campaign" rather than a timestamp.
    public let label: String?

    init(
        force: Bool?,
        label: String?
    ) {
        self.force = force
        self.label = label
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.force = try container.decodeIfPresent(Bool.self, forKey: .force)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(force, forKey: .force)
        try container.encodeIfPresent(label, forKey: .label)
    }

    public func toMap() -> [String: Any] {
        return [
            "force": force as Any,
            "label": label as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PagePublishRequest {
        return PagePublishRequest(
            force: map["force"] as? Bool,
            label: map["label"] as? String
        )
    }
}
