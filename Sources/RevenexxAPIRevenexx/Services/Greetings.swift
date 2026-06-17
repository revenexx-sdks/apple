import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Greetings: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func greetingsDigest(
    ) async throws -> Any {
        let apiPath: String = "/v1/digest"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func greetingsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/greetings"

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
    ///   - name: String
    ///   - locale: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func greetingsCreate(
        name: String,
        locale: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/greetings"

        let apiParams: [String: Any?] = [
            "locale": locale,
            "name": name
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func greetingsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/greetings/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Greeting
    ///
    open func greetingsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Greeting {
        let apiPath: String = "/v1/greetings/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Greeting = { response in
            return RevenexxAPIRevenexxModels.Greeting.from(map: response as! [String: Any])
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
    ///   - locale: String (optional)
    ///   - message: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Greeting
    ///
    open func greetingsUpdate(
        id: String,
        locale: String? = nil,
        message: String? = nil,
        metadata: Any? = nil,
        name: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Greeting {
        let apiPath: String = "/v1/greetings/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "locale": locale,
            "message": message,
            "metadata": metadata,
            "name": name
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Greeting = { response in
            return RevenexxAPIRevenexxModels.Greeting.from(map: response as! [String: Any])
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