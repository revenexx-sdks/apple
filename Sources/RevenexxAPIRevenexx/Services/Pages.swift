import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Pages: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesDeliveryMenus(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/delivery/menus"

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
    /// - Returns: Revenexx API — revenexxModels.DeliveryPage
    ///
    open func pagesDeliveryPage(
    ) async throws -> Revenexx API — revenexxModels.DeliveryPage {
        let apiPath: String = "/v1/pages/delivery/page"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.DeliveryPage = { response in
            return RevenexxAPIRevenexxModels.DeliveryPage.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesDeliveryPages(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/delivery/pages"

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
    ///   - token: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.DeliveryPage
    ///
    open func pagesDeliveryPreview(
        token: String
    ) async throws -> Revenexx API — revenexxModels.DeliveryPage {
        let apiPath: String = "/v1/pages/delivery/preview/{token}"
            .replacingOccurrences(of: "{token}", with: token)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.DeliveryPage = { response in
            return RevenexxAPIRevenexxModels.DeliveryPage.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorEditStates(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/edit-states"

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
    open func pagesEditorNotificationsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/notifications"

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
    open func pagesEditorNotificationsMarkAllRead(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/notifications/mark-all-read"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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
    open func pagesEditorNotificationsUnreadCount(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/notifications/unread-count"

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
    ///   - items: [Any] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorTranslate(
        items: [Any]? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/translate"

        let apiParams: [String: Any?] = [
            "items": items
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorUsers(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/users"

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
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorCommentsList(
        pageId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments"
            .replacingOccurrences(of: "{pageId}", with: pageId)

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
    ///   - pageId: String
    ///   - body: String
    ///   - blockUuids: [String] (optional)
    ///   - parentUuid: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorCommentsCreate(
        pageId: String,
        body: String,
        blockUuids: [String]? = nil,
        parentUuid: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any?] = [
            "blockUuids": blockUuids,
            "body": body,
            "parentUuid": parentUuid
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
    ///   - pageId: String
    ///   - uuid: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorCommentsDelete(
        pageId: String,
        uuid: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}"
            .replacingOccurrences(of: "{pageId}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

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
    ///   - pageId: String
    ///   - uuid: String
    ///   - body: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorCommentsUpdate(
        pageId: String,
        uuid: String,
        body: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}"
            .replacingOccurrences(of: "{pageId}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

        let apiParams: [String: Any?] = [
            "body": body
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
    /// - Parameters:
    ///   - pageId: String
    ///   - uuid: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorCommentsResolve(
        pageId: String,
        uuid: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}/resolve"
            .replacingOccurrences(of: "{pageId}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

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
    ///   - pageId: String
    ///   - uuid: String
    ///   - taskIndex: Int
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Comment
    ///
    open func pagesEditorCommentsToggleTask(
        pageId: String,
        uuid: String,
        taskIndex: Int
    ) async throws -> Revenexx API — revenexxModels.Comment {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}/toggle-task"
            .replacingOccurrences(of: "{pageId}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

        let apiParams: [String: Any?] = [
            "taskIndex": taskIndex
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Comment = { response in
            return RevenexxAPIRevenexxModels.Comment.from(map: response as! [String: Any])
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
    ///   - pageId: String
    ///   - uuid: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorCommentsUnresolve(
        pageId: String,
        uuid: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}/unresolve"
            .replacingOccurrences(of: "{pageId}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

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
    ///   - pageId: String
    ///   - index: Int
    ///   - langcode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MutationResponse
    ///
    open func pagesEditorHistory(
        pageId: String,
        index: Int,
        langcode: String? = nil
    ) async throws -> Revenexx API — revenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/history"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any?] = [
            "index": index,
            "langcode": langcode
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MutationResponse = { response in
            return RevenexxAPIRevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorLastChanged(
        pageId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/last-changed"
            .replacingOccurrences(of: "{pageId}", with: pageId)

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
    ///   - pageId: String
    ///   - enabled: Bool
    ///   - index: Int
    ///   - langcode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MutationResponse
    ///
    open func pagesEditorMutationStatus(
        pageId: String,
        enabled: Bool,
        index: Int,
        langcode: String? = nil
    ) async throws -> Revenexx API — revenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/mutation-status"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any?] = [
            "enabled": enabled,
            "index": index,
            "langcode": langcode
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MutationResponse = { response in
            return RevenexxAPIRevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    ///   - pageId: String
    ///   - plugin: String
    ///   - langcode: String (optional)
    ///   - payload: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MutationResponse
    ///
    open func pagesEditorMutate(
        pageId: String,
        plugin: String,
        langcode: String? = nil,
        payload: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/mutations"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any?] = [
            "langcode": langcode,
            "payload": payload,
            "plugin": plugin
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MutationResponse = { response in
            return RevenexxAPIRevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
            .replacingOccurrences(of: "{pageId}", with: pageId)

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
    /// - Parameters:
    ///   - pageId: String
    ///   - force: Bool (optional)
    ///   - label: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MutationResponse
    ///
    open func pagesEditorPublish(
        pageId: String,
        force: Bool? = nil,
        label: String? = nil
    ) async throws -> Revenexx API — revenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/publish"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any?] = [
            "force": force,
            "label": label
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MutationResponse = { response in
            return RevenexxAPIRevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MutationResponse
    ///
    open func pagesEditorRevert(
        pageId: String
    ) async throws -> Revenexx API — revenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/revert"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.MutationResponse = { response in
            return RevenexxAPIRevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    ///   - pageId: String
    ///   - scheduledAt: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorSchedule(
        pageId: String,
        scheduledAt: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/schedule"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any?] = [
            "scheduledAt": scheduledAt
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
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.EditorState
    ///
    open func pagesEditorState(
        pageId: String
    ) async throws -> Revenexx API — revenexxModels.EditorState {
        let apiPath: String = "/v1/pages/editor/{page_id}/state"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.EditorState = { response in
            return RevenexxAPIRevenexxModels.EditorState.from(map: response as! [String: Any])
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
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MutationResponse
    ///
    open func pagesEditorTakeOwnership(
        pageId: String
    ) async throws -> Revenexx API — revenexxModels.MutationResponse {
        let apiPath: String = "/v1/pages/editor/{page_id}/take-ownership"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.MutationResponse = { response in
            return RevenexxAPIRevenexxModels.MutationResponse.from(map: response as! [String: Any])
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
    ///   - pageId: String
    ///   - label: String
    ///   - uuids: [String]
    ///   - description: String (optional)
    ///   - fieldName: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - pageBundle: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Template
    ///
    open func pagesEditorTemplatesCreate(
        pageId: String,
        label: String,
        uuids: [String],
        description: String? = nil,
        fieldName: String? = nil,
        isDefault: Bool? = nil,
        pageBundle: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Template {
        let apiPath: String = "/v1/pages/editor/{page_id}/templates"
            .replacingOccurrences(of: "{pageId}", with: pageId)

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

        let converter: (Any) -> Revenexx API — revenexxModels.Template = { response in
            return RevenexxAPIRevenexxModels.Template.from(map: response as! [String: Any])
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
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorUnschedule(
        pageId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/{page_id}/unschedule"
            .replacingOccurrences(of: "{pageId}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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
    open func pagesLibraryList(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/library"

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
    open func pagesLibraryDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/library/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.LibraryItem
    ///
    open func pagesLibraryGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.LibraryItem {
        let apiPath: String = "/v1/pages/library/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.LibraryItem = { response in
            return RevenexxAPIRevenexxModels.LibraryItem.from(map: response as! [String: Any])
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
    ///   - bundle: String (optional)
    ///   - label: String (optional)
    ///   - tree: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.LibraryItem
    ///
    open func pagesLibraryUpdate(
        id: String,
        bundle: String? = nil,
        label: String? = nil,
        tree: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.LibraryItem {
        let apiPath: String = "/v1/pages/library/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "bundle": bundle,
            "label": label,
            "tree": tree
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.LibraryItem = { response in
            return RevenexxAPIRevenexxModels.LibraryItem.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesMenusList(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/menus"

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
    ///   - label: String
    ///   - menuKey: String
    ///   - items: [Any] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Menu
    ///
    open func pagesMenusUpsert(
        label: String,
        menuKey: String,
        items: [Any]? = nil
    ) async throws -> Revenexx API — revenexxModels.Menu {
        let apiPath: String = "/v1/pages/menus"

        let apiParams: [String: Any?] = [
            "items": items,
            "label": label,
            "menuKey": menuKey
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Menu = { response in
            return RevenexxAPIRevenexxModels.Menu.from(map: response as! [String: Any])
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
    open func pagesMenusDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/menus/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Menu
    ///
    open func pagesMenusGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Menu {
        let apiPath: String = "/v1/pages/menus/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Menu = { response in
            return RevenexxAPIRevenexxModels.Menu.from(map: response as! [String: Any])
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
    ///   - items: [Any] (optional)
    ///   - label: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Menu
    ///
    open func pagesMenusUpdate(
        id: String,
        items: [Any]? = nil,
        label: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Menu {
        let apiPath: String = "/v1/pages/menus/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "items": items,
            "label": label
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Menu = { response in
            return RevenexxAPIRevenexxModels.Menu.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesPagesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/pages"

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
    ///   - title: String
    ///   - bundle: String (optional)
    ///   - hostOptions: Any (optional)
    ///   - meta: Any (optional)
    ///   - slug: String (optional)
    ///   - sourceLanguage: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Page
    ///
    open func pagesPagesCreate(
        title: String,
        bundle: String? = nil,
        hostOptions: Any? = nil,
        meta: Any? = nil,
        slug: String? = nil,
        sourceLanguage: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Page {
        let apiPath: String = "/v1/pages/pages"

        let apiParams: [String: Any?] = [
            "bundle": bundle,
            "hostOptions": hostOptions,
            "meta": meta,
            "slug": slug,
            "sourceLanguage": sourceLanguage,
            "title": title
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Page = { response in
            return RevenexxAPIRevenexxModels.Page.from(map: response as! [String: Any])
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
    open func pagesPagesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/pages/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Page
    ///
    open func pagesPagesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Page {
        let apiPath: String = "/v1/pages/pages/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Page = { response in
            return RevenexxAPIRevenexxModels.Page.from(map: response as! [String: Any])
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
    ///   - bundle: String (optional)
    ///   - meta: Any (optional)
    ///   - slug: String (optional)
    ///   - status: Revenexx API — revenexxEnums.PageStatus (optional)
    ///   - title: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Page
    ///
    open func pagesPagesUpdate(
        id: String,
        bundle: String? = nil,
        meta: Any? = nil,
        slug: String? = nil,
        status: Revenexx API — revenexxEnums.PageStatus? = nil,
        title: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Page {
        let apiPath: String = "/v1/pages/pages/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "bundle": bundle,
            "meta": meta,
            "slug": slug,
            "status": status,
            "title": title
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Page = { response in
            return RevenexxAPIRevenexxModels.Page.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesPagesRevisions(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/pages/{id}/revisions"
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
    ///   - menus: [Any] (optional)
    ///   - pages: [Any] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesSeed(
        menus: [Any]? = nil,
        pages: [Any]? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/seed"

        let apiParams: [String: Any?] = [
            "menus": menus,
            "pages": pages
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
    open func pagesTemplatesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/templates"

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
    open func pagesTemplatesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/templates/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Template
    ///
    open func pagesTemplatesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Template {
        let apiPath: String = "/v1/pages/templates/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Template = { response in
            return RevenexxAPIRevenexxModels.Template.from(map: response as! [String: Any])
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
    ///   - description: String (optional)
    ///   - fieldName: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - label: String (optional)
    ///   - pageBundle: String (optional)
    ///   - tree: [Any] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Template
    ///
    open func pagesTemplatesUpdate(
        id: String,
        description: String? = nil,
        fieldName: String? = nil,
        isDefault: Bool? = nil,
        label: String? = nil,
        pageBundle: String? = nil,
        tree: [Any]? = nil
    ) async throws -> Revenexx API — revenexxModels.Template {
        let apiPath: String = "/v1/pages/templates/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "description": description,
            "field_name": fieldName,
            "is_default": isDefault,
            "label": label,
            "page_bundle": pageBundle,
            "tree": tree
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Template = { response in
            return RevenexxAPIRevenexxModels.Template.from(map: response as! [String: Any])
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