import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Media storage: assets, folders, quotas (revenexx storage service).
open class Storage: Service {

    ///
    /// List the media assets in this tenant, newest first. Narrow the list with
    /// `filter[folder_id]`, `filter[kind]`, `filter[status]` and a
    /// `filter[created_at][gte]`/`[lte]` range; search original names, display
    /// names, alt text and descriptions with `search`; order by `created_at`,
    /// `size_bytes` or `original_name` (prefix with `-` to reverse). One page is
    /// returned, 50 records by default and 200 at most.
    /// 
    /// Records only: no file content is returned — fetch bytes with
    /// `GET /assets/{id}/download` or hand out a link with
    /// `POST /assets/{id}/sign`. Deleted assets are not listed.
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
    /// Upload one file into this tenant's media library. The file is checked
    /// against the tenant's single-file limit and its remaining storage quota,
    /// its media type is sniffed from the content rather than trusted from the
    /// request, and it is virus-scanned before anything is written. The stored
    /// asset comes back with status `pending_processing`; metadata extraction
    /// finishes asynchronously and moves it to `available`. `folder_id`,
    /// `visibility`, `alt_text`, `description`, `display_name` and `tags` are
    /// applied on the way in; set `unpack` to also queue an uploaded archive's
    /// members for ingestion.
    /// 
    /// Every call creates a new asset — this never replaces the content of an
    /// existing one — and it takes exactly one file. Use `POST /assets/bulk` for
    /// several.
    ///
    /// - Parameters:
    ///   - file: InputFile
    ///   - altText: String (optional)
    ///   - description: String (optional)
    ///   - displayName: String (optional)
    ///   - folderId: String (optional)
    ///   - keepArchive: Bool (optional)
    ///   - tags: [String] (optional)
    ///   - unpack: Bool (optional)
    ///   - visibility: RevenexxEnums.Visibility (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func assetStore(
        file: InputFile,
        altText: String? = nil,
        description: String? = nil,
        displayName: String? = nil,
        folderId: String? = nil,
        keepArchive: Bool? = nil,
        tags: [String]? = nil,
        unpack: Bool? = nil,
        visibility: RevenexxEnums.Visibility? = nil,
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
        let paramName = "file"
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
    /// Upload a batch of files in one request under `files`, each ingested
    /// exactly as `POST /assets` ingests a single file. The batch is rejected as
    /// a whole when it carries no files, more files than one request may carry,
    /// or too many bytes in total. Past that point every file is attempted
    /// independently and the call answers 207 with a `results` entry per file:
    /// either the created asset or the error that rejected it. A partial failure
    /// is therefore a successful call, not an error status — read `results`.
    /// 
    /// Only `folder_id` and `visibility` apply, and they apply to the whole
    /// batch; per-file metadata is not accepted here. Set it afterwards with
    /// `PATCH /assets/{id}`.
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
    /// Soft-delete an asset: it stops being listed and served, its status
    /// becomes `soft_deleted`, and it is scheduled for permanent deletion once
    /// the retention window has passed. Until then `POST /assets/{id}/restore`
    /// brings it back.
    /// 
    /// The stored file is not erased at this point and its bytes still count
    /// against the tenant's storage quota — use `DELETE /assets/{id}/permanent`
    /// to erase it and free the quota immediately.
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
    /// Fetch one asset's record by id: name, folder, media type, size, status,
    /// tags, the extracted metadata and the delivery URL (null for a private
    /// asset, which is reachable only through a signed URL). Metadata only — the
    /// bytes are served by `GET /assets/{id}/download`. A deleted asset is not
    /// visible here until `POST /assets/{id}/restore` brings it back.
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
    /// Change an asset's metadata: `display_name`, `alt_text`, `description`,
    /// `visibility` and `tags`. Sending `folder_id` moves it and sending `name`
    /// renames it; either re-derives the asset's public delivery path, so links
    /// built from the old path stop resolving. Only the fields present in the
    /// request are touched.
    /// 
    /// The stored file itself is never modified here — to change the content,
    /// upload a new asset.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - altText: String (optional)
    ///   - description: String (optional)
    ///   - displayName: String (optional)
    ///   - folderId: String (optional)
    ///   - name: String (optional)
    ///   - tags: [String] (optional)
    ///   - visibility: RevenexxEnums.Visibility (optional)
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
        visibility: RevenexxEnums.Visibility? = nil
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
    /// Stream the asset's original file back as an attachment, named after the
    /// asset. This is the authenticated read path — every call carries the
    /// caller's credentials — and the bytes are the ones that were uploaded: no
    /// resizing, re-encoding or other transformation is applied.
    /// 
    /// To let a browser, an email or a third party fetch the file without an API
    /// credential, mint a link with `POST /assets/{id}/sign` instead.
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
    /// Erase an asset and its stored file for good and credit its bytes back to
    /// the tenant's used storage. Works on live and soft-deleted assets alike.
    /// 
    /// This cannot be undone: there is no restore afterwards, and links to the
    /// asset stop resolving at once. Use `DELETE /assets/{id}` for the
    /// reversible variant. Requires the elevated (admin) tier.
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
    /// Re-run post-upload processing for one asset. It returns to
    /// `pending_processing` and the job re-extracts its metadata — and, for a 3D
    /// model, re-renders the preview and mesh derivatives — before marking it
    /// `available` again. The usual reason is an asset stuck in
    /// `processing_failed`.
    /// 
    /// The stored file is neither re-uploaded nor altered, and no thumbnails are
    /// produced: delivery transforms are applied on the fly when the asset is
    /// served, not here.
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
    /// Bring a soft-deleted asset back: the scheduled permanent deletion is
    /// cleared and the asset returns to `available`, listed and served again
    /// under its original path. Only works while the asset is still inside its
    /// retention window — once it has been erased, by
    /// `DELETE /assets/{id}/permanent` or by the retention sweep, there is
    /// nothing left to restore.
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
    /// Mint a time-limited URL that serves this asset without an API credential
    /// — the way to hand a private asset to a browser, an email or a third
    /// party. `ttl_seconds` sets the lifetime: one hour by default, seven days
    /// at most. The response carries the URL and the lifetime it was issued
    /// with.
    /// 
    /// The signature is checked at the delivery edge. A link cannot be revoked
    /// before it expires, so keep the lifetime short. A public asset already
    /// carries an unsigned delivery URL on its record and does not need this.
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
    /// Ingest the members of an already-uploaded archive as individual assets.
    /// They land in a folder named after the archive, created under
    /// `target_folder_id` or, when that is omitted, under the archive's own
    /// folder, and the archive's internal directory structure is mirrored
    /// beneath it. Each member goes through the same pipeline as an upload —
    /// media-type sniff, virus scan, quota — and a member that fails is skipped
    /// rather than failing the run. `keep_archive` (true by default) decides
    /// whether the archive asset itself survives.
    /// 
    /// Asynchronous: this answers 202 as soon as the work is queued, so poll the
    /// folder or asset list for the results. Only an asset that is an archive of
    /// a supported type can be unpacked; an upload can ask for the same thing
    /// inline with `unpack`.
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
    /// Return every folder in this tenant as one flat list ordered by path, each
    /// record carrying its `parent_id` and its materialized `path`, so a client
    /// can rebuild the tree without walking it. Not paginated and not filtered.
    /// 
    /// Folders hold no file content of their own — list a folder's assets with
    /// `GET /assets` and `filter[folder_id]`.
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
    /// Create a folder under `parent_id`, or at the library root when it is
    /// omitted. The `name` is slugged into a path segment and appended to the
    /// parent's path; that path is what the public delivery URL of every asset
    /// inside it is built from, so two siblings may not slug to the same
    /// segment.
    /// 
    /// Creating a folder moves nothing into it — assign assets with
    /// `folder_id` on upload or with `PATCH /assets/{id}`.
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
    /// Delete a folder. By default it has to be empty: a folder that still holds
    /// folders or assets is refused, so pass `recursive=true` to delete it
    /// together with everything beneath it.
    /// 
    /// A recursive delete soft-deletes the assets it takes with it — their files
    /// are not erased and their bytes still count against the tenant's storage
    /// quota, and each remains restorable through `POST /assets/{id}/restore`.
    /// System folders cannot be deleted.
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
    /// Fetch one folder's record by id: its name, its parent, the materialized
    /// path assets inside it are delivered under, and whether it is a system
    /// folder (system folders cannot be renamed, moved or deleted).
    /// 
    /// Its contents are not included — list them with `GET /assets` and
    /// `filter[folder_id]`, and its child folders with `GET /folders`.
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
    /// Rename a folder with `name`, move it under a different parent with
    /// `parent_id` (null for the root), or both at once. Either rewrites the
    /// folder's materialized path and the path of every folder beneath it, which
    /// changes the public delivery URL of every asset they hold — existing links
    /// built from the old path stop resolving.
    /// 
    /// Nothing else about the assets changes; they are not moved, re-uploaded or
    /// reprocessed. A system folder cannot be changed, a folder cannot be moved
    /// inside its own subtree, and the new name has to slug to a segment free
    /// among its new siblings.
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
    /// Return this tenant's SFTP sync rules, newest first, each with the account
    /// and remote path it pulls from, the folder it imports into, its cron
    /// schedule, whether it is enabled and when it last ran. Not paginated and
    /// not filtered.
    /// 
    /// These are the rules themselves, not what they moved: for the files a rule
    /// has actually transferred, see `GET /sftp/sync-history`.
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
    /// Schedule a recurring one-way pull from a directory on the tenant's SFTP
    /// storage box into this media library. `sftp_account_id` selects the
    /// account, `source_path` the remote directory, `target_folder_id` the
    /// folder imported assets land in, and `schedule` a cron expression (every
    /// five minutes when omitted) at which the rule falls due. `options` carries
    /// the per-rule knobs: recursion, include/exclude and size filters, how long
    /// a remote file has to have stopped changing before it is taken, and
    /// whether it is deleted from the remote after a successful transfer.
    /// 
    /// Each run ingests every matching remote file exactly as an upload would,
    /// quota, media-type and virus checks included, and records one history
    /// entry per file. Creating the rule transfers nothing: the first run
    /// happens when the schedule next falls due, or immediately if you call
    /// `POST /sftp/rules/{id}/run`. Nothing is ever pushed back to the remote,
    /// beyond the optional delete after a successful transfer. Requires the
    /// elevated (admin) tier.
    ///
    /// - Parameters:
    ///   - sftpAccountId: String
    ///   - sourcePath: String
    ///   - enabled: Bool (optional)
    ///   - options: [String] (optional)
    ///   - schedule: String (optional)
    ///   - targetFolderId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func syncRuleStore(
        sftpAccountId: String,
        sourcePath: String,
        enabled: Bool? = nil,
        options: [String]? = nil,
        schedule: String? = nil,
        targetFolderId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules"

