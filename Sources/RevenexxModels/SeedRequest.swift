import Foundation
import JSONCodable

/// A theme's starting content. Both lists are optional; sending neither is a no-op.
open class SeedRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case menus = "menus"
        case pages = "pages"
    }

    /// The menus to create. One with no key or no label is reported under `skipped`.
    public let menus: [[String: AnyCodable]]?
    /// The pages to create. One that has no `slug` or no `title` is reported under `skipped` rather than refused, so one bad entry never loses the rest.
    public let pages: [[String: AnyCodable]]?

    init(
        menus: [[String: AnyCodable]]?,
        pages: [[String: AnyCodable]]?
    ) {
        self.menus = menus
        self.pages = pages
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.menus = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .menus)
        self.pages = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .pages)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(menus, forKey: .menus)
        try container.encodeIfPresent(pages, forKey: .pages)
    }

    public func toMap() -> [String: Any] {
        return [
            "menus": menus as Any,
            "pages": pages as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SeedRequest {
        return SeedRequest(
            menus: map["menus"] as? [[String: AnyCodable]],
            pages: map["pages"] as? [[String: AnyCodable]]
        )
    }
}
