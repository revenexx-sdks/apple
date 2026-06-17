import Foundation
import JSONCodable

/// UsageFunction
open class UsageFunction: Codable {

    enum CodingKeys: String, CodingKey {
        case builds = "builds"
        case buildsFailed = "buildsFailed"
        case buildsFailedTotal = "buildsFailedTotal"
        case buildsMbSeconds = "buildsMbSeconds"
        case buildsMbSecondsTotal = "buildsMbSecondsTotal"
        case buildsStorage = "buildsStorage"
        case buildsStorageTotal = "buildsStorageTotal"
        case buildsSuccess = "buildsSuccess"
        case buildsSuccessTotal = "buildsSuccessTotal"
        case buildsTime = "buildsTime"
        case buildsTimeAverage = "buildsTimeAverage"
        case buildsTimeTotal = "buildsTimeTotal"
        case buildsTotal = "buildsTotal"
        case deployments = "deployments"
        case deploymentsStorage = "deploymentsStorage"
        case deploymentsStorageTotal = "deploymentsStorageTotal"
        case deploymentsTotal = "deploymentsTotal"
        case executions = "executions"
        case executionsMbSeconds = "executionsMbSeconds"
        case executionsMbSecondsTotal = "executionsMbSecondsTotal"
        case executionsTime = "executionsTime"
        case executionsTimeTotal = "executionsTimeTotal"
        case executionsTotal = "executionsTotal"
        case range = "range"
    }

    /// Aggregated number of function builds per period.
    public let builds: [Metric]
    /// Aggregated number of failed builds per period.
    public let buildsFailed: [Metric]
    /// Total aggregated number of failed function builds.
    public let buildsFailedTotal: Int
    /// Aggregated number of function builds mbSeconds per period.
    public let buildsMbSeconds: [Metric]
    /// Total aggregated sum of function builds mbSeconds.
    public let buildsMbSecondsTotal: Int
    /// Aggregated sum of function builds storage per period.
    public let buildsStorage: [Metric]
    /// total aggregated sum of function builds storage.
    public let buildsStorageTotal: Int
    /// Aggregated number of successful builds per period.
    public let buildsSuccess: [Metric]
    /// Total aggregated number of successful function builds.
    public let buildsSuccessTotal: Int
    /// Aggregated sum of function builds compute time per period.
    public let buildsTime: [Metric]
    /// Average builds compute time.
    public let buildsTimeAverage: Int
    /// Total aggregated sum of function builds compute time.
    public let buildsTimeTotal: Int
    /// Total aggregated number of function builds.
    public let buildsTotal: Int
    /// Aggregated number of function deployments per period.
    public let deployments: [Metric]
    /// Aggregated number of  function deployments storage per period.
    public let deploymentsStorage: [Metric]
    /// Total aggregated sum of function deployments storage.
    public let deploymentsStorageTotal: Int
    /// Total aggregated number of function deployments.
    public let deploymentsTotal: Int
    /// Aggregated number of function executions per period.
    public let executions: [Metric]
    /// Aggregated number of function mbSeconds per period.
    public let executionsMbSeconds: [Metric]
    /// Total aggregated sum of function executions mbSeconds.
    public let executionsMbSecondsTotal: Int
    /// Aggregated number of function executions compute time per period.
    public let executionsTime: [Metric]
    /// Total aggregated sum of function  executions compute time.
    public let executionsTimeTotal: Int
    /// Total  aggregated number of function executions.
    public let executionsTotal: Int
    /// The time range of the usage stats.
    public let range: String