        let apiParams: [String: Any?] = [
            "enabled": enabled,
            "options": options,
            "schedule": schedule,
            "sftp_account_id": sftpAccountId,
            "source_path": sourcePath,
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
    /// Delete a sync rule so it is never scheduled again. The assets it already
    /// imported stay exactly where they are, its recorded run history is kept,
    /// and nothing on the remote is touched.
    /// 
    /// To stop a rule only for a while, set `enabled` to false with
    /// `PATCH /sftp/rules/{id}` instead — a deleted rule cannot be restored.
    /// Requires the elevated (admin) tier.
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
    /// Fetch one sync rule's configuration by id: the account and remote path it
    /// pulls from, its target folder, its cron schedule, its `options` and
    /// `last_run_at`.
    /// 
    /// Configuration only, and `last_run_at` says when a run was last attempted,
    /// not whether it succeeded. What a run did is in
    /// `GET /sftp/rules/{id}/runs/{runId}` and `GET /sftp/sync-history`.
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
    /// Change a sync rule in place: its account, remote path, target folder,
    /// schedule or options, or `enabled` to pause and resume it without deleting
    /// it. Only the fields present in the request are touched, but `options` is
    /// replaced wholesale rather than merged — send the whole object.
    /// 
    /// A change takes effect from the next run; a run already in flight is not
    /// affected, and nothing a previous run imported is revisited or undone.
    /// Requires the elevated (admin) tier.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - enabled: Bool (optional)
    ///   - options: [String] (optional)
    ///   - schedule: String (optional)
    ///   - sftpAccountId: String (optional)
    ///   - sourcePath: String (optional)
    ///   - targetFolderId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func syncRuleUpdate(
        id: String,
        enabled: Bool? = nil,
        options: [String]? = nil,
        schedule: String? = nil,
        sftpAccountId: String? = nil,
        sourcePath: String? = nil,
        targetFolderId: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/storage/sftp/rules/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "enabled": enabled,
            "options": options,
            "schedule": schedule,
            "sftp_account_id": sftpAccountId,
            "source_path": sourcePath,
            "target_folder_id": targetFolderId
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
    /// Queue a run of this rule straight away, outside its schedule. Answers 202
    /// with the rule id as soon as the job is queued — it does not wait for the
    /// transfer and it does not hand back a run id, so follow the outcome in
    /// `GET /sftp/sync-history`.
    /// 
    /// The rule's own schedule is untouched, and this does not enable a disabled
    /// rule: the job is queued but does nothing when it picks a disabled rule
    /// up. Requires the elevated (admin) tier.
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
    /// Return the per-file protocol of one run of one sync rule: every entry the
    /// run recorded, oldest first, with the remote source path, the asset it
    /// produced, the bytes transferred, the duration and the error where one
    /// applies — plus a `summary` counting those entries by status (`success`,
    /// `skipped`, `failed`, `quarantined`).
    /// 
    /// Use it to find out what one run actually did. It is not paginated, and it
    /// does not list a rule's runs: take the `run_id` from
    /// `GET /sftp/sync-history`. An unknown `runId` under a rule that does exist
    /// is an empty protocol, not a 404.
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
    /// Page through this tenant's per-file sync records across every rule,
    /// newest first. Each entry names the run it belongs to, the rule, the
    /// remote source path, the asset it produced where there is one, the
    /// outcome — `success`, `skipped`, `failed` or `quarantined` — the bytes
    /// transferred and how long it took. Narrow it with `rule_id` and a
    /// `from`/`to` range on when the entry was recorded; one page is returned,
    /// 50 entries by default and 200 at most.
    /// 
    /// This is the audit trail of what SFTP sync has brought in: every file
    /// taken, skipped and rejected leaves an entry, and a run that matched
    /// nothing leaves one too. To read a single run whole instead, group by
    /// `run_id` and call `GET /sftp/rules/{id}/runs/{runId}`.
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
    /// Break this tenant's library down by asset kind — `image`, `video`,
    /// `audio`, `pdf`, `document`, `archive`, `model3d`, `other` — with a count
    /// and a byte total for each kind that has at least one asset, alongside the
    /// tenant-wide totals.
    /// 
    /// A dashboard figure, not a listing: no asset is named, and nothing here
    /// can be filtered. The tenant-wide byte total is the same running figure
    /// `GET /tenant/usage` reports, so soft-deleted assets are counted in it.
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
    /// Report this tenant's storage consumption: the bytes in use, the byte
    /// quota in force (null when the tenant is uncapped) and how many assets it
    /// holds. This is the figure the quota check on upload compares against — it
    /// is maintained as a running total on every upload and permanent delete
    /// rather than summed on read.
    /// 
    /// Soft-deleted assets are still counted, because their files are still
    /// stored; their bytes come back only once they are permanently deleted. For
    /// the breakdown by asset kind, see `GET /tenant/stats`.
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