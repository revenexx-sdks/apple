import Foundation
import JSONCodable

/// Sites List
open class SiteList: Codable {

    enum CodingKeys: String, CodingKey {
        case sites = "sites"
        case total = "total"
    }

    /// List of sites.
    public let sites: [Site]
    /// Total number of sites that matched your query.
    public let total: Int

    init(
        sites: [Site],
        total: Int
    ) {
        self.sites = sites
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.sites = try container.decode([Site].self, forKey: .sites)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(sites, forKey: .sites)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "sites": sites.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SiteList {
        return SiteList(
            sites: (map["sites"] as! [[String: Any]]).map { Site.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
