import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// Outbound messaging: email/push messages, providers, topics, targets.
open class Messaging: Service {

    ///
    /// Get a list of all messages from the current Revenexx project.
    ///
    /// - Parameters:
    ///   - queries: [String] (optional)
    ///   - search: String (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MessageList
    ///
    open func messagingListMessages(
        queries: [String]? = nil,
        search: String? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.MessageList {
        let apiPath: String = "/v1/messaging/messages"

        let apiParams: [String: Any?] = [
            "queries": queries,
            "search": search,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.MessageList = { response in
            return RevenexxAPIRevenexxModels.MessageList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new email message.
    ///
    /// - Parameters:
    ///   - content: String
    ///   - messageId: String
    ///   - subject: String
    ///   - attachments: [String] (optional)
    ///   - bcc: [String] (optional)
    ///   - cc: [String] (optional)
    ///   - draft: Bool (optional)
    ///   - html: Bool (optional)
    ///   - scheduledAt: String (optional)
    ///   - targets: [String] (optional)
    ///   - topics: [String] (optional)
    ///   - users: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Message
    ///
    open func messagingCreateEmail(
        content: String,
        messageId: String,
        subject: String,
        attachments: [String]? = nil,
        bcc: [String]? = nil,
        cc: [String]? = nil,
        draft: Bool? = nil,
        html: Bool? = nil,
        scheduledAt: String? = nil,
        targets: [String]? = nil,
        topics: [String]? = nil,
        users: [String]? = nil
    ) async throws -> Revenexx API — revenexxModels.Message {
        let apiPath: String = "/v1/messaging/messages/email"

        let apiParams: [String: Any?] = [
            "attachments": attachments,
            "bcc": bcc,
            "cc": cc,
            "content": content,
            "draft": draft,
            "html": html,
            "messageId": messageId,
            "scheduledAt": scheduledAt,
            "subject": subject,
            "targets": targets,
            "topics": topics,
            "users": users
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Message = { response in
            return RevenexxAPIRevenexxModels.Message.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update an email message by its unique ID. This endpoint only works on
    /// messages that are in draft status. Messages that are already processing,
    /// sent, or failed cannot be updated.
    /// 
    ///
    /// - Parameters:
    ///   - messageId: String
    ///   - attachments: [String] (optional)
    ///   - bcc: [String] (optional)
    ///   - cc: [String] (optional)
    ///   - content: String (optional)
    ///   - draft: Bool (optional)
    ///   - html: Bool (optional)
    ///   - scheduledAt: String (optional)
    ///   - subject: String (optional)
    ///   - targets: [String] (optional)
    ///   - topics: [String] (optional)
    ///   - users: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Message
    ///
    open func messagingUpdateEmail(
        messageId: String,
        attachments: [String]? = nil,
        bcc: [String]? = nil,
        cc: [String]? = nil,
        content: String? = nil,
        draft: Bool? = nil,
        html: Bool? = nil,
        scheduledAt: String? = nil,
        subject: String? = nil,
        targets: [String]? = nil,
        topics: [String]? = nil,
        users: [String]? = nil
    ) async throws -> Revenexx API — revenexxModels.Message {
        let apiPath: String = "/v1/messaging/messages/email/{messageId}"
            .replacingOccurrences(of: "{messageId}", with: messageId)

        let apiParams: [String: Any?] = [
            "attachments": attachments,
            "bcc": bcc,
            "cc": cc,
            "content": content,
            "draft": draft,
            "html": html,
            "scheduledAt": scheduledAt,
            "subject": subject,
            "targets": targets,
            "topics": topics,
            "users": users
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Message = { response in
            return RevenexxAPIRevenexxModels.Message.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new push notification.
    ///
    /// - Parameters:
    ///   - messageId: String
    ///   - action: String (optional)
    ///   - badge: Int (optional)
    ///   - body: String (optional)
    ///   - color: String (optional)
    ///   - contentAvailable: Bool (optional)
    ///   - critical: Bool (optional)
    ///   - data: Any (optional)
    ///   - draft: Bool (optional)
    ///   - icon: String (optional)
    ///   - image: String (optional)
    ///   - priority: Revenexx API — revenexxEnums.Priority (optional)
    ///   - scheduledAt: String (optional)
    ///   - sound: String (optional)
    ///   - tag: String (optional)
    ///   - targets: [String] (optional)
    ///   - title: String (optional)
    ///   - topics: [String] (optional)
    ///   - users: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Message
    ///
    open func messagingCreatePush(
        messageId: String,
        action: String? = nil,
        badge: Int? = nil,
        body: String? = nil,
        color: String? = nil,
        contentAvailable: Bool? = nil,
        critical: Bool? = nil,
        data: Any? = nil,
        draft: Bool? = nil,
        icon: String? = nil,
        image: String? = nil,
        priority: Revenexx API — revenexxEnums.Priority? = nil,
        scheduledAt: String? = nil,
        sound: String? = nil,
        tag: String? = nil,
        targets: [String]? = nil,
        title: String? = nil,
        topics: [String]? = nil,
        users: [String]? = nil
    ) async throws -> Revenexx API — revenexxModels.Message {
        let apiPath: String = "/v1/messaging/messages/push"

        let apiParams: [String: Any?] = [
            "action": action,
            "badge": badge,
            "body": body,
            "color": color,
            "contentAvailable": contentAvailable,
            "critical": critical,
            "data": data,
            "draft": draft,
            "icon": icon,
            "image": image,
            "messageId": messageId,
            "priority": priority,
            "scheduledAt": scheduledAt,
            "sound": sound,
            "tag": tag,
            "targets": targets,
            "title": title,
            "topics": topics,
            "users": users
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Message = { response in
            return RevenexxAPIRevenexxModels.Message.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a push notification by its unique ID. This endpoint only works on
    /// messages that are in draft status. Messages that are already processing,
    /// sent, or failed cannot be updated.
    /// 
    ///
    /// - Parameters:
    ///   - messageId: String
    ///   - action: String (optional)
    ///   - badge: Int (optional)
    ///   - body: String (optional)
    ///   - color: String (optional)
    ///   - contentAvailable: Bool (optional)
    ///   - critical: Bool (optional)
    ///   - data: Any (optional)
    ///   - draft: Bool (optional)
    ///   - icon: String (optional)
    ///   - image: String (optional)
    ///   - priority: Revenexx API — revenexxEnums.Priority (optional)
    ///   - scheduledAt: String (optional)
    ///   - sound: String (optional)
    ///   - tag: String (optional)
    ///   - targets: [String] (optional)
    ///   - title: String (optional)
    ///   - topics: [String] (optional)
    ///   - users: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Message
    ///
    open func messagingUpdatePush(
        messageId: String,
        action: String? = nil,
        badge: Int? = nil,
        body: String? = nil,
        color: String? = nil,
        contentAvailable: Bool? = nil,
        critical: Bool? = nil,
        data: Any? = nil,
        draft: Bool? = nil,
        icon: String? = nil,
        image: String? = nil,
        priority: Revenexx API — revenexxEnums.Priority? = nil,
        scheduledAt: String? = nil,
        sound: String? = nil,
        tag: String? = nil,
        targets: [String]? = nil,
        title: String? = nil,
        topics: [String]? = nil,
        users: [String]? = nil
    ) async throws -> Revenexx API — revenexxModels.Message {
        let apiPath: String = "/v1/messaging/messages/push/{messageId}"
            .replacingOccurrences(of: "{messageId}", with: messageId)

        let apiParams: [String: Any?] = [
            "action": action,
            "badge": badge,
            "body": body,
            "color": color,
            "contentAvailable": contentAvailable,
            "critical": critical,
            "data": data,
            "draft": draft,
            "icon": icon,
            "image": image,
            "priority": priority,
            "scheduledAt": scheduledAt,
            "sound": sound,
            "tag": tag,
            "targets": targets,
            "title": title,
            "topics": topics,
            "users": users
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Message = { response in
            return RevenexxAPIRevenexxModels.Message.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Delete a message. If the message is not a draft or scheduled, but has been
    /// sent, this will not recall the message.
    ///
    /// - Parameters:
    ///   - messageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func messagingDelete(
        messageId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/messaging/messages/{messageId}"
            .replacingOccurrences(of: "{messageId}", with: messageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a message by its unique ID.
    /// 
    ///
    /// - Parameters:
    ///   - messageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Message
    ///
    open func messagingGetMessage(
        messageId: String
    ) async throws -> Revenexx API — revenexxModels.Message {
        let apiPath: String = "/v1/messaging/messages/{messageId}"
            .replacingOccurrences(of: "{messageId}", with: messageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Message = { response in
            return RevenexxAPIRevenexxModels.Message.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get the message activity logs listed by its unique ID.
    ///
    /// - Parameters:
    ///   - messageId: String
    ///   - queries: [String] (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.LogList
    ///
    open func messagingListMessageLogs(
        messageId: String,
        queries: [String]? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.LogList {
        let apiPath: String = "/v1/messaging/messages/{messageId}/logs"
            .replacingOccurrences(of: "{messageId}", with: messageId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.LogList = { response in
            return RevenexxAPIRevenexxModels.LogList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a list of the targets associated with a message.
    ///
    /// - Parameters:
    ///   - messageId: String
    ///   - queries: [String] (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.TargetList
    ///
    open func messagingListTargets(
        messageId: String,
        queries: [String]? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.TargetList {
        let apiPath: String = "/v1/messaging/messages/{messageId}/targets"
            .replacingOccurrences(of: "{messageId}", with: messageId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.TargetList = { response in
            return RevenexxAPIRevenexxModels.TargetList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a list of all providers from the current Revenexx project.
    ///
    /// - Parameters:
    ///   - queries: [String] (optional)
    ///   - search: String (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ProviderList
    ///
    open func messagingListProviders(
        queries: [String]? = nil,
        search: String? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.ProviderList {
        let apiPath: String = "/v1/messaging/providers"

        let apiParams: [String: Any?] = [
            "queries": queries,
            "search": search,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ProviderList = { response in
            return RevenexxAPIRevenexxModels.ProviderList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new Mailgun provider.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - domain: String (optional)
    ///   - enabled: Bool (optional)
    ///   - fromEmail: String (optional)
    ///   - fromName: String (optional)
    ///   - isEuRegion: Bool (optional)
    ///   - replyToEmail: String (optional)
    ///   - replyToName: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingCreateMailgunProvider(
        name: String,
        providerId: String,
        apiKey: String? = nil,
        domain: String? = nil,
        enabled: Bool? = nil,
        fromEmail: String? = nil,
        fromName: String? = nil,
        isEuRegion: Bool? = nil,
        replyToEmail: String? = nil,
        replyToName: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/mailgun"

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "domain": domain,
            "enabled": enabled,
            "fromEmail": fromEmail,
            "fromName": fromName,
            "isEuRegion": isEuRegion,
            "name": name,
            "providerId": providerId,
            "replyToEmail": replyToEmail,
            "replyToName": replyToName
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a Mailgun provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - domain: String (optional)
    ///   - enabled: Bool (optional)
    ///   - fromEmail: String (optional)
    ///   - fromName: String (optional)
    ///   - isEuRegion: Bool (optional)
    ///   - name: String (optional)
    ///   - replyToEmail: String (optional)
    ///   - replyToName: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingUpdateMailgunProvider(
        providerId: String,
        apiKey: String? = nil,
        domain: String? = nil,
        enabled: Bool? = nil,
        fromEmail: String? = nil,
        fromName: String? = nil,
        isEuRegion: Bool? = nil,
        name: String? = nil,
        replyToEmail: String? = nil,
        replyToName: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/mailgun/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "domain": domain,
            "enabled": enabled,
            "fromEmail": fromEmail,
            "fromName": fromName,
            "isEuRegion": isEuRegion,
            "name": name,
            "replyToEmail": replyToEmail,
            "replyToName": replyToName
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new MSG91 provider.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - providerId: String
    ///   - authKey: String (optional)
    ///   - enabled: Bool (optional)
    ///   - senderId: String (optional)
    ///   - templateId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingCreateMsg91Provider(
        name: String,
        providerId: String,
        authKey: String? = nil,
        enabled: Bool? = nil,
        senderId: String? = nil,
        templateId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/msg91"

        let apiParams: [String: Any?] = [
            "authKey": authKey,
            "enabled": enabled,
            "name": name,
            "providerId": providerId,
            "senderId": senderId,
            "templateId": templateId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a MSG91 provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - authKey: String (optional)
    ///   - enabled: Bool (optional)
    ///   - name: String (optional)
    ///   - senderId: String (optional)
    ///   - templateId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingUpdateMsg91Provider(
        providerId: String,
        authKey: String? = nil,
        enabled: Bool? = nil,
        name: String? = nil,
        senderId: String? = nil,
        templateId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/msg91/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "authKey": authKey,
            "enabled": enabled,
            "name": name,
            "senderId": senderId,
            "templateId": templateId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new Resend provider.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - enabled: Bool (optional)
    ///   - fromEmail: String (optional)
    ///   - fromName: String (optional)
    ///   - replyToEmail: String (optional)
    ///   - replyToName: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingCreateResendProvider(
        name: String,
        providerId: String,
        apiKey: String? = nil,
        enabled: Bool? = nil,
        fromEmail: String? = nil,
        fromName: String? = nil,
        replyToEmail: String? = nil,
        replyToName: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/resend"

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "enabled": enabled,
            "fromEmail": fromEmail,
            "fromName": fromName,
            "name": name,
            "providerId": providerId,
            "replyToEmail": replyToEmail,
            "replyToName": replyToName
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a Resend provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - enabled: Bool (optional)
    ///   - fromEmail: String (optional)
    ///   - fromName: String (optional)
    ///   - name: String (optional)
    ///   - replyToEmail: String (optional)
    ///   - replyToName: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingUpdateResendProvider(
        providerId: String,
        apiKey: String? = nil,
        enabled: Bool? = nil,
        fromEmail: String? = nil,
        fromName: String? = nil,
        name: String? = nil,
        replyToEmail: String? = nil,
        replyToName: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/resend/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "enabled": enabled,
            "fromEmail": fromEmail,
            "fromName": fromName,
            "name": name,
            "replyToEmail": replyToEmail,
            "replyToName": replyToName
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new Sendgrid provider.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - enabled: Bool (optional)
    ///   - fromEmail: String (optional)
    ///   - fromName: String (optional)
    ///   - replyToEmail: String (optional)
    ///   - replyToName: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingCreateSendgridProvider(
        name: String,
        providerId: String,
        apiKey: String? = nil,
        enabled: Bool? = nil,
        fromEmail: String? = nil,
        fromName: String? = nil,
        replyToEmail: String? = nil,
        replyToName: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/sendgrid"

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "enabled": enabled,
            "fromEmail": fromEmail,
            "fromName": fromName,
            "name": name,
            "providerId": providerId,
            "replyToEmail": replyToEmail,
            "replyToName": replyToName
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a Sendgrid provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - enabled: Bool (optional)
    ///   - fromEmail: String (optional)
    ///   - fromName: String (optional)
    ///   - name: String (optional)
    ///   - replyToEmail: String (optional)
    ///   - replyToName: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingUpdateSendgridProvider(
        providerId: String,
        apiKey: String? = nil,
        enabled: Bool? = nil,
        fromEmail: String? = nil,
        fromName: String? = nil,
        name: String? = nil,
        replyToEmail: String? = nil,
        replyToName: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/sendgrid/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "enabled": enabled,
            "fromEmail": fromEmail,
            "fromName": fromName,
            "name": name,
            "replyToEmail": replyToEmail,
            "replyToName": replyToName
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new Telesign provider.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - customerId: String (optional)
    ///   - enabled: Bool (optional)
    ///   - from: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingCreateTelesignProvider(
        name: String,
        providerId: String,
        apiKey: String? = nil,
        customerId: String? = nil,
        enabled: Bool? = nil,
        from: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/telesign"

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "customerId": customerId,
            "enabled": enabled,
            "from": from,
            "name": name,
            "providerId": providerId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a Telesign provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - customerId: String (optional)
    ///   - enabled: Bool (optional)
    ///   - from: String (optional)
    ///   - name: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingUpdateTelesignProvider(
        providerId: String,
        apiKey: String? = nil,
        customerId: String? = nil,
        enabled: Bool? = nil,
        from: String? = nil,
        name: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/telesign/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "customerId": customerId,
            "enabled": enabled,
            "from": from,
            "name": name
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new Textmagic provider.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - enabled: Bool (optional)
    ///   - from: String (optional)
    ///   - username: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingCreateTextmagicProvider(
        name: String,
        providerId: String,
        apiKey: String? = nil,
        enabled: Bool? = nil,
        from: String? = nil,
        username: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/textmagic"

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "enabled": enabled,
            "from": from,
            "name": name,
            "providerId": providerId,
            "username": username
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a Textmagic provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - enabled: Bool (optional)
    ///   - from: String (optional)
    ///   - name: String (optional)
    ///   - username: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingUpdateTextmagicProvider(
        providerId: String,
        apiKey: String? = nil,
        enabled: Bool? = nil,
        from: String? = nil,
        name: String? = nil,
        username: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/textmagic/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "enabled": enabled,
            "from": from,
            "name": name,
            "username": username
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new Twilio provider.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - providerId: String
    ///   - accountSid: String (optional)
    ///   - authToken: String (optional)
    ///   - enabled: Bool (optional)
    ///   - from: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingCreateTwilioProvider(
        name: String,
        providerId: String,
        accountSid: String? = nil,
        authToken: String? = nil,
        enabled: Bool? = nil,
        from: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/twilio"

        let apiParams: [String: Any?] = [
            "accountSid": accountSid,
            "authToken": authToken,
            "enabled": enabled,
            "from": from,
            "name": name,
            "providerId": providerId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a Twilio provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - accountSid: String (optional)
    ///   - authToken: String (optional)
    ///   - enabled: Bool (optional)
    ///   - from: String (optional)
    ///   - name: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingUpdateTwilioProvider(
        providerId: String,
        accountSid: String? = nil,
        authToken: String? = nil,
        enabled: Bool? = nil,
        from: String? = nil,
        name: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/twilio/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "accountSid": accountSid,
            "authToken": authToken,
            "enabled": enabled,
            "from": from,
            "name": name
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new Vonage provider.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - apiSecret: String (optional)
    ///   - enabled: Bool (optional)
    ///   - from: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingCreateVonageProvider(
        name: String,
        providerId: String,
        apiKey: String? = nil,
        apiSecret: String? = nil,
        enabled: Bool? = nil,
        from: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/vonage"

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "apiSecret": apiSecret,
            "enabled": enabled,
            "from": from,
            "name": name,
            "providerId": providerId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a Vonage provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - apiKey: String (optional)
    ///   - apiSecret: String (optional)
    ///   - enabled: Bool (optional)
    ///   - from: String (optional)
    ///   - name: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingUpdateVonageProvider(
        providerId: String,
        apiKey: String? = nil,
        apiSecret: String? = nil,
        enabled: Bool? = nil,
        from: String? = nil,
        name: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/vonage/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "apiKey": apiKey,
            "apiSecret": apiSecret,
            "enabled": enabled,
            "from": from,
            "name": name
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Delete a provider by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func messagingDeleteProvider(
        providerId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/messaging/providers/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a provider by its unique ID.
    /// 
    ///
    /// - Parameters:
    ///   - providerId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Provider
    ///
    open func messagingGetProvider(
        providerId: String
    ) async throws -> Revenexx API — revenexxModels.Provider {
        let apiPath: String = "/v1/messaging/providers/{providerId}"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Provider = { response in
            return RevenexxAPIRevenexxModels.Provider.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get the provider activity logs listed by its unique ID.
    ///
    /// - Parameters:
    ///   - providerId: String
    ///   - queries: [String] (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.LogList
    ///
    open func messagingListProviderLogs(
        providerId: String,
        queries: [String]? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.LogList {
        let apiPath: String = "/v1/messaging/providers/{providerId}/logs"
            .replacingOccurrences(of: "{providerId}", with: providerId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.LogList = { response in
            return RevenexxAPIRevenexxModels.LogList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get the subscriber activity logs listed by its unique ID.
    ///
    /// - Parameters:
    ///   - subscriberId: String
    ///   - queries: [String] (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.LogList
    ///
    open func messagingListSubscriberLogs(
        subscriberId: String,
        queries: [String]? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.LogList {
        let apiPath: String = "/v1/messaging/subscribers/{subscriberId}/logs"
            .replacingOccurrences(of: "{subscriberId}", with: subscriberId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.LogList = { response in
            return RevenexxAPIRevenexxModels.LogList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a list of all topics from the current Revenexx project.
    ///
    /// - Parameters:
    ///   - queries: [String] (optional)
    ///   - search: String (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.TopicList
    ///
    open func messagingListTopics(
        queries: [String]? = nil,
        search: String? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.TopicList {
        let apiPath: String = "/v1/messaging/topics"

        let apiParams: [String: Any?] = [
            "queries": queries,
            "search": search,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.TopicList = { response in
            return RevenexxAPIRevenexxModels.TopicList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new topic.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - topicId: String
    ///   - subscribe: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Topic
    ///
    open func messagingCreateTopic(
        name: String,
        topicId: String,
        subscribe: [String]? = nil
    ) async throws -> Revenexx API — revenexxModels.Topic {
        let apiPath: String = "/v1/messaging/topics"

        let apiParams: [String: Any?] = [
            "name": name,
            "subscribe": subscribe,
            "topicId": topicId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Topic = { response in
            return RevenexxAPIRevenexxModels.Topic.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Delete a topic by its unique ID.
    ///
    /// - Parameters:
    ///   - topicId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func messagingDeleteTopic(
        topicId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/messaging/topics/{topicId}"
            .replacingOccurrences(of: "{topicId}", with: topicId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a topic by its unique ID.
    /// 
    ///
    /// - Parameters:
    ///   - topicId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Topic
    ///
    open func messagingGetTopic(
        topicId: String
    ) async throws -> Revenexx API — revenexxModels.Topic {
        let apiPath: String = "/v1/messaging/topics/{topicId}"
            .replacingOccurrences(of: "{topicId}", with: topicId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Topic = { response in
            return RevenexxAPIRevenexxModels.Topic.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update a topic by its unique ID.
    /// 
    ///
    /// - Parameters:
    ///   - topicId: String
    ///   - name: String (optional)
    ///   - subscribe: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Topic
    ///
    open func messagingUpdateTopic(
        topicId: String,
        name: String? = nil,
        subscribe: [String]? = nil
    ) async throws -> Revenexx API — revenexxModels.Topic {
        let apiPath: String = "/v1/messaging/topics/{topicId}"
            .replacingOccurrences(of: "{topicId}", with: topicId)

        let apiParams: [String: Any?] = [
            "name": name,
            "subscribe": subscribe
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Topic = { response in
            return RevenexxAPIRevenexxModels.Topic.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get the topic activity logs listed by its unique ID.
    ///
    /// - Parameters:
    ///   - topicId: String
    ///   - queries: [String] (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.LogList
    ///
    open func messagingListTopicLogs(
        topicId: String,
        queries: [String]? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.LogList {
        let apiPath: String = "/v1/messaging/topics/{topicId}/logs"
            .replacingOccurrences(of: "{topicId}", with: topicId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.LogList = { response in
            return RevenexxAPIRevenexxModels.LogList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a list of all subscribers from the current Revenexx project.
    ///
    /// - Parameters:
    ///   - topicId: String
    ///   - queries: [String] (optional)
    ///   - search: String (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.SubscriberList
    ///
    open func messagingListSubscribers(
        topicId: String,
        queries: [String]? = nil,
        search: String? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.SubscriberList {
        let apiPath: String = "/v1/messaging/topics/{topicId}/subscribers"
            .replacingOccurrences(of: "{topicId}", with: topicId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "search": search,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.SubscriberList = { response in
            return RevenexxAPIRevenexxModels.SubscriberList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new subscriber.
    ///
    /// - Parameters:
    ///   - topicId: String
    ///   - subscriberId: String
    ///   - targetId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Subscriber
    ///
    open func messagingCreateSubscriber(
        topicId: String,
        subscriberId: String,
        targetId: String
    ) async throws -> Revenexx API — revenexxModels.Subscriber {
        let apiPath: String = "/v1/messaging/topics/{topicId}/subscribers"
            .replacingOccurrences(of: "{topicId}", with: topicId)

        let apiParams: [String: Any?] = [
            "subscriberId": subscriberId,
            "targetId": targetId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Subscriber = { response in
            return RevenexxAPIRevenexxModels.Subscriber.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Delete a subscriber by its unique ID.
    ///
    /// - Parameters:
    ///   - topicId: String
    ///   - subscriberId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func messagingDeleteSubscriber(
        topicId: String,
        subscriberId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/messaging/topics/{topicId}/subscribers/{subscriberId}"
            .replacingOccurrences(of: "{topicId}", with: topicId)
            .replacingOccurrences(of: "{subscriberId}", with: subscriberId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a subscriber by its unique ID.
    /// 
    ///
    /// - Parameters:
    ///   - topicId: String
    ///   - subscriberId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Subscriber
    ///
    open func messagingGetSubscriber(
        topicId: String,
        subscriberId: String
    ) async throws -> Revenexx API — revenexxModels.Subscriber {
        let apiPath: String = "/v1/messaging/topics/{topicId}/subscribers/{subscriberId}"
            .replacingOccurrences(of: "{topicId}", with: topicId)
            .replacingOccurrences(of: "{subscriberId}", with: subscriberId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Subscriber = { response in
            return RevenexxAPIRevenexxModels.Subscriber.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}