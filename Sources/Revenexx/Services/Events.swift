import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The tenant's event catalog: every event type its installed apps and platform services declare, what causes each one, and what it carries.
open class Events: Service {

    ///
    /// Every event type this tenant's installed apps and platform services declare
    /// — what can be published and subscribed to, independent of whether one has
    /// fired yet. Each entry says what causes it (`trigger`) and what it carries
    /// (`sample`, `data_schema`).
    ///
    /// - Parameters:
    ///   - fields: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func eventsGetCatalog(
        fields: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/events/catalog"

        let apiParams: [String: Any?] = [
            "fields": fields
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }


}