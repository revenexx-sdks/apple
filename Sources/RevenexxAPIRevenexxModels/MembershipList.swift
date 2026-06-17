import Foundation
import JSONCodable

/// Memberships List
open class MembershipList: Codable {

    enum CodingKeys: String, CodingKey {
        case memberships = "memberships"
        case total = "total"
    }

    /// List of memberships.
    public let memberships: [Membership]
    /// Total number of memberships that matched your query.
    public let total: Int

    init(
        memberships: [Membership],
        total: Int
    ) {
        self.memberships = memberships
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.memberships = try container.decode([Membership].self, forKey: .memberships)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(memberships, forKey: .memberships)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "memberships": memberships.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MembershipList {
        return MembershipList(
            memberships: (map["memberships"] as! [[String: Any]]).map { Membership.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
