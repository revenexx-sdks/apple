import Foundation
import JSONCodable

/// Specifications List
open class SpecificationList: Codable {

    enum CodingKeys: String, CodingKey {
        case specifications = "specifications"
        case total = "total"
    }

    /// List of specifications.
    public let specifications: [Specification]
    /// Total number of specifications that matched your query.
    public let total: Int

    init(
        specifications: [Specification],
        total: Int
    ) {
        self.specifications = specifications
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.specifications = try container.decode([Specification].self, forKey: .specifications)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(specifications, forKey: .specifications)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "specifications": specifications.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SpecificationList {
        return SpecificationList(
            specifications: (map["specifications"] as! [[String: Any]]).map { Specification.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
