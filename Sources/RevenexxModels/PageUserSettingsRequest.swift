import Foundation
import JSONCodable

/// The preferences to store for the calling user.
open class PageUserSettingsRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case settings = "settings"
    }

    /// The whole preferences bag — replaced, not merged, so send all of it. Its keys vary by the editor build and this app reads none of them. Null or omitted stores `{}`, which is how a user resets their editor.
    public let settings: [String: AnyCodable]?

    init(
        settings: [String: AnyCodable]?
    ) {
        self.settings = settings
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.settings = try container.decodeIfPresent([String: AnyCodable].self, forKey: .settings)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(settings, forKey: .settings)
    }

    public func toMap() -> [String: Any] {
        return [
            "settings": settings as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageUserSettingsRequest {
        return PageUserSettingsRequest(
            settings: map["settings"] as? [String: AnyCodable]
        )
    }
}
