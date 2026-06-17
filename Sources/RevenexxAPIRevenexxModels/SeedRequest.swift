import Foundation
import JSONCodable

/// 
open class SeedRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case menus = "menus"
        case pages = "pages"
    }

    /// 
    public let menus: [Any]?
    /// 
    public let pages: [Any]?

    init(
        menus: [Any]?,
        pages: [Any]?
    ) {
        self.menus = menus
        self.pages = pages
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.menus = try container.decodeIfPresent([Any].self, forKey: .menus)
        self.pages = try container.decodeIfPresent([Any].self, forKey: .pages)
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
            menus: map["menus"] as? [Any],
            pages: map["pages"] as? [Any]
        )
    }
}
