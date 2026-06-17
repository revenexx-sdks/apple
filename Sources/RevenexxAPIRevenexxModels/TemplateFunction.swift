import Foundation
import JSONCodable

/// Template Function
open class TemplateFunction: Codable {

    enum CodingKeys: String, CodingKey {
        case cron = "cron"
        case events = "events"
        case icon = "icon"
        case id = "id"
        case instructions = "instructions"
        case name = "name"
        case permissions = "permissions"
        case providerOwner = "providerOwner"
        case providerRepositoryId = "providerRepositoryId"
        case providerVersion = "providerVersion"
        case runtimes = "runtimes"
        case scopes = "scopes"
        case tagline = "tagline"
        case timeout = "timeout"
        case useCases = "useCases"
        case variables = "variables"
        case vcsProvider = "vcsProvider"
    }

    /// Function execution schedult in CRON format.
    public let cron: String
    /// Function trigger events.
    public let events: [String]
    /// Function Template Icon.
    public let icon: String
    /// Function Template ID.
    public let id: String
    /// Function Template Instructions.
    public let instructions: String
    /// Function Template Name.
    public let name: String
    /// Execution permissions.
    public let permissions: [String]
    /// VCS (Version Control System) Owner.
    public let providerOwner: String
    /// VCS (Version Control System) Repository ID
    public let providerRepositoryId: String
    /// VCS (Version Control System) branch version (tag).
    public let providerVersion: String
    /// List of runtimes that can be used with this template.
    public let runtimes: [TemplateRuntime]
    /// Function scopes.
    public let scopes: [String]
    /// Function Template Tagline.
    public let tagline: String
    /// Function execution timeout in seconds.
    public let timeout: Int
    /// Function use cases.
    public let useCases: [String]
    /// Function variables.
    public let variables: [TemplateVariable]
    /// VCS (Version Control System) Provider.
    public let vcsProvider: String

    init(
        cron: String,
        events: [String],
        icon: String,
        id: String,
        instructions: String,
        name: String,
        permissions: [String],
        providerOwner: String,
        providerRepositoryId: String,
        providerVersion: String,
        runtimes: [TemplateRuntime],
        scopes: [String],
        tagline: String,
        timeout: Int,
        useCases: [String],
        variables: [TemplateVariable],
        vcsProvider: String
    ) {
        self.cron = cron
        self.events = events
        self.icon = icon
        self.id = id
        self.instructions = instructions
        self.name = name
        self.permissions = permissions
        self.providerOwner = providerOwner
        self.providerRepositoryId = providerRepositoryId
        self.providerVersion = providerVersion
        self.runtimes = runtimes
        self.scopes = scopes
        self.tagline = tagline
        self.timeout = timeout
        self.useCases = useCases
        self.variables = variables
        self.vcsProvider = vcsProvider
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cron = try container.decode(String.self, forKey: .cron)
        self.events = try container.decode([String].self, forKey: .events)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.id = try container.decode(String.self, forKey: .id)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.name = try container.decode(String.self, forKey: .name)
        self.permissions = try container.decode([String].self, forKey: .permissions)
        self.providerOwner = try container.decode(String.self, forKey: .providerOwner)
        self.providerRepositoryId = try container.decode(String.self, forKey: .providerRepositoryId)
        self.providerVersion = try container.decode(String.self, forKey: .providerVersion)
        self.runtimes = try container.decode([TemplateRuntime].self, forKey: .runtimes)
        self.scopes = try container.decode([String].self, forKey: .scopes)
        self.tagline = try container.decode(String.self, forKey: .tagline)
        self.timeout = try container.decode(Int.self, forKey: .timeout)
        self.useCases = try container.decode([String].self, forKey: .useCases)
        self.variables = try container.decode([TemplateVariable].self, forKey: .variables)
        self.vcsProvider = try container.decode(String.self, forKey: .vcsProvider)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(cron, forKey: .cron)
        try container.encode(events, forKey: .events)
        try container.encode(icon, forKey: .icon)
        try container.encode(id, forKey: .id)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(name, forKey: .name)
        try container.encode(permissions, forKey: .permissions)
        try container.encode(providerOwner, forKey: .providerOwner)
        try container.encode(providerRepositoryId, forKey: .providerRepositoryId)
        try container.encode(providerVersion, forKey: .providerVersion)
        try container.encode(runtimes, forKey: .runtimes)
        try container.encode(scopes, forKey: .scopes)
        try container.encode(tagline, forKey: .tagline)
        try container.encode(timeout, forKey: .timeout)
        try container.encode(useCases, forKey: .useCases)
        try container.encode(variables, forKey: .variables)
        try container.encode(vcsProvider, forKey: .vcsProvider)
    }

    public func toMap() -> [String: Any] {
        return [
            "cron": cron as Any,
            "events": events as Any,
            "icon": icon as Any,
            "id": id as Any,
            "instructions": instructions as Any,
            "name": name as Any,
            "permissions": permissions as Any,
            "providerOwner": providerOwner as Any,
            "providerRepositoryId": providerRepositoryId as Any,
            "providerVersion": providerVersion as Any,
            "runtimes": runtimes.map { $0.toMap() } as Any,
            "scopes": scopes as Any,
            "tagline": tagline as Any,
            "timeout": timeout as Any,
            "useCases": useCases as Any,
            "variables": variables.map { $0.toMap() } as Any,
            "vcsProvider": vcsProvider as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TemplateFunction {
        return TemplateFunction(
            cron: map["cron"] as! String,
            events: map["events"] as! [String],
            icon: map["icon"] as! String,
            id: map["id"] as! String,
            instructions: map["instructions"] as! String,
            name: map["name"] as! String,
            permissions: map["permissions"] as! [String],
            providerOwner: map["providerOwner"] as! String,
            providerRepositoryId: map["providerRepositoryId"] as! String,
            providerVersion: map["providerVersion"] as! String,
            runtimes: (map["runtimes"] as! [[String: Any]]).map { TemplateRuntime.from(map: $0) },
            scopes: map["scopes"] as! [String],
            tagline: map["tagline"] as! String,
            timeout: map["timeout"] as! Int,
            useCases: map["useCases"] as! [String],
            variables: (map["variables"] as! [[String: Any]]).map { TemplateVariable.from(map: $0) },
            vcsProvider: map["vcsProvider"] as! String
        )
    }
}