    init(
        builds: [Metric],
        buildsFailed: [Metric],
        buildsFailedTotal: Int,
        buildsMbSeconds: [Metric],
        buildsMbSecondsTotal: Int,
        buildsStorage: [Metric],
        buildsStorageTotal: Int,
        buildsSuccess: [Metric],
        buildsSuccessTotal: Int,
        buildsTime: [Metric],
        buildsTimeAverage: Int,
        buildsTimeTotal: Int,
        buildsTotal: Int,
        deployments: [Metric],
        deploymentsStorage: [Metric],
        deploymentsStorageTotal: Int,
        deploymentsTotal: Int,
        executions: [Metric],
        executionsMbSeconds: [Metric],
        executionsMbSecondsTotal: Int,
        executionsTime: [Metric],
        executionsTimeTotal: Int,
        executionsTotal: Int,
        range: String
    ) {
        self.builds = builds
        self.buildsFailed = buildsFailed
        self.buildsFailedTotal = buildsFailedTotal
        self.buildsMbSeconds = buildsMbSeconds
        self.buildsMbSecondsTotal = buildsMbSecondsTotal
        self.buildsStorage = buildsStorage
        self.buildsStorageTotal = buildsStorageTotal
        self.buildsSuccess = buildsSuccess
        self.buildsSuccessTotal = buildsSuccessTotal
        self.buildsTime = buildsTime
        self.buildsTimeAverage = buildsTimeAverage
        self.buildsTimeTotal = buildsTimeTotal
        self.buildsTotal = buildsTotal
        self.deployments = deployments
        self.deploymentsStorage = deploymentsStorage
        self.deploymentsStorageTotal = deploymentsStorageTotal
        self.deploymentsTotal = deploymentsTotal
        self.executions = executions
        self.executionsMbSeconds = executionsMbSeconds
        self.executionsMbSecondsTotal = executionsMbSecondsTotal
        self.executionsTime = executionsTime
        self.executionsTimeTotal = executionsTimeTotal
        self.executionsTotal = executionsTotal
        self.range = range
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.builds = try container.decode([Metric].self, forKey: .builds)
        self.buildsFailed = try container.decode([Metric].self, forKey: .buildsFailed)
        self.buildsFailedTotal = try container.decode(Int.self, forKey: .buildsFailedTotal)
        self.buildsMbSeconds = try container.decode([Metric].self, forKey: .buildsMbSeconds)
        self.buildsMbSecondsTotal = try container.decode(Int.self, forKey: .buildsMbSecondsTotal)
        self.buildsStorage = try container.decode([Metric].self, forKey: .buildsStorage)
        self.buildsStorageTotal = try container.decode(Int.self, forKey: .buildsStorageTotal)
        self.buildsSuccess = try container.decode([Metric].self, forKey: .buildsSuccess)
        self.buildsSuccessTotal = try container.decode(Int.self, forKey: .buildsSuccessTotal)
        self.buildsTime = try container.decode([Metric].self, forKey: .buildsTime)
        self.buildsTimeAverage = try container.decode(Int.self, forKey: .buildsTimeAverage)
        self.buildsTimeTotal = try container.decode(Int.self, forKey: .buildsTimeTotal)
        self.buildsTotal = try container.decode(Int.self, forKey: .buildsTotal)
        self.deployments = try container.decode([Metric].self, forKey: .deployments)
        self.deploymentsStorage = try container.decode([Metric].self, forKey: .deploymentsStorage)
        self.deploymentsStorageTotal = try container.decode(Int.self, forKey: .deploymentsStorageTotal)
        self.deploymentsTotal = try container.decode(Int.self, forKey: .deploymentsTotal)
        self.executions = try container.decode([Metric].self, forKey: .executions)
        self.executionsMbSeconds = try container.decode([Metric].self, forKey: .executionsMbSeconds)
        self.executionsMbSecondsTotal = try container.decode(Int.self, forKey: .executionsMbSecondsTotal)
        self.executionsTime = try container.decode([Metric].self, forKey: .executionsTime)
        self.executionsTimeTotal = try container.decode(Int.self, forKey: .executionsTimeTotal)
        self.executionsTotal = try container.decode(Int.self, forKey: .executionsTotal)
        self.range = try container.decode(String.self, forKey: .range)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(builds, forKey: .builds)
        try container.encode(buildsFailed, forKey: .buildsFailed)
        try container.encode(buildsFailedTotal, forKey: .buildsFailedTotal)
        try container.encode(buildsMbSeconds, forKey: .buildsMbSeconds)
        try container.encode(buildsMbSecondsTotal, forKey: .buildsMbSecondsTotal)
        try container.encode(buildsStorage, forKey: .buildsStorage)
        try container.encode(buildsStorageTotal, forKey: .buildsStorageTotal)
        try container.encode(buildsSuccess, forKey: .buildsSuccess)
        try container.encode(buildsSuccessTotal, forKey: .buildsSuccessTotal)
        try container.encode(buildsTime, forKey: .buildsTime)
        try container.encode(buildsTimeAverage, forKey: .buildsTimeAverage)
        try container.encode(buildsTimeTotal, forKey: .buildsTimeTotal)
        try container.encode(buildsTotal, forKey: .buildsTotal)
        try container.encode(deployments, forKey: .deployments)
        try container.encode(deploymentsStorage, forKey: .deploymentsStorage)
        try container.encode(deploymentsStorageTotal, forKey: .deploymentsStorageTotal)
        try container.encode(deploymentsTotal, forKey: .deploymentsTotal)
        try container.encode(executions, forKey: .executions)
        try container.encode(executionsMbSeconds, forKey: .executionsMbSeconds)
        try container.encode(executionsMbSecondsTotal, forKey: .executionsMbSecondsTotal)
        try container.encode(executionsTime, forKey: .executionsTime)
        try container.encode(executionsTimeTotal, forKey: .executionsTimeTotal)
        try container.encode(executionsTotal, forKey: .executionsTotal)
        try container.encode(range, forKey: .range)
    }

