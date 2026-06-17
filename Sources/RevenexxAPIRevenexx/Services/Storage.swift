import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// Media storage: assets, folders, quotas (revenexx storage service).
open class Storage: Service {

    ///
    /// - Parameters:
    ///   - search: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func assetIndex(
        search: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets"

        let apiParams: [String: Any?] = [
            "search": search
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - file: String
    ///   - altText: String (optional)
    ///   - description: String (optional)
    ///   - displayName: String (optional)
    ///   - folderId: String (optional)
    ///   - keepArchive: Bool (optional)
    ///   - tags: [String] (optional)
    ///   - unpack: Bool (optional)
    ///   - visibility: Revenexx API — revenexxEnums.Visibility (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func assetStore(
        file: String,
        altText: String? = nil,
        description: String? = nil,
        displayName: String? = nil,
        folderId: String? = nil,
        keepArchive: Bool? = nil,
        tags: [String]? = nil,
        unpack: Bool? = nil,
        visibility: Revenexx API — revenexxEnums.Visibility? = nil,
        onProgress: ((UploadProgress) -> Void)? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets"

        var apiParams: [String: Any?] = [
            "alt_text": altText,
            "description": description,
            "display_name": displayName,
            "file": file,
            "folder_id": folderId,
            "keep_archive": keepArchive,
            "tags": tags,
            "unpack": unpack,
            "visibility": visibility
        ]

        var apiHeaders: [String: String] = [
            "content-type": "multipart/form-data"
        ]

        let idParamName: String? = nil
        return try await client.chunkedUpload(
            path: apiPath,
            headers: &apiHeaders,
            params: &apiParams,
            paramName: paramName,
            idParamName: idParamName,
            onProgress: onProgress
        )
    }

    ///
    /// - Parameters:
    ///   - folderId: String (optional)
    ///   - visibility: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func assetBulk(
        folderId: String? = nil,
        visibility: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/bulk"

        let apiParams: [String: Any?] = [
            "folder_id": folderId,
            "visibility": visibility
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
    open func assetDestroy(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}"
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
    /// - Returns: Any
    ///
    open func assetShow(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}"
            .replacingOccurrences(of: "{id}", with: id)

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
    ///   - id: String
    ///   - altText: String (optional)
    ///   - description: String (optional)
    ///   - displayName: String (optional)
    ///   - folderId: String (optional)
    ///   - name: String (optional)
    ///   - tags: [String] (optional)
    ///   - visibility: Revenexx API — revenexxEnums.Visibility (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func assetUpdate(
        id: String,
        altText: String? = nil,
        description: String? = nil,
        displayName: String? = nil,
        folderId: String? = nil,
        name: String? = nil,
        tags: [String]? = nil,
        visibility: Revenexx API — revenexxEnums.Visibility? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "alt_text": altText,
            "description": description,
            "display_name": displayName,
            "folder_id": folderId,
            "name": name,
            "tags": tags,
            "visibility": visibility
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "PATCH",
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
    open func assetDownload(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}/download"
            .replacingOccurrences(of: "{id}", with: id)

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
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func assetPermanent(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}/permanent"
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
    /// - Returns: Any
    ///
    open func assetReprocess(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}/reprocess"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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
    open func assetRestore(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}/restore"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    ///   - ttlSeconds: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func assetSign(
        id: String,
        ttlSeconds: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}/sign"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "ttl_seconds": ttlSeconds
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
    ///   - keepArchive: Bool (optional)
    ///   - targetFolderId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func assetUnpack(
        id: String,
        keepArchive: Bool? = nil,
        targetFolderId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/assets/{id}/unpack"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "keep_archive": keepArchive,
            "target_folder_id": targetFolderId
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func folderIndex(
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/folders"

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
    ///   - parentId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func folderStore(
        name: String,
        parentId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/folders"

        let apiParams: [String: Any?] = [
            "name": name,
            "parent_id": parentId
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
    ///   - recursive: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func folderDestroy(
        id: String,
        recursive: Bool? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/folders/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "recursive": recursive
        ]

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
    /// - Returns: Any
    ///
    open func folderShow(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/folders/{id}"
            .replacingOccurrences(of: "{id}", with: id)

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
    ///   - id: String
    ///   - name: String (optional)
    ///   - parentId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func folderUpdate(
        id: String,
        name: String? = nil,
        parentId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/folders/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "name": name,
            "parent_id": parentId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func syncRuleIndex(
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules"

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
    open func syncRuleStore(
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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
    open func syncRuleDestroy(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules/{id}"
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
    /// - Returns: Any
    ///
    open func syncRuleShow(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules/{id}"
            .replacingOccurrences(of: "{id}", with: id)

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
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func syncRuleUpdate(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "PATCH",
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
    open func syncRuleRun(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules/{id}/run"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    ///   - runId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func syncRuleRunProtocol(
        id: String,
        runId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules/{id}/runs/{runId}"
            .replacingOccurrences(of: "{id}", with: id)
            .replacingOccurrences(of: "{runId}", with: runId)

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
    ///   - ruleId: String (optional)
    ///   - from: String (optional)
    ///   - to: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func syncRuleHistory(
        ruleId: String? = nil,
        from: String? = nil,
        to: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/sync-history"

        let apiParams: [String: Any?] = [
            "rule_id": ruleId,
            "from": from,
            "to": to
        ]

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
    open func tenantStats(
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/tenant/stats"

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
    open func tenantUsage(
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/tenant/usage"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }


}