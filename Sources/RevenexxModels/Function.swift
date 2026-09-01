import Foundation
import JSONCodable

/// Function
open class Function: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case commands = "commands"
        case deploymentCreatedAt = "deploymentCreatedAt"
        case deploymentId = "deploymentId"
        case enabled = "enabled"
        case entrypoint = "entrypoint"
        case events = "events"
        case execute = "execute"
        case installationId = "installationId"
        case latestDeploymentCreatedAt = "latestDeploymentCreatedAt"
        case latestDeploymentId = "latestDeploymentId"
        case latestDeploymentStatus = "latestDeploymentStatus"
        case live = "live"
        case logging = "logging"
        case name = "name"
        case providerBranch = "providerBranch"
        case providerRepositoryId = "providerRepositoryId"
        case providerRootDirectory = "providerRootDirectory"
        case providerSilentMode = "providerSilentMode"
        case runtime = "runtime"
        case schedule = "schedule"
        case scopes = "scopes"
        case specification = "specification"
        case timeout = "timeout"
        case vars = "vars"
        case version = "version"
    }

    /// Function creation date in ISO 8601 format.
    public let createdAt: String
    /// Function ID.
    public let id: String
    /// Function update date in ISO 8601 format.
    public let updatedAt: String
    /// The build command used to build the deployment.
    public let commands: String
    /// Active deployment creation date in ISO 8601 format.
    public let deploymentCreatedAt: String
    /// Function's active deployment ID.
    public let deploymentId: String
    /// Function enabled.
    public let enabled: Bool
    /// The entrypoint file used to execute the deployment.
    public let entrypoint: String
    /// Function trigger events.
    public let events: [String]
    /// Execution permissions.
    public let execute: [String]
    /// Function VCS (Version Control System) installation id.
    public let installationId: String
    /// Latest deployment creation date in ISO 8601 format.
    public let latestDeploymentCreatedAt: String
    /// Function's latest deployment ID.
    public let latestDeploymentId: String
    /// Status of latest deployment. Possible values are "waiting", "processing", "building", "ready", and "failed".
    public let latestDeploymentStatus: String
    /// Is the function deployed with the latest configuration? This is set to false if you've changed an environment variables, entrypoint, commands, or other settings that needs redeploy to be applied. When the value is false, redeploy the function to update it with the latest configuration.
    public let live: Bool
    /// When disabled, executions will exclude logs and errors, and will be slightly faster.
    public let logging: Bool
    /// Function name.
    public let name: String
    /// VCS (Version Control System) branch name
    public let providerBranch: String
    /// VCS (Version Control System) Repository ID
    public let providerRepositoryId: String
    /// Path to function in VCS (Version Control System) repository
    public let providerRootDirectory: String
    /// Is VCS (Version Control System) connection is in silent mode? When in silence mode, no comments will be posted on the repository pull or merge requests
    public let providerSilentMode: Bool
    /// Function execution and build runtime.
    public let runtime: String
    /// Function execution schedule in CRON format.
    public let schedule: String
    /// Allowed permission scopes.
    public let scopes: [String]
    /// Machine specification for builds and executions.
    public let specification: String
    /// Function execution timeout in seconds.
    public let timeout: Int
    /// Function variables.
    public let vars: [Variable]
    /// Version of Open Runtimes used for the function.
    public let version: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        commands: String,
        deploymentCreatedAt: String,
        deploymentId: String,
        enabled: Bool,
        entrypoint: String,
        events: [String],
        execute: [String],
        installationId: String,
        latestDeploymentCreatedAt: String,
        latestDeploymentId: String,
        latestDeploymentStatus: String,
        live: Bool,
        logging: Bool,
        name: String,
        providerBranch: String,
        providerRepositoryId: String,
        providerRootDirectory: String,
        providerSilentMode: Bool,
        runtime: String,
        schedule: String,
        scopes: [String],
        specification: String,
        timeout: Int,
        vars: [Variable],
        version: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.commands = commands
        self.deploymentCreatedAt = deploymentCreatedAt
        self.deploymentId = deploymentId
        self.enabled = enabled
        self.entrypoint = entrypoint
        self.events = events
        self.execute = execute
        self.installationId = installationId
        self.latestDeploymentCreatedAt = latestDeploymentCreatedAt
        self.latestDeploymentId = latestDeploymentId
        self.latestDeploymentStatus = latestDeploymentStatus
        self.live = live
        self.logging = logging
        self.name = name
        self.providerBranch = providerBranch
        self.providerRepositoryId = providerRepositoryId
        self.providerRootDirectory = providerRootDirectory
        self.providerSilentMode = providerSilentMode
        self.runtime = runtime
        self.schedule = schedule
        self.scopes = scopes
        self.specification = specification
        self.timeout = timeout
        self.vars = vars
        self.version = version
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.commands = try container.decode(String.self, forKey: .commands)
        self.deploymentCreatedAt = try container.decode(String.self, forKey: .deploymentCreatedAt)
        self.deploymentId = try container.decode(String.self, forKey: .deploymentId)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.entrypoint = try container.decode(String.self, forKey: .entrypoint)
        self.events = try container.decode([String].self, forKey: .events)
        self.execute = try container.decode([String].self, forKey: .execute)
        self.installationId = try container.decode(String.self, forKey: .installationId)
        self.latestDeploymentCreatedAt = try container.decode(String.self, forKey: .latestDeploymentCreatedAt)
        self.latestDeploymentId = try container.decode(String.self, forKey: .latestDeploymentId)
        self.latestDeploymentStatus = try container.decode(String.self, forKey: .latestDeploymentStatus)
        self.live = try container.decode(Bool.self, forKey: .live)
        self.logging = try container.decode(Bool.self, forKey: .logging)
        self.name = try container.decode(String.self, forKey: .name)
        self.providerBranch = try container.decode(String.self, forKey: .providerBranch)
        self.providerRepositoryId = try container.decode(String.self, forKey: .providerRepositoryId)
        self.providerRootDirectory = try container.decode(String.self, forKey: .providerRootDirectory)
        self.providerSilentMode = try container.decode(Bool.self, forKey: .providerSilentMode)
        self.runtime = try container.decode(String.self, forKey: .runtime)
        self.schedule = try container.decode(String.self, forKey: .schedule)
        self.scopes = try container.decode([String].self, forKey: .scopes)
        self.specification = try container.decode(String.self, forKey: .specification)
        self.timeout = try container.decode(Int.self, forKey: .timeout)
        self.vars = try container.decode([Variable].self, forKey: .vars)
        self.version = try container.decode(String.self, forKey: .version)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(commands, forKey: .commands)
        try container.encode(deploymentCreatedAt, forKey: .deploymentCreatedAt)
        try container.encode(deploymentId, forKey: .deploymentId)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(entrypoint, forKey: .entrypoint)
        try container.encode(events, forKey: .events)
        try container.encode(execute, forKey: .execute)
        try container.encode(installationId, forKey: .installationId)
        try container.encode(latestDeploymentCreatedAt, forKey: .latestDeploymentCreatedAt)
        try container.encode(latestDeploymentId, forKey: .latestDeploymentId)
        try container.encode(latestDeploymentStatus, forKey: .latestDeploymentStatus)
        try container.encode(live, forKey: .live)
        try container.encode(logging, forKey: .logging)
        try container.encode(name, forKey: .name)
        try container.encode(providerBranch, forKey: .providerBranch)
        try container.encode(providerRepositoryId, forKey: .providerRepositoryId)
        try container.encode(providerRootDirectory, forKey: .providerRootDirectory)
        try container.encode(providerSilentMode, forKey: .providerSilentMode)
        try container.encode(runtime, forKey: .runtime)
        try container.encode(schedule, forKey: .schedule)
        try container.encode(scopes, forKey: .scopes)
        try container.encode(specification, forKey: .specification)
        try container.encode(timeout, forKey: .timeout)
        try container.encode(vars, forKey: .vars)
        try container.encode(version, forKey: .version)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "commands": commands as Any,
            "deploymentCreatedAt": deploymentCreatedAt as Any,
            "deploymentId": deploymentId as Any,
            "enabled": enabled as Any,
            "entrypoint": entrypoint as Any,
            "events": events as Any,
            "execute": execute as Any,
            "installationId": installationId as Any,
            "latestDeploymentCreatedAt": latestDeploymentCreatedAt as Any,
            "latestDeploymentId": latestDeploymentId as Any,
            "latestDeploymentStatus": latestDeploymentStatus as Any,
            "live": live as Any,
            "logging": logging as Any,
            "name": name as Any,
            "providerBranch": providerBranch as Any,
            "providerRepositoryId": providerRepositoryId as Any,
            "providerRootDirectory": providerRootDirectory as Any,
            "providerSilentMode": providerSilentMode as Any,
            "runtime": runtime as Any,
            "schedule": schedule as Any,
            "scopes": scopes as Any,
            "specification": specification as Any,
            "timeout": timeout as Any,
            "vars": vars.map { $0.toMap() } as Any,
            "version": version as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Function {
        return Function(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            commands: map["commands"] as! String,
            deploymentCreatedAt: map["deploymentCreatedAt"] as! String,
            deploymentId: map["deploymentId"] as! String,
            enabled: map["enabled"] as! Bool,
            entrypoint: map["entrypoint"] as! String,
            events: map["events"] as! [String],
            execute: map["execute"] as! [String],
            installationId: map["installationId"] as! String,
            latestDeploymentCreatedAt: map["latestDeploymentCreatedAt"] as! String,
            latestDeploymentId: map["latestDeploymentId"] as! String,
            latestDeploymentStatus: map["latestDeploymentStatus"] as! String,
            live: map["live"] as! Bool,
            logging: map["logging"] as! Bool,
            name: map["name"] as! String,
            providerBranch: map["providerBranch"] as! String,
            providerRepositoryId: map["providerRepositoryId"] as! String,
            providerRootDirectory: map["providerRootDirectory"] as! String,
            providerSilentMode: map["providerSilentMode"] as! Bool,
            runtime: map["runtime"] as! String,
            schedule: map["schedule"] as! String,
            scopes: map["scopes"] as! [String],
            specification: map["specification"] as! String,
            timeout: map["timeout"] as! Int,
            vars: (map["vars"] as! [[String: Any]]).map { Variable.from(map: $0) },
            version: map["version"] as! String
        )
    }
}
