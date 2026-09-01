import Foundation
import JSONCodable
import RevenexxEnums

/// Deployment
open class Deployment: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case activate = "activate"
        case billingJson = "billingJson"
        case buildDuration = "buildDuration"
        case buildId = "buildId"
        case buildLogs = "buildLogs"
        case buildSize = "buildSize"
        case entrypoint = "entrypoint"
        case manifestJson = "manifestJson"
        case providerBranch = "providerBranch"
        case providerBranchUrl = "providerBranchUrl"
        case providerCommitAuthor = "providerCommitAuthor"
        case providerCommitAuthorUrl = "providerCommitAuthorUrl"
        case providerCommitHash = "providerCommitHash"
        case providerCommitMessage = "providerCommitMessage"
        case providerCommitUrl = "providerCommitUrl"
        case providerRepositoryName = "providerRepositoryName"
        case providerRepositoryOwner = "providerRepositoryOwner"
        case providerRepositoryUrl = "providerRepositoryUrl"
        case resourceId = "resourceId"
        case resourceType = "resourceType"
        case screenshotDark = "screenshotDark"
        case screenshotLight = "screenshotLight"
        case sourceSize = "sourceSize"
        case status = "status"
        case totalSize = "totalSize"
        case type = "type"
    }

    /// Deployment creation date in ISO 8601 format.
    public let createdAt: String
    /// Deployment ID.
    public let id: String
    /// Deployment update date in ISO 8601 format.
    public let updatedAt: String
    /// Whether the deployment should be automatically activated.
    public let activate: Bool
    /// Raw billing.json bytes captured from the source archive at deploy time. Empty when no billing.json was shipped (private app).
    public let billingJson: String
    /// The current build time in seconds.
    public let buildDuration: Int
    /// The current build ID.
    public let buildId: String
    /// The build logs.
    public let buildLogs: String
    /// The build output size in bytes.
    public let buildSize: Int
    /// The entrypoint file to use to execute the deployment code.
    public let entrypoint: String
    /// Raw manifest.json bytes captured from the source archive at deploy time. Empty for legacy Function/Site deployments without a manifest.
    public let manifestJson: String
    /// The branch of the vcs repository
    public let providerBranch: String
    /// The branch of the vcs repository
    public let providerBranchUrl: String
    /// The name of vcs commit author
    public let providerCommitAuthor: String
    /// The url of vcs commit author
    public let providerCommitAuthorUrl: String
    /// The commit hash of the vcs commit
    public let providerCommitHash: String
    /// The commit message
    public let providerCommitMessage: String
    /// The url of the vcs commit
    public let providerCommitUrl: String
    /// The name of the vcs provider repository
    public let providerRepositoryName: String
    /// The name of the vcs provider repository owner
    public let providerRepositoryOwner: String
    /// The url of the vcs provider repository
    public let providerRepositoryUrl: String
    /// Resource ID.
    public let resourceId: String
    /// Resource type.
    public let resourceType: String
    /// Screenshot with dark theme preference file ID.
    public let screenshotDark: String
    /// Screenshot with light theme preference file ID.
    public let screenshotLight: String
    /// The code size in bytes.
    public let sourceSize: Int
    /// The deployment status. Possible values are "waiting", "processing", "building", "ready", "canceled" and "failed".
    public let status: RevenexxEnums.DeploymentStatus
    /// The total size in bytes (source and build output).
    public let totalSize: Int
    /// Type of deployment.
    public let type: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        activate: Bool,
        billingJson: String,
        buildDuration: Int,
        buildId: String,
        buildLogs: String,
        buildSize: Int,
        entrypoint: String,
        manifestJson: String,
        providerBranch: String,
        providerBranchUrl: String,
        providerCommitAuthor: String,
        providerCommitAuthorUrl: String,
        providerCommitHash: String,
        providerCommitMessage: String,
        providerCommitUrl: String,
        providerRepositoryName: String,
        providerRepositoryOwner: String,
        providerRepositoryUrl: String,
        resourceId: String,
        resourceType: String,
        screenshotDark: String,
        screenshotLight: String,
        sourceSize: Int,
        status: RevenexxEnums.DeploymentStatus,
        totalSize: Int,
        type: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.activate = activate
        self.billingJson = billingJson
        self.buildDuration = buildDuration
        self.buildId = buildId
        self.buildLogs = buildLogs
        self.buildSize = buildSize
        self.entrypoint = entrypoint
        self.manifestJson = manifestJson
        self.providerBranch = providerBranch
        self.providerBranchUrl = providerBranchUrl
        self.providerCommitAuthor = providerCommitAuthor
        self.providerCommitAuthorUrl = providerCommitAuthorUrl
        self.providerCommitHash = providerCommitHash
        self.providerCommitMessage = providerCommitMessage
        self.providerCommitUrl = providerCommitUrl
        self.providerRepositoryName = providerRepositoryName
        self.providerRepositoryOwner = providerRepositoryOwner
        self.providerRepositoryUrl = providerRepositoryUrl
        self.resourceId = resourceId
        self.resourceType = resourceType
        self.screenshotDark = screenshotDark
        self.screenshotLight = screenshotLight
        self.sourceSize = sourceSize
        self.status = status
        self.totalSize = totalSize
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.activate = try container.decode(Bool.self, forKey: .activate)
        self.billingJson = try container.decode(String.self, forKey: .billingJson)
        self.buildDuration = try container.decode(Int.self, forKey: .buildDuration)
        self.buildId = try container.decode(String.self, forKey: .buildId)
        self.buildLogs = try container.decode(String.self, forKey: .buildLogs)
        self.buildSize = try container.decode(Int.self, forKey: .buildSize)
        self.entrypoint = try container.decode(String.self, forKey: .entrypoint)
        self.manifestJson = try container.decode(String.self, forKey: .manifestJson)
        self.providerBranch = try container.decode(String.self, forKey: .providerBranch)
        self.providerBranchUrl = try container.decode(String.self, forKey: .providerBranchUrl)
        self.providerCommitAuthor = try container.decode(String.self, forKey: .providerCommitAuthor)
        self.providerCommitAuthorUrl = try container.decode(String.self, forKey: .providerCommitAuthorUrl)
        self.providerCommitHash = try container.decode(String.self, forKey: .providerCommitHash)
        self.providerCommitMessage = try container.decode(String.self, forKey: .providerCommitMessage)
        self.providerCommitUrl = try container.decode(String.self, forKey: .providerCommitUrl)
        self.providerRepositoryName = try container.decode(String.self, forKey: .providerRepositoryName)
        self.providerRepositoryOwner = try container.decode(String.self, forKey: .providerRepositoryOwner)
        self.providerRepositoryUrl = try container.decode(String.self, forKey: .providerRepositoryUrl)
        self.resourceId = try container.decode(String.self, forKey: .resourceId)
        self.resourceType = try container.decode(String.self, forKey: .resourceType)
        self.screenshotDark = try container.decode(String.self, forKey: .screenshotDark)
        self.screenshotLight = try container.decode(String.self, forKey: .screenshotLight)
        self.sourceSize = try container.decode(Int.self, forKey: .sourceSize)
        self.status = RevenexxEnums.DeploymentStatus(rawValue: try container.decode(String.self, forKey: .status))!
        self.totalSize = try container.decode(Int.self, forKey: .totalSize)
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(activate, forKey: .activate)
        try container.encode(billingJson, forKey: .billingJson)
        try container.encode(buildDuration, forKey: .buildDuration)
        try container.encode(buildId, forKey: .buildId)
        try container.encode(buildLogs, forKey: .buildLogs)
        try container.encode(buildSize, forKey: .buildSize)
        try container.encode(entrypoint, forKey: .entrypoint)
        try container.encode(manifestJson, forKey: .manifestJson)
        try container.encode(providerBranch, forKey: .providerBranch)
        try container.encode(providerBranchUrl, forKey: .providerBranchUrl)
        try container.encode(providerCommitAuthor, forKey: .providerCommitAuthor)
        try container.encode(providerCommitAuthorUrl, forKey: .providerCommitAuthorUrl)
        try container.encode(providerCommitHash, forKey: .providerCommitHash)
        try container.encode(providerCommitMessage, forKey: .providerCommitMessage)
        try container.encode(providerCommitUrl, forKey: .providerCommitUrl)
        try container.encode(providerRepositoryName, forKey: .providerRepositoryName)
        try container.encode(providerRepositoryOwner, forKey: .providerRepositoryOwner)
        try container.encode(providerRepositoryUrl, forKey: .providerRepositoryUrl)
        try container.encode(resourceId, forKey: .resourceId)
        try container.encode(resourceType, forKey: .resourceType)
        try container.encode(screenshotDark, forKey: .screenshotDark)
        try container.encode(screenshotLight, forKey: .screenshotLight)
        try container.encode(sourceSize, forKey: .sourceSize)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(totalSize, forKey: .totalSize)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "activate": activate as Any,
            "billingJson": billingJson as Any,
            "buildDuration": buildDuration as Any,
            "buildId": buildId as Any,
            "buildLogs": buildLogs as Any,
            "buildSize": buildSize as Any,
            "entrypoint": entrypoint as Any,
            "manifestJson": manifestJson as Any,
            "providerBranch": providerBranch as Any,
            "providerBranchUrl": providerBranchUrl as Any,
            "providerCommitAuthor": providerCommitAuthor as Any,
            "providerCommitAuthorUrl": providerCommitAuthorUrl as Any,
            "providerCommitHash": providerCommitHash as Any,
            "providerCommitMessage": providerCommitMessage as Any,
            "providerCommitUrl": providerCommitUrl as Any,
            "providerRepositoryName": providerRepositoryName as Any,
            "providerRepositoryOwner": providerRepositoryOwner as Any,
            "providerRepositoryUrl": providerRepositoryUrl as Any,
            "resourceId": resourceId as Any,
            "resourceType": resourceType as Any,
            "screenshotDark": screenshotDark as Any,
            "screenshotLight": screenshotLight as Any,
            "sourceSize": sourceSize as Any,
            "status": status.rawValue as Any,
            "totalSize": totalSize as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Deployment {
        return Deployment(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            activate: map["activate"] as! Bool,
            billingJson: map["billingJson"] as! String,
            buildDuration: map["buildDuration"] as! Int,
            buildId: map["buildId"] as! String,
            buildLogs: map["buildLogs"] as! String,
            buildSize: map["buildSize"] as! Int,
            entrypoint: map["entrypoint"] as! String,
            manifestJson: map["manifestJson"] as! String,
            providerBranch: map["providerBranch"] as! String,
            providerBranchUrl: map["providerBranchUrl"] as! String,
            providerCommitAuthor: map["providerCommitAuthor"] as! String,
            providerCommitAuthorUrl: map["providerCommitAuthorUrl"] as! String,
            providerCommitHash: map["providerCommitHash"] as! String,
            providerCommitMessage: map["providerCommitMessage"] as! String,
            providerCommitUrl: map["providerCommitUrl"] as! String,
            providerRepositoryName: map["providerRepositoryName"] as! String,
            providerRepositoryOwner: map["providerRepositoryOwner"] as! String,
            providerRepositoryUrl: map["providerRepositoryUrl"] as! String,
            resourceId: map["resourceId"] as! String,
            resourceType: map["resourceType"] as! String,
            screenshotDark: map["screenshotDark"] as! String,
            screenshotLight: map["screenshotLight"] as! String,
            sourceSize: map["sourceSize"] as! Int,
            status: DeploymentStatus(rawValue: map["status"] as! String)!,
            totalSize: map["totalSize"] as! Int,
            type: map["type"] as! String
        )
    }
}
