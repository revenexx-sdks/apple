import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Channels: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func channelsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/channels"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - code: String
    ///   - name: String
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - status: Revenexx API — revenexxEnums.ChannelStatus (optional)
    ///   - type: Revenexx API — revenexxEnums.ChannelType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Channel
    ///
    open func channelsCreate(
        code: String,
        name: String,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        status: Revenexx API — revenexxEnums.ChannelStatus? = nil,
        type: Revenexx API — revenexxEnums.ChannelType? = nil
    ) async throws -> Revenexx API — revenexxModels.Channel {
        let apiPath: String = "/v1/channels"

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "status": status,
            "type": type
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Channel = { response in
            return RevenexxAPIRevenexxModels.Channel.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ChannelDefaults
    ///
    open func channelsDefaults(
    ) async throws -> Revenexx API — revenexxModels.ChannelDefaults {
        let apiPath: String = "/v1/channels/defaults"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ChannelDefaults = { response in
            return RevenexxAPIRevenexxModels.ChannelDefaults.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func channelsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/channels/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Channel
    ///
    open func channelsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Channel {
        let apiPath: String = "/v1/channels/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Channel = { response in
            return RevenexxAPIRevenexxModels.Channel.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - status: Revenexx API — revenexxEnums.ChannelStatus (optional)
    ///   - type: Revenexx API — revenexxEnums.ChannelType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Channel
    ///
    open func channelsUpdate(
        id: String,
        code: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        status: Revenexx API — revenexxEnums.ChannelStatus? = nil,
        type: Revenexx API — revenexxEnums.ChannelType? = nil
    ) async throws -> Revenexx API — revenexxModels.Channel {
        let apiPath: String = "/v1/channels/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "status": status,
            "type": type
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Channel = { response in
            return RevenexxAPIRevenexxModels.Channel.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}