    public func toMap() -> [String: Any] {
        return [
            "builds": builds.map { $0.toMap() } as Any,
            "buildsFailed": buildsFailed.map { $0.toMap() } as Any,
            "buildsFailedTotal": buildsFailedTotal as Any,
            "buildsMbSeconds": buildsMbSeconds.map { $0.toMap() } as Any,
            "buildsMbSecondsTotal": buildsMbSecondsTotal as Any,
            "buildsStorage": buildsStorage.map { $0.toMap() } as Any,
            "buildsStorageTotal": buildsStorageTotal as Any,
            "buildsSuccess": buildsSuccess.map { $0.toMap() } as Any,
            "buildsSuccessTotal": buildsSuccessTotal as Any,
            "buildsTime": buildsTime.map { $0.toMap() } as Any,
            "buildsTimeAverage": buildsTimeAverage as Any,
            "buildsTimeTotal": buildsTimeTotal as Any,
            "buildsTotal": buildsTotal as Any,
            "deployments": deployments.map { $0.toMap() } as Any,
            "deploymentsStorage": deploymentsStorage.map { $0.toMap() } as Any,
            "deploymentsStorageTotal": deploymentsStorageTotal as Any,
            "deploymentsTotal": deploymentsTotal as Any,
            "executions": executions.map { $0.toMap() } as Any,
            "executionsMbSeconds": executionsMbSeconds.map { $0.toMap() } as Any,
            "executionsMbSecondsTotal": executionsMbSecondsTotal as Any,
            "executionsTime": executionsTime.map { $0.toMap() } as Any,
            "executionsTimeTotal": executionsTimeTotal as Any,
            "executionsTotal": executionsTotal as Any,
            "range": range as Any
        ]
    }

    public static func from(map: [String: Any] ) -> UsageFunction {
        return UsageFunction(
            builds: (map["builds"] as! [[String: Any]]).map { Metric.from(map: $0) },
            buildsFailed: (map["buildsFailed"] as! [[String: Any]]).map { Metric.from(map: $0) },
            buildsFailedTotal: map["buildsFailedTotal"] as! Int,
            buildsMbSeconds: (map["buildsMbSeconds"] as! [[String: Any]]).map { Metric.from(map: $0) },
            buildsMbSecondsTotal: map["buildsMbSecondsTotal"] as! Int,
            buildsStorage: (map["buildsStorage"] as! [[String: Any]]).map { Metric.from(map: $0) },
            buildsStorageTotal: map["buildsStorageTotal"] as! Int,
            buildsSuccess: (map["buildsSuccess"] as! [[String: Any]]).map { Metric.from(map: $0) },
            buildsSuccessTotal: map["buildsSuccessTotal"] as! Int,
            buildsTime: (map["buildsTime"] as! [[String: Any]]).map { Metric.from(map: $0) },
            buildsTimeAverage: map["buildsTimeAverage"] as! Int,
            buildsTimeTotal: map["buildsTimeTotal"] as! Int,
            buildsTotal: map["buildsTotal"] as! Int,
            deployments: (map["deployments"] as! [[String: Any]]).map { Metric.from(map: $0) },
            deploymentsStorage: (map["deploymentsStorage"] as! [[String: Any]]).map { Metric.from(map: $0) },
            deploymentsStorageTotal: map["deploymentsStorageTotal"] as! Int,
            deploymentsTotal: map["deploymentsTotal"] as! Int,
            executions: (map["executions"] as! [[String: Any]]).map { Metric.from(map: $0) },
            executionsMbSeconds: (map["executionsMbSeconds"] as! [[String: Any]]).map { Metric.from(map: $0) },
            executionsMbSecondsTotal: map["executionsMbSecondsTotal"] as! Int,
            executionsTime: (map["executionsTime"] as! [[String: Any]]).map { Metric.from(map: $0) },
            executionsTimeTotal: map["executionsTimeTotal"] as! Int,
            executionsTotal: map["executionsTotal"] as! Int,
            range: map["range"] as! String
        )
    }
}
