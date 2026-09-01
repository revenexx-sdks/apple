import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Gateway liveness and readiness probes. Public: no credential, no tenant.
open class Health: Service {

    ///
    /// Answers as long as the process is running. Never touches a dependency, so
    /// it stays 200 while the gateway is degraded — use readiness to decide
    /// whether to send traffic.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func healthLive(
    ) async throws -> Any {
        let apiPath: String = "/health/live"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Answers 200 once the gateway's registry source is reachable, 503 until
    /// then.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func healthReady(
    ) async throws -> Any {
        let apiPath: String = "/health/ready"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }


}