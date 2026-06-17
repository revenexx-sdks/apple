import Foundation
import JSONCodable

/// Deployments List
open class DeploymentList: Codable {

    enum CodingKeys: String, CodingKey {
        case deployments = "deployments"
        case total = "total"
    }

    /// List of deployments.
    public let deployments: [Deployment]
    /// Total number of deployments that matched your query.
    public let total: Int

    init(
        deployments: [Deployment],
        total: Int
    ) {
        self.deployments = deployments
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.deployments = try container.decode([Deployment].self, forKey: .deployments)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(deployments, forKey: .deployments)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "deployments": deployments.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> DeploymentList {
        return DeploymentList(
            deployments: (map["deployments"] as! [[String: Any]]).map { Deployment.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
