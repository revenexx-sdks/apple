import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// Execution
open class Execution: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case permissions = "$permissions"
        case updatedAt = "$updatedAt"
        case deploymentId = "deploymentId"
        case duration = "duration"
        case errors = "errors"
        case functionId = "functionId"
        case logs = "logs"
        case requestHeaders = "requestHeaders"
        case requestMethod = "requestMethod"
        case requestPath = "requestPath"
        case responseBody = "responseBody"
        case responseHeaders = "responseHeaders"
        case responseStatusCode = "responseStatusCode"
        case scheduledAt = "scheduledAt"
        case status = "status"
        case trigger = "trigger"
    }

    /// Execution creation date in ISO 8601 format.
    public let createdAt: String
    /// Execution ID.
    public let id: String
    /// Execution roles.
    public let permissions: [String]
    /// Execution update date in ISO 8601 format.
    public let updatedAt: String
    /// Function&#039;s deployment ID used to create the execution.
    public let deploymentId: String
    /// Resource(function/site) execution duration in seconds.
    public let duration: Double
    /// Function errors. Includes the last 4,000 characters. This will return an empty string unless the response is returned using an API key or as part of a webhook payload.
    public let errors: String
    /// Function ID.
    public let functionId: String
    /// Function logs. Includes the last 4,000 characters. This will return an empty string unless the response is returned using an API key or as part of a webhook payload.
    public let logs: String
    /// HTTP request headers as a key-value object. This will return only whitelisted headers. All headers are returned if execution is created as synchronous.
    public let requestHeaders: [Headers]
    /// HTTP request method type.
    public let requestMethod: String
    /// HTTP request path and query.
    public let requestPath: String
    /// HTTP response body. This will return empty unless execution is created as synchronous.
    public let responseBody: String
    /// HTTP response headers as a key-value object. This will return only whitelisted headers. All headers are returned if execution is created as synchronous.
    public let responseHeaders: [Headers]
    /// HTTP response status code.
    public let responseStatusCode: Int
    /// The scheduled time for execution. If left empty, execution will be queued immediately.
    public let scheduledAt: String?
    /// The status of the function execution. Possible values can be: `waiting`, `processing`, `completed`, `failed`, or `scheduled`.
    public let status: Revenexx API — revenexxEnums.ExecutionStatus
    /// The trigger that caused the function to execute. Possible values can be: `http`, `schedule`, or `event`.
    public let trigger: Revenexx API — revenexxEnums.ExecutionTrigger

    init(
        createdAt: String,
        id: String,
        permissions: [String],
        updatedAt: String,
        deploymentId: String,
        duration: Double,
        errors: String,
        functionId: String,
        logs: String,
        requestHeaders: [Headers],
        requestMethod: String,
        requestPath: String,
        responseBody: String,
        responseHeaders: [Headers],
        responseStatusCode: Int,
        scheduledAt: String?,
        status: Revenexx API — revenexxEnums.ExecutionStatus,
        trigger: Revenexx API — revenexxEnums.ExecutionTrigger
    ) {
        self.createdAt = createdAt
        self.id = id
        self.permissions = permissions
        self.updatedAt = updatedAt
        self.deploymentId = deploymentId
        self.duration = duration
        self.errors = errors
        self.functionId = functionId
        self.logs = logs
        self.requestHeaders = requestHeaders
        self.requestMethod = requestMethod
        self.requestPath = requestPath
        self.responseBody = responseBody
        self.responseHeaders = responseHeaders
        self.responseStatusCode = responseStatusCode
        self.scheduledAt = scheduledAt
        self.status = status
        self.trigger = trigger
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.permissions = try container.decode([String].self, forKey: .permissions)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.deploymentId = try container.decode(String.self, forKey: .deploymentId)
        self.duration = try container.decode(Double.self, forKey: .duration)
        self.errors = try container.decode(String.self, forKey: .errors)
        self.functionId = try container.decode(String.self, forKey: .functionId)
        self.logs = try container.decode(String.self, forKey: .logs)
        self.requestHeaders = try container.decode([Headers].self, forKey: .requestHeaders)
        self.requestMethod = try container.decode(String.self, forKey: .requestMethod)
        self.requestPath = try container.decode(String.self, forKey: .requestPath)
        self.responseBody = try container.decode(String.self, forKey: .responseBody)
        self.responseHeaders = try container.decode([Headers].self, forKey: .responseHeaders)
        self.responseStatusCode = try container.decode(Int.self, forKey: .responseStatusCode)
        self.scheduledAt = try container.decodeIfPresent(String.self, forKey: .scheduledAt)
        self.status = Revenexx API — revenexxEnums.ExecutionStatus(rawValue: try container.decode(String.self, forKey: .status))!
        self.trigger = Revenexx API — revenexxEnums.ExecutionTrigger(rawValue: try container.decode(String.self, forKey: .trigger))!
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(permissions, forKey: .permissions)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(deploymentId, forKey: .deploymentId)
        try container.encode(duration, forKey: .duration)
        try container.encode(errors, forKey: .errors)
        try container.encode(functionId, forKey: .functionId)
        try container.encode(logs, forKey: .logs)
        try container.encode(requestHeaders, forKey: .requestHeaders)
        try container.encode(requestMethod, forKey: .requestMethod)
        try container.encode(requestPath, forKey: .requestPath)
        try container.encode(responseBody, forKey: .responseBody)
        try container.encode(responseHeaders, forKey: .responseHeaders)
        try container.encode(responseStatusCode, forKey: .responseStatusCode)
        try container.encodeIfPresent(scheduledAt, forKey: .scheduledAt)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(trigger.rawValue, forKey: .trigger)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$permissions": permissions as Any,
            "$updatedAt": updatedAt as Any,
            "deploymentId": deploymentId as Any,
            "duration": duration as Any,
            "errors": errors as Any,
            "functionId": functionId as Any,
            "logs": logs as Any,
            "requestHeaders": requestHeaders.map { $0.toMap() } as Any,
            "requestMethod": requestMethod as Any,
            "requestPath": requestPath as Any,
            "responseBody": responseBody as Any,
            "responseHeaders": responseHeaders.map { $0.toMap() } as Any,
            "responseStatusCode": responseStatusCode as Any,
            "scheduledAt": scheduledAt as Any,
            "status": status.rawValue as Any,
            "trigger": trigger.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Execution {
        return Execution(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            permissions: map["$permissions"] as! [String],
            updatedAt: map["$updatedAt"] as! String,
            deploymentId: map["deploymentId"] as! String,
            duration: map["duration"] as! Double,
            errors: map["errors"] as! String,
            functionId: map["functionId"] as! String,
            logs: map["logs"] as! String,
            requestHeaders: (map["requestHeaders"] as! [[String: Any]]).map { Headers.from(map: $0) },
            requestMethod: map["requestMethod"] as! String,
            requestPath: map["requestPath"] as! String,
            responseBody: map["responseBody"] as! String,
            responseHeaders: (map["responseHeaders"] as! [[String: Any]]).map { Headers.from(map: $0) },
            responseStatusCode: map["responseStatusCode"] as! Int,
            scheduledAt: map["scheduledAt"] as? String,
            status: ExecutionStatus(rawValue: map["status"] as! String)!,
            trigger: ExecutionTrigger(rawValue: map["trigger"] as! String)!
        )
    }
}
