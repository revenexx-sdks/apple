import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Bulk data plane: import/export profiles, upload tickets, ad-hoc jobs and the job registry (Baseline).
open class Io: Service {

    ///
    /// The calling tenant's bulk jobs, newest first. Jobs are created by the
    /// feature blocks (import / export / A/B swap / tenant copy / sample) —
    /// never here; this surface is read-only.
    /// 
    ///
    /// - Parameters:
    ///   - type: Any (optional)
    ///   - status: Any (optional)
    ///   - vendor: String (optional)
    ///   - app: String (optional)
    ///   - entity: String (optional)
    ///   - limit: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func listBulkJobs(
        type: Any? = nil,
        status: Any? = nil,
        vendor: String? = nil,
        app: String? = nil,
        entity: String? = nil,
        limit: Int? = nil
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/bulk-jobs"

        let apiParams: [String: Any?] = [
            "type": type,
            "status": status,
            "vendor": vendor,
            "app": app,
            "entity": entity,
            "limit": limit
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// Status, row counts, and progress for one bulk job.
    /// 
    /// Tenant-scoped: an id belonging to another tenant is filtered out and
    /// is therefore indistinguishable from a non-existent one — which is the
    /// intent.
    /// 
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func getBulkJob(
        id: String
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/bulk-jobs/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// Flat list of the entities the calling tenant's installed apps expose,
    /// sorted by vendor, app, entity. Feeds the entity pickers of the
    /// Integration Studio I/O nodes.
    /// 
    /// The app set comes from `baseline.tenant_app_versions`. Per app the
    /// entity list is resolved from the tenant's pinned schema version; when
    /// that pointer is stale (missing or not applied) it falls back to the
    /// latest applied version of `(vendor, app)`. Apps with no applied
    /// schema at all contribute no entities.
    /// 
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func listIoEntities(
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/entities"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// Creates a `bulk_job` and dispatches the engine to export the tenant's
    /// rows for an entity. CSV/XML stream row-by-row into an S3 multipart
    /// upload (flat RAM); JSON/XLSX are buffered. The response carries the
    /// object key the result will be written to.
    /// 
    ///
    /// - Parameters:
    ///   - app: String
    ///   - entity: String
    ///   - vendor: String
    ///   - format: RevenexxEnums.Format (optional)
    ///   - profileId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func createExport(
        app: String,
        entity: String,
        vendor: String,
        format: RevenexxEnums.Format? = nil,
        profileId: String? = nil
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/exports"

        let apiParams: [String: Any?] = [
            "app": app,
            "entity": entity,
            "format": format,
            "profile_id": profileId,
            "vendor": vendor
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// Mints a short-TTL signed S3 `GET` URL for the object a completed
    /// export wrote. Tenant-scoped: an id belonging to another tenant — or
    /// to a job that is not an export — is indistinguishable from a
    /// non-existent one and answers `404`.
    /// 
    /// The job must have reached `completed` or `partial`; any earlier
    /// state answers `409` and carries the current `job_status`.
    /// 
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func getExportUrl(
        id: String
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/exports/{id}/url"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// Creates a `bulk_job` and dispatches the engine to import a previously
    /// uploaded object into the named entity. The engine streams CSV
    /// row-by-row (flat RAM at 1M+ rows) and COPYs into the entity's staging
    /// sibling before a merge / content-hash delta into the target.
    /// 
    ///
    /// - Parameters:
    ///   - app: String
    ///   - entity: String
    ///   - objectKey: String
    ///   - vendor: String
    ///   - format: RevenexxEnums.Format (optional)
    ///   - keys: [String] (optional)
    ///   - maxRejects: Int (optional)
    ///   - mode: RevenexxEnums.Mode (optional)
    ///   - profileId: String (optional)
    ///   - target: RevenexxEnums.CreateImportTarget (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func createImport(
        app: String,
        entity: String,
        objectKey: String,
        vendor: String,
        format: RevenexxEnums.Format? = nil,
        keys: [String]? = nil,
        maxRejects: Int? = nil,
        mode: RevenexxEnums.Mode? = nil,
        profileId: String? = nil,
        target: RevenexxEnums.CreateImportTarget? = nil
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/imports"

        let apiParams: [String: Any?] = [
            "app": app,
            "entity": entity,
            "format": format,
            "keys": keys,
            "max_rejects": maxRejects,
            "mode": mode,
            "object_key": objectKey,
            "profile_id": profileId,
            "target": target,
            "vendor": vendor
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// The calling tenant's saved profiles, ordered by name.
    /// 
    /// When `X-Revenexx-Market` is present the listing is filtered to the
    /// profiles offered for that market — global profiles (`markets: null`)
    /// plus those whose `markets` contain it. Omit the header to get every
    /// profile, which is what the management view wants.
    /// 
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func listProfiles(
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/profiles"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// A tenant-secured, reusable mapping (field rename + transforms + keys)
    /// for a direction (`import`/`export`), format, and entity. Runnable
    /// on-click via `/io/profiles/{id}/run`.
    /// 
    ///
    /// - Parameters:
    ///   - app: String
    ///   - direction: RevenexxEnums.Direction
    ///   - entity: String
    ///   - format: String
    ///   - name: String
    ///   - vendor: String
    ///   - applyMode: RevenexxEnums.ApplyMode (optional)
    ///   - mapping: Any (optional)
    ///   - markets: [String] (optional)
    ///   - options: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func createProfile(
        app: String,
        direction: RevenexxEnums.Direction,
        entity: String,
        format: String,
        name: String,
        vendor: String,
        applyMode: RevenexxEnums.ApplyMode? = nil,
        mapping: Any? = nil,
        markets: [String]? = nil,
        options: Any? = nil
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/profiles"

        let apiParams: [String: Any?] = [
            "app": app,
            "apply_mode": applyMode,
            "direction": direction,
            "entity": entity,
            "format": format,
            "mapping": mapping,
            "markets": markets,
            "name": name,
            "options": options,
            "vendor": vendor
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// Permanently remove a saved profile owned by the calling tenant.
    /// 
    /// Idempotent, and deliberately not a `404` path: deleting an id that
    /// does not belong to the tenant still answers `200`, with `deleted: 0`.
    /// 
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func deleteProfile(
        id: String
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/profiles/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// A single saved profile. Tenant-scoped: an id owned by another tenant
    /// is indistinguishable from a non-existent one and answers `404`.
    /// 
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func showProfile(
        id: String
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/profiles/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// Replace a saved profile's mapping, format, or apply mode (tenant-scoped).
    ///
    /// - Parameters:
    ///   - id: String
    ///   - app: String
    ///   - direction: RevenexxEnums.Direction
    ///   - entity: String
    ///   - format: String
    ///   - name: String
    ///   - vendor: String
    ///   - applyMode: RevenexxEnums.ApplyMode (optional)
    ///   - mapping: Any (optional)
    ///   - markets: [String] (optional)
    ///   - options: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func updateProfile(
        id: String,
        app: String,
        direction: RevenexxEnums.Direction,
        entity: String,
        format: String,
        name: String,
        vendor: String,
        applyMode: RevenexxEnums.ApplyMode? = nil,
        mapping: Any? = nil,
        markets: [String]? = nil,
        options: Any? = nil
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/profiles/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "app": app,
            "apply_mode": applyMode,
            "direction": direction,
            "entity": entity,
            "format": format,
            "mapping": mapping,
            "markets": markets,
            "name": name,
            "options": options,
            "vendor": vendor
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Dispatches the engine using the saved profile. An import run requires
    /// `object_key` (upload first); an export run writes a generated key.
    /// 
    ///
    /// - Parameters:
    ///   - id: String
    ///   - markets: [String] (optional)
    ///   - objectKey: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func runProfile(
        id: String,
        markets: [String]? = nil,
        objectKey: String? = nil
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/profiles/{id}/run"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "markets": markets,
            "object_key": objectKey
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
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
    /// Returns a short-lived signed S3 `PUT` URL (+ required headers) and
    /// the `object_key` to reference in a subsequent `/io/imports`. The
    /// client uploads bytes directly to object storage — never through
    /// Baseline.
    /// 
    ///
    /// - Parameters:
    ///   - extension: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ValidationFailedResponse
    ///
    open func createUpload(
        `extension`: String? = nil
    ) async throws -> RevenexxModels.ValidationFailedResponse {
        let apiPath: String = "/v1/io/uploads"

        let apiParams: [String: Any?] = [
            "extension": `extension`
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.ValidationFailedResponse = { response in
            return RevenexxModels.ValidationFailedResponse.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}