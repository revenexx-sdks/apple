import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The review layer over a page: comment threads pinned to blocks, with @mentions, task checkboxes and resolve/reopen, plus the notification feed those threads and an ownership handover raise, and the user directory a mention is picked from. Comments belong to the PAGE, not to a revision or an edit state, so they outlive publishing and reverting — which is what makes them usable as a review trail. Every write here answers the page's whole comment list rather than the row it touched, so a client can render from one response.
open class PagesCollaboration: Service {

    ///
    /// The caller's own notifications, newest first, 20 at a time. Paged by an
    /// opaque cursor rather than by offset, so new arrivals never shift a page
    /// under the reader. It is also the one read in this app that writes:
    /// `?markAsRead=true` flags the notifications on the page it just returned as
    /// read, which is how a feed that has been looked at empties its badge without
    /// a second call — leave it off and reading changes nothing.
    ///
    /// - Parameters:
    ///   - after: String (optional)
    ///   - markAsRead: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesEditorNotificationsList(
        after: String? = nil,
        markAsRead: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/editor/notifications"

        let apiParams: [String: Any?] = [
            "after": after,
            "markAsRead": markAsRead
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Empties the badge in one call. Every unread notification of the CURRENT
    /// user is flagged read — the user is the one the request's context token
    /// names and there is no body with which to name another. Nothing is deleted:
    /// `GET /pages/editor/notifications` still returns the same feed, just with
    /// `read` set. The answer is the new unread count, so a client can set the
    /// badge straight from it without a second read.
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
    /// The cheap poll behind the badge.
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
    /// What the @mention picker is filled from. When the identity service cannot
    /// be reached this degrades to the authors who have already commented on this
    /// tenant's pages rather than answering an error — a mention list that is
    /// short is more useful than one that is missing.
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
    /// Every comment on the page in one flat list, oldest first, roots and replies
    /// together and resolved threads included — there is no filter and no
    /// paging, because the editor nests and filters them itself from `parentUuid`
    /// and pins each root to its blocks with `blockUuids`. Comments hang off the
    /// PAGE, not off a revision or an edit state, so publishing and reverting
    /// leave them standing; that is what makes them usable as a review trail
    /// across several rounds of edits.
    ///
    /// - Parameters:
    ///   - pageId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.PageCommentList
    ///
    open func pagesEditorCommentsList(
        pageId: String
    ) async throws -> RevenexxModels.PageCommentList {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.PageCommentList = { response in
            return RevenexxModels.PageCommentList.from(map: response as! [String: Any])
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
    /// The same route writes both kinds, and which one you get is decided by the
    /// body: `blockUuids` starts a new thread pinned to those blocks, `parentUuid`
    /// hangs a reply under an existing root. Everyone named with an @mention in
    /// the body is notified, and on a reply so is everybody already in the thread
    /// — the actor never notifies themselves.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - body: String
    ///   - blockUuids: [String] (optional)
    ///   - parentUuid: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.PageCommentList
    ///
    open func pagesEditorCommentsCreate(
        pageId: String,
        body: String,
        blockUuids: [String]? = nil,
        parentUuid: String? = nil
    ) async throws -> RevenexxModels.PageCommentList {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments"
            .replacingOccurrences(of: "{page_id}", with: pageId)

        let apiParams: [String: Any?] = [
            "blockUuids": blockUuids,
            "body": body,
            "parentUuid": parentUuid
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.PageCommentList = { response in
            return RevenexxModels.PageCommentList.from(map: response as! [String: Any])
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
    /// A hard delete, and deleting a root takes its replies with it.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - uuid: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.PageCommentList
    ///
    open func pagesEditorCommentsDelete(
        pageId: String,
        uuid: String
    ) async throws -> RevenexxModels.PageCommentList {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}"
            .replacingOccurrences(of: "{page_id}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.PageCommentList = { response in
            return RevenexxModels.PageCommentList.from(map: response as! [String: Any])
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
    /// Rewrites what a comment says, and only its author may — a comment carries
    /// an `author_id` and anybody else is refused with 403. Only the body moves:
    /// what the comment is pinned to, whether the thread is resolved and who wrote
    /// it are all fixed when it is created. Rewriting a body does NOT re-run the
    /// @mention notifications, so mentioning somebody new by editing will not
    /// reach them. Answers the page's whole comment list rather than the one row,
    /// so a client can re-render from the response.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - uuid: String
    ///   - body: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesEditorCommentsUpdate(
        pageId: String,
        uuid: String,
        body: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}"
            .replacingOccurrences(of: "{page_id}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

        let apiParams: [String: Any?] = [
            "body": body
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Marks a thread handled, so the editor stops surfacing it on the block it is
    /// pinned to. Only a ROOT can be resolved — resolved-ness is a property of
    /// the thread and not of a message in it, so pointing this at a reply is
    /// refused with 400 rather than quietly resolving its parent. Nothing is
    /// deleted, nobody is notified, and the thread stays in the list;
    /// `.../unresolve` is the way back. Answers the page's whole comment list.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - uuid: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesEditorCommentsResolve(
        pageId: String,
        uuid: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}/resolve"
            .replacingOccurrences(of: "{page_id}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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
    /// A comment body may carry a task list. This flips one checkbox by rewriting
    /// the body's markup, and answers the single comment rather than the whole
    /// list. A `taskIndex` that names no checkbox is refused and nothing is
    /// written — the comment's `updated_at` is the editor's "edited" marker, so
    /// a call that changes nothing must not move it.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - uuid: String
    ///   - taskIndex: Int
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesEditorCommentsToggleTask(
        pageId: String,
        uuid: String,
        taskIndex: Int
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}/toggle-task"
            .replacingOccurrences(of: "{page_id}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

        let apiParams: [String: Any?] = [
            "taskIndex": taskIndex
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
    /// Clears the resolved flag and puts the thread back in front of whoever is
    /// editing — the mirror of `.../resolve` in every respect, including that
    /// only a root can be reopened and that a reply answers 400. A thread that was
    /// already open is accepted and stays open. Answers the page's whole comment
    /// list.
    ///
    /// - Parameters:
    ///   - pageId: String
    ///   - uuid: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesEditorCommentsUnresolve(
        pageId: String,
        uuid: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/editor/{page_id}/comments/{uuid}/unresolve"
            .replacingOccurrences(of: "{page_id}", with: pageId)
            .replacingOccurrences(of: "{uuid}", with: uuid)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

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


}