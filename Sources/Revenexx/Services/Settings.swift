import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Resolve an app's effective per-tenant / per-market settings (schema defaults merged with stored values; sensitive values masked).
open class Settings: Service {

    ///
    /// The tenant's effective settings for the app — the declared schema's
    /// defaults merged with stored tenant/market values. Sensitive settings are
    /// masked (listed in `masked`, omitted from `settings`).
    ///
    /// - Parameters:
    ///   - app: String
    ///   - market: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func settingsGetAppSettings(
        app: String,
        market: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/settings/apps/{app}"
            .replacingOccurrences(of: "{app}", with: app)

        let apiParams: [String: Any?] = [
            "market": market
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }


}