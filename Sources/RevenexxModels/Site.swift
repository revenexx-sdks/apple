import Foundation
import JSONCodable

/// Site
open class Site: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case adapter = "adapter"
        case buildCommand = "buildCommand"
        case buildRuntime = "buildRuntime"
        case deploymentCreatedAt = "deploymentCreatedAt"
        case deploymentId = "deploymentId"
        case deploymentScreenshotDark = "deploymentScreenshotDark"
        case deploymentScreenshotLight = "deploymentScreenshotLight"
        case enabled = "enabled"
        case fallbackFile = "fallbackFile"
        case framework = "framework"
        case installCommand = "installCommand"
        case installationId = "installationId"
        case latestDeploymentCreatedAt = "latestDeploymentCreatedAt"
        case latestDeploymentId = "latestDeploymentId"
        case latestDeploymentStatus = "latestDeploymentStatus"
        case live = "live"
        case logging = "logging"
        case name = "name"
        case outputDirectory = "outputDirectory"
        case providerBranch = "providerBranch"
        case providerRepositoryId = "providerRepositoryId"
        case providerRootDirectory = "providerRootDirectory"
        case providerSilentMode = "providerSilentMode"
        case specification = "specification"
        case timeout = "timeout"
        case vars = "vars"
    }

    /// Site creation date in ISO 8601 format.
    public let createdAt: String
    /// Site ID.
    public let id: String
    /// Site update date in ISO 8601 format.
    public let updatedAt: String
    /// Site framework adapter.
    public let adapter: String
    /// The build command used to build the site.
    public let buildCommand: String
    /// Site build runtime.
    public let buildRuntime: String
    /// Active deployment creation date in ISO 8601 format.
    public let deploymentCreatedAt: String
    /// Site's active deployment ID.
    public let deploymentId: String
    /// Screenshot of active deployment with dark theme preference file ID.
    public let deploymentScreenshotDark: String
    /// Screenshot of active deployment with light theme preference file ID.
    public let deploymentScreenshotLight: String
    /// Site enabled.
    public let enabled: Bool
    /// Name of the fallback file to serve instead of a 404 page. If null, the site runtime's built-in 404 page is served.
    public let fallbackFile: String
    /// Site framework.
    public let framework: String
    /// The install command used to install the site dependencies.
    public let installCommand: String
    /// Site VCS (Version Control System) installation id.
    public let installationId: String
    /// Latest deployment creation date in ISO 8601 format.
    public let latestDeploymentCreatedAt: String
    /// Site's latest deployment ID.
    public let latestDeploymentId: String
    /// Status of latest deployment. Possible values are "waiting", "processing", "building", "ready", and "failed".
    public let latestDeploymentStatus: String
    /// Is the site deployed with the latest configuration? This is set to false if you've changed an environment variables, entrypoint, commands, or other settings that needs redeploy to be applied. When the value is false, redeploy the site to update it with the latest configuration.
    public let live: Bool
    /// When disabled, request logs will exclude logs and errors, and site responses will be slightly faster.
    public let logging: Bool
    /// Site name.
    public let name: String
    /// The directory where the site build output is located.
    public let outputDirectory: String
    /// VCS (Version Control System) branch name
    public let providerBranch: String
    /// VCS (Version Control System) Repository ID
    public let providerRepositoryId: String
    /// Path to site in VCS (Version Control System) repository
    public let providerRootDirectory: String
    /// Is VCS (Version Control System) connection is in silent mode? When in silence mode, no comments will be posted on the repository pull or merge requests
    public let providerSilentMode: Bool
    /// Machine specification for builds and executions.
    public let specification: String
    /// Site request timeout in seconds.
    public let timeout: Int
    /// Site variables.
    public let vars: [Variable]

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        adapter: String,
        buildCommand: String,
        buildRuntime: String,
        deploymentCreatedAt: String,
        deploymentId: String,
        deploymentScreenshotDark: String,
        deploymentScreenshotLight: String,
        enabled: Bool,
        fallbackFile: String,
        framework: String,
        installCommand: String,
        installationId: String,
        latestDeploymentCreatedAt: String,
        latestDeploymentId: String,
        latestDeploymentStatus: String,
        live: Bool,
        logging: Bool,
        name: String,
        outputDirectory: String,
        providerBranch: String,
        providerRepositoryId: String,
        providerRootDirectory: String,
        providerSilentMode: Bool,
        specification: String,
        timeout: Int,
        vars: [Variable]
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.adapter = adapter
        self.buildCommand = buildCommand
        self.buildRuntime = buildRuntime
        self.deploymentCreatedAt = deploymentCreatedAt
        self.deploymentId = deploymentId
        self.deploymentScreenshotDark = deploymentScreenshotDark
        self.deploymentScreenshotLight = deploymentScreenshotLight
        self.enabled = enabled
        self.fallbackFile = fallbackFile
        self.framework = framework
        self.installCommand = installCommand
        self.installationId = installationId
        self.latestDeploymentCreatedAt = latestDeploymentCreatedAt
        self.latestDeploymentId = latestDeploymentId
        self.latestDeploymentStatus = latestDeploymentStatus
        self.live = live
        self.logging = logging
        self.name = name
        self.outputDirectory = outputDirectory
        self.providerBranch = providerBranch
        self.providerRepositoryId = providerRepositoryId
        self.providerRootDirectory = providerRootDirectory
        self.providerSilentMode = providerSilentMode
        self.specification = specification
        self.timeout = timeout
        self.vars = vars
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.adapter = try container.decode(String.self, forKey: .adapter)
        self.buildCommand = try container.decode(String.self, forKey: .buildCommand)
        self.buildRuntime = try container.decode(String.self, forKey: .buildRuntime)
        self.deploymentCreatedAt = try container.decode(String.self, forKey: .deploymentCreatedAt)
        self.deploymentId = try container.decode(String.self, forKey: .deploymentId)
        self.deploymentScreenshotDark = try container.decode(String.self, forKey: .deploymentScreenshotDark)
        self.deploymentScreenshotLight = try container.decode(String.self, forKey: .deploymentScreenshotLight)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.fallbackFile = try container.decode(String.self, forKey: .fallbackFile)
        self.framework = try container.decode(String.self, forKey: .framework)
        self.installCommand = try container.decode(String.self, forKey: .installCommand)
        self.installationId = try container.decode(String.self, forKey: .installationId)
        self.latestDeploymentCreatedAt = try container.decode(String.self, forKey: .latestDeploymentCreatedAt)
        self.latestDeploymentId = try container.decode(String.self, forKey: .latestDeploymentId)
        self.latestDeploymentStatus = try container.decode(String.self, forKey: .latestDeploymentStatus)
        self.live = try container.decode(Bool.self, forKey: .live)
        self.logging = try container.decode(Bool.self, forKey: .logging)
        self.name = try container.decode(String.self, forKey: .name)
        self.outputDirectory = try container.decode(String.self, forKey: .outputDirectory)
        self.providerBranch = try container.decode(String.self, forKey: .providerBranch)
        self.providerRepositoryId = try container.decode(String.self, forKey: .providerRepositoryId)
        self.providerRootDirectory = try container.decode(String.self, forKey: .providerRootDirectory)
        self.providerSilentMode = try container.decode(Bool.self, forKey: .providerSilentMode)
        self.specification = try container.decode(String.self, forKey: .specification)
        self.timeout = try container.decode(Int.self, forKey: .timeout)
        self.vars = try container.decode([Variable].self, forKey: .vars)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(adapter, forKey: .adapter)
        try container.encode(buildCommand, forKey: .buildCommand)
        try container.encode(buildRuntime, forKey: .buildRuntime)
        try container.encode(deploymentCreatedAt, forKey: .deploymentCreatedAt)
        try container.encode(deploymentId, forKey: .deploymentId)
        try container.encode(deploymentScreenshotDark, forKey: .deploymentScreenshotDark)
        try container.encode(deploymentScreenshotLight, forKey: .deploymentScreenshotLight)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(fallbackFile, forKey: .fallbackFile)
        try container.encode(framework, forKey: .framework)
        try container.encode(installCommand, forKey: .installCommand)
        try container.encode(installationId, forKey: .installationId)
        try container.encode(latestDeploymentCreatedAt, forKey: .latestDeploymentCreatedAt)
        try container.encode(latestDeploymentId, forKey: .latestDeploymentId)
        try container.encode(latestDeploymentStatus, forKey: .latestDeploymentStatus)
        try container.encode(live, forKey: .live)
        try container.encode(logging, forKey: .logging)
        try container.encode(name, forKey: .name)
        try container.encode(outputDirectory, forKey: .outputDirectory)
        try container.encode(providerBranch, forKey: .providerBranch)
        try container.encode(providerRepositoryId, forKey: .providerRepositoryId)
        try container.encode(providerRootDirectory, forKey: .providerRootDirectory)
        try container.encode(providerSilentMode, forKey: .providerSilentMode)
        try container.encode(specification, forKey: .specification)
        try container.encode(timeout, forKey: .timeout)
        try container.encode(vars, forKey: .vars)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "adapter": adapter as Any,
            "buildCommand": buildCommand as Any,
            "buildRuntime": buildRuntime as Any,
            "deploymentCreatedAt": deploymentCreatedAt as Any,
            "deploymentId": deploymentId as Any,
            "deploymentScreenshotDark": deploymentScreenshotDark as Any,
            "deploymentScreenshotLight": deploymentScreenshotLight as Any,
            "enabled": enabled as Any,
            "fallbackFile": fallbackFile as Any,
            "framework": framework as Any,
            "installCommand": installCommand as Any,
            "installationId": installationId as Any,
            "latestDeploymentCreatedAt": latestDeploymentCreatedAt as Any,
            "latestDeploymentId": latestDeploymentId as Any,
            "latestDeploymentStatus": latestDeploymentStatus as Any,
            "live": live as Any,
            "logging": logging as Any,
            "name": name as Any,
            "outputDirectory": outputDirectory as Any,
            "providerBranch": providerBranch as Any,
            "providerRepositoryId": providerRepositoryId as Any,
            "providerRootDirectory": providerRootDirectory as Any,
            "providerSilentMode": providerSilentMode as Any,
            "specification": specification as Any,
            "timeout": timeout as Any,
            "vars": vars.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Site {
        return Site(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            adapter: map["adapter"] as! String,
            buildCommand: map["buildCommand"] as! String,
            buildRuntime: map["buildRuntime"] as! String,
            deploymentCreatedAt: map["deploymentCreatedAt"] as! String,
            deploymentId: map["deploymentId"] as! String,
            deploymentScreenshotDark: map["deploymentScreenshotDark"] as! String,
            deploymentScreenshotLight: map["deploymentScreenshotLight"] as! String,
            enabled: map["enabled"] as! Bool,
            fallbackFile: map["fallbackFile"] as! String,
            framework: map["framework"] as! String,
            installCommand: map["installCommand"] as! String,
            installationId: map["installationId"] as! String,
            latestDeploymentCreatedAt: map["latestDeploymentCreatedAt"] as! String,
            latestDeploymentId: map["latestDeploymentId"] as! String,
            latestDeploymentStatus: map["latestDeploymentStatus"] as! String,
            live: map["live"] as! Bool,
            logging: map["logging"] as! Bool,
            name: map["name"] as! String,
            outputDirectory: map["outputDirectory"] as! String,
            providerBranch: map["providerBranch"] as! String,
            providerRepositoryId: map["providerRepositoryId"] as! String,
            providerRootDirectory: map["providerRootDirectory"] as! String,
            providerSilentMode: map["providerSilentMode"] as! Bool,
            specification: map["specification"] as! String,
            timeout: map["timeout"] as! Int,
            vars: (map["vars"] as! [[String: Any]]).map { Variable.from(map: $0) }
        )
    }
}
