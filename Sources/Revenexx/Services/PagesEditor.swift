import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The unpublished side: one page open in the visual editor, held as a server-side mutation log rather than as edited rows. Load the whole editor state in one call, append mutations, walk the undo/redo pointer, disable a single step, then publish — which materializes the log into the canonical blocks and writes a revision — or revert, which throws it away. An edit state has ONE owner at a time and every write asks for it, so taking a page over from a colleague is its own call. Scheduling, share-links for unpublished previews, machine translation and a person's own editor preferences hang off the same session.
open class PagesEditor: Service {

    ///
    /// The drafts overview — the "what is unpublished right now" list, across
    /// every page: who holds it, since when, and whether it is parked for a date.
    /// Always newest-first — this route does not read `order`. An edit state
    /// whose page has been deleted is dropped from `items` but still counted in
    /// `total`.
    ///
    /// - Parameters:
    ///   - status: RevenexxEnums.PageEditStateStatus (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorEditStates(
        status: RevenexxEnums.PageEditStateStatus? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/edit-states"

        let apiParams: [String: Any?] = [
            "status": status,
            "limit": limit,
            "offset": offset
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// The translation is the tenant's provider's, not this app's, and a tenant
    /// that has configured none gets no translation at all. The endpoint comes
    /// from the tenant setting `translate_endpoint` (PAGES_TRANSLATE_ENDPOINT
    /// remains a fallback). The bearer token does NOT: the gateway masks every
    /// setting flagged `sensitive`, so a key stored as one could never be read
    /// back — it stays the PAGES_TRANSLATE_KEY function secret. This app does
    /// not translate anything itself; it forwards `items` and hands the answer
    /// back.
    ///
    /// - Parameters:
    ///   - items: [Any] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesEditorTranslate(
        items: [Any]? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/editor/translate"

        let apiParams: [String: Any?] = [
            "items": items
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Per-user editor preferences — one row per user, scoped to this app. Not
    /// tenant configuration: nothing here changes what the API does, only how one
    /// person's editor looks.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorUserSettingsGet(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/user-settings"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Replaces the caller's preferences wholesale — this is not a merge, so
    /// send the whole bag.
    ///
    /// - Parameters:
    ///   - settings: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorUserSettingsPut(
        settings: Any? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/user-settings"

        let apiParams: [String: Any?] = [
            "settings": settings
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Undo and redo. The pointer is the edit state's `current_index`, the
    /// position in the mutation log the page is materialized at, and this route is
    /// the only thing that moves it — `GET …/state?index=` looks at another
    /// position without going there. The log itself is never rewritten — only
    /// the pointer moves — so redo stays available until the next change is
    /// appended.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - index: Int
    ///   - langcode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.MutationResponse
    ///
    open func pagesEditorHistory(
        pageId: String,
        index: Int,
        langcode: String? = nil
    ) async throws -> RevenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/history"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "index": index,
            "langcode": langcode
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.MutationResponse = { response in
            return RevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    /// The cheap poll behind "someone else is editing this page": one integer, the
    /// moment the open edit state last moved, in epoch seconds rather than as a
    /// timestamp so a comparison is a subtraction. Compare it with the `updatedAt`
    /// you last saw and re-fetch the state only when it moved.
    ///
    /// - Parameters:
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorLastChanged(
        pageId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/last-changed"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Take one change out of the replay without deleting it — "what would the
    /// page look like without this edit". The entry stays in the history and can
    /// be switched back on.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - enabled: Bool
    ///   - index: Int
    ///   - langcode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.MutationResponse
    ///
    open func pagesEditorMutationStatus(
        pageId: String,
        enabled: Bool,
        index: Int,
        langcode: String? = nil
    ) async throws -> RevenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/mutation-status"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "enabled": enabled,
            "index": index,
            "langcode": langcode
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.MutationResponse = { response in
            return RevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    /// The one way page CONTENT changes. Each call appends one entry to the
    /// append-only log and answers the whole re-materialized state, so a client
    /// never re-fetches. A page nobody has opened yet needs no separate call to
    /// open it: the first mutation creates the edit state and takes ownership of
    /// it, and every later one asks for that ownership, so a second person editing
    /// the same page is refused until they take it over. Appending while the
    /// pointer sits mid-history discards the redo branch, exactly as an editor
    /// expects.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - plugin: String
    ///   - langcode: String (optional)
    ///   - payload: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.MutationResponse
    ///
    open func pagesEditorMutate(
        pageId: String,
        plugin: String,
        langcode: String? = nil,
        payload: Any? = nil
    ) async throws -> RevenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/mutations"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "langcode": langcode,
            "payload": payload,
            "plugin": plugin
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.MutationResponse = { response in
            return RevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    /// Mints a link that shows this page's current edit state — the UNPUBLISHED
    /// one — to somebody without an editor account. The token is the whole
    /// credential — anyone holding it sees the page — so it expires, and a new
    /// one is cheap.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - ttlHours: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorPreviewGrant(
        pageId: String,
        ttlHours: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/preview-grant"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "ttlHours": ttlHours
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
    /// Four things in one call: the mutation log is replayed into a finished block
    /// tree, that tree is snapshotted into a new revision, the page's canonical
    /// blocks are replaced by it, and the edit state is archived — so the page
    /// comes out of this with nothing unpublished and the working copy behind it
    /// closed rather than deleted. The revision is written FIRST and the canonical
    /// blocks replaced after, so a failure mid-way leaves the page recoverable.
    /// Block uuids survive, which is why comments anchored to a block outlive the
    /// publish.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - force: Bool (optional)
    ///   - label: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesEditorPublish(
        pageId: String,
        force: Bool? = nil,
        label: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/editor/{page_id}/publish"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "force": force,
            "label": label
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Throws the whole working copy away: the edit state row is deleted and its
    /// mutation log with it, so the history goes too — this is not an undo and
    /// cannot itself be undone. Unlike publishing, which archives the edit state,
    /// nothing of it survives to be reopened. The published page is untouched.
    ///
    /// - Parameters:
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.MutationResponse
    ///
    open func pagesEditorRevert(
        pageId: String
    ) async throws -> RevenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/revert"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.MutationResponse = { response in
            return RevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    /// Gated on the tenant setting `enable_scheduled_publishing`, which is off by
    /// default: nothing in the platform publishes a scheduled edit state yet, so a
    /// date accepted here would be a promise the app cannot keep. Every editor
    /// state carries `features.scheduledPublishing` so the control can be hidden
    /// rather than the refusal discovered.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - scheduledAt: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesEditorSchedule(
        pageId: String,
        scheduledAt: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/editor/{page_id}/schedule"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "scheduledAt": scheduledAt
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The one call the visual editor boots on, and the only place the UNPUBLISHED
    /// page can be seen whole: the canonical blocks with every enabled mutation of
    /// the log replayed over them, the resulting field lists, the mutation history
    /// itself, who owns the edit state and where the undo pointer sits, and the
    /// tenant's editor feature flags. `langcode` decides which language the props
    /// resolve in, falling back to the page's source language. `index` replays the
    /// log up to a given position instead of the current one, which is how the
    /// editor previews an undo without performing it — it changes nothing, so it
    /// is safe to call at any position. Reading this creates nothing either: a
    /// page nobody has opened answers with a null `editState`, an empty history,
    /// and the published blocks as they stand.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - langcode: String (optional)
    ///   - index: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.EditorState
    ///
    open func pagesEditorState(
        pageId: String,
        langcode: String? = nil,
        index: Int? = nil
    ) async throws -> RevenexxModels.EditorState {
        let apiPath: String = "/v1/pages/editor/{page_id}/state"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "langcode": langcode,
            "index": index
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.EditorState = { response in
            return RevenexxModels.EditorState.from(map: response as! [String: Any])
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
    /// One page has one writer. This is how the second person gets the pen — the
    /// previous owner is notified rather than silently locked out.
    ///
    /// - Parameters:
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.MutationResponse
    ///
    open func pagesEditorTakeOwnership(
        pageId: String
    ) async throws -> RevenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/take-ownership"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.MutationResponse = { response in
            return RevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    /// Freezes a selection into a reusable starting point. The blocks are read out
    /// of the page's CURRENT edit state rather than out of what is published, so a
    /// template can be cut from work in progress and the uuids you send are the
    /// ones the editor is showing. Unlike making a block reusable, this COPIES:
    /// pages later made from the template are independent of it and of each other.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - label: String
    ///   - uuids: [String]
    ///   - description: String (optional)
    ///   - fieldName: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - pageBundle: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesEditorTemplatesCreate(
        pageId: String,
        label: String,
        uuids: [String],
        description: String? = nil,
        fieldName: String? = nil,
        isDefault: Bool? = nil,
        pageBundle: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/editor/{page_id}/templates"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "description": description,
            "fieldName": fieldName,
            "isDefault": isDefault,
            "label": label,
            "pageBundle": pageBundle,
            "uuids": uuids
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Takes a parked edit state back to `active` and clears its date, so the
    /// scheduled publication simply does not happen. The work is not touched —
    /// the mutation log, the undo position and the owner all stay as they were —
    /// and the page can then be published by hand or scheduled again for a
    /// different date. Like every other write to an edit state it asks for
    /// ownership, and a page with no open edit state answers 404 rather than
    /// pretending to have cancelled something.
    ///
    /// - Parameters:
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorUnschedule(
        pageId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/unschedule"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }


}