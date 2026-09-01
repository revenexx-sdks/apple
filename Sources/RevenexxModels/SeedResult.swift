import Foundation
import JSONCodable

/// What was created and what was already there. Nothing is ever overwritten, so a non-empty `skipped` is the normal answer to a second run.
open class SeedResult: Codable {

    enum CodingKeys: String, CodingKey {
        case menus = "menus"
        case pages = "pages"
    }

    /// The menu half of the run.
    public let menus: [String: AnyCodable]?
    /// The page half of the run.
    public let pages: [String: AnyCodable]?

    init(
        menus: [String: AnyCodable]?,
        pages: [String: AnyCodable]?
    ) {
        self.menus = menus
        self.pages = pages
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.menus = try container.decodeIfPresent([String: AnyCodable].self, forKey: .menus)
        self.pages = try container.decodeIfPresent([String: AnyCodable].self, forKey: .pages)
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

    public static func from(map: [String: Any] ) -> SeedResult {
        return SeedResult(
            menus: map["menus"] as? [String: AnyCodable],
            pages: map["pages"] as? [String: AnyCodable]
        )
    }
}
