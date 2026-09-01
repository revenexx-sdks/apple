import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The records this app stores, addressed by id and edited outside the visual editor: pages and their publish history, the menus a theme renders as navigation, the block templates a new page can start from, the library of block subtrees many pages share, and the one seeding call a theme activation hook fires. A page here is its METADATA — title, slug, status, type — never its blocks; the blocks live in the editor group, because changing one is a mutation and not a field update. The vocabularies that name the permitted values of a status column are here too.
open class Pages: Service {

    ///
    /// The pool an editor picks a reusable block from. A library item is ONE block
    /// subtree that many pages share BY REFERENCE — edit the item and every page
    /// using it changes — which is what separates it from a template, the other
    /// reusable thing here, which copies instead and is at `GET /pages/templates`.
    /// So the two filters are the two questions the picker asks: `bundles` narrows
    /// to the block types that fit the field being filled, `text` matches the
    /// label a person gave the item.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - bundles: String (optional)
    ///   - text: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesLibraryList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        bundles: String? = nil,
        text: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/library"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "bundles": bundles,
            "text": text
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Retires a reusable block. It leaves the picker and every list, but the
    /// blocks pointing at it keep their `library_item_id` — the FK's `set null`
    /// belongs to a hard delete, and this writes a tombstone. Delivery then skips
    /// the expansion for a struck item rather than failing on it, so a page that
    /// used it falls back to the block content stored in its own published
    /// revision: nothing breaks, but the pages quietly stop tracking each other.
    /// Nothing here tells you which pages those are, so establish that before
    /// striking it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesLibraryDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/library/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The stored subtree behind one reusable block, so a picker can preview what
    /// dropping it into a page would produce. Because delivery expands the
    /// reference against THIS row at read time, what comes back is also what every
    /// page already using the item is currently rendering — which makes this the
    /// call to make before editing one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesLibraryGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/library/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The one write in this app whose blast radius is not a single page. Delivery
    /// expands a library reference against this row every time it serves, so
    /// replacing `tree` re-renders every page that points at the item —
    /// published ones included — without any of them being edited, republished
    /// or even touched. Nothing warns you first and no revision records it,
    /// because the pages did not change; the item did. Changing `label` or
    /// `bundle` only moves the item around the picker. Detaching one page from the
    /// item, so it keeps a copy of its own, is an editor mutation and not this
    /// route.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - bundle: String (optional)
    ///   - label: String (optional)
    ///   - tree: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesLibraryUpdate(
        id: String,
        bundle: String? = nil,
        label: String? = nil,
        tree: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// The management view of the menus a tenant keeps — `main`, `footer`,
    /// `account` and whatever else the theme asks for, each with the key it is
    /// looked up by. This route reads no filter at all — a `?menu_key=` is
    /// ignored, which the empty `filter` echo shows — so fetch a page and pick,
    /// or address one by id.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesMenusList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/menus"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Writes a menu by its KEY rather than by its id, which is what makes theme
    /// seeding safe to repeat: a key the tenant already has has its label and
    /// items replaced in place, a key it does not have is created. `items` is
    /// replaced wholesale and never merged, so sending an empty list empties the
    /// navigation. One caveat worth reading before you rely on the idempotence:
    /// the key's uniqueness is this route's doing and not the database's —
    /// `menu_key` carries an index but no unique constraint — so a duplicate key
    /// created any other way leaves this route updating whichever row it finds
    /// first.
    ///
    /// - Parameters:
    ///   - label: String
    ///   - menuKey: String
    ///   - items: [RevenexxModels.PageMenuItem<AnyCodable>] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesMenusUpsert(
        label: String,
        menuKey: String,
        items: [RevenexxModels.PageMenuItem<AnyCodable>]? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/menus"

        let apiParams: [String: Any?] = [
            "items": items,
            "label": label,
            "menuKey": menuKey
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
    /// Writes the tombstone. The menu drops out of the management list and out of
    /// `GET /pages/delivery/menus` in the same moment, so a theme that reads its
    /// key gets nothing back and renders nothing — there is no fallback and no
    /// error a storefront could act on. The key is free immediately, which means
    /// re-seeding the theme is the way back. Check what reads the key before
    /// striking it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesMenusDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/menus/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// One menu and its whole item tree — the ordered links a theme renders as
    /// its header, footer or account navigation. `items` is nested, not one level,
    /// so this is the entire navigation for that key in a single read. Addressed
    /// by ROW ID here; the key a theme knows it by is `menu_key` on the body, and
    /// the route that works by key is the upsert.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesMenusGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/menus/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The same write as the upsert, for a caller that already holds the row id
    /// — use this when editing a menu a person picked from a list, and the
    /// upsert when reconciling a theme's defaults. `menu_key` is deliberately not
    /// editable here: the key is the handle every theme reads the menu by, so
    /// changing it would empty whatever is rendering that key without anything
    /// reporting an error.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - items: [RevenexxModels.PageMenuItem<AnyCodable>] (optional)
    ///   - label: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesMenusUpdate(
        id: String,
        items: [RevenexxModels.PageMenuItem<AnyCodable>]? = nil,
        label: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/menus/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "items": items,
            "label": label
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
    /// The EDITORIAL index — every live page of the tenant, whatever its status,
    /// newest change first. This is the list the Cockpit shows a person: drafts
    /// and archived pages are in it, and a row here says nothing about whether a
    /// visitor can see the page, because a published status without a published
    /// revision still delivers nothing. A storefront wants `GET
    /// /pages/delivery/pages` instead, which answers only what is actually
    /// servable. Soft-deleted pages are never returned and the predicate is this
    /// route's own, not something a caller can switch off.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - bundle: String (optional)
    ///   - status: RevenexxEnums.PageStatus (optional)
    ///   - q: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesPagesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        bundle: String? = nil,
        status: RevenexxEnums.PageStatus? = nil,
        q: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/pages"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "bundle": bundle,
            "status": status,
            "q": q
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Writes two rows, not one: the page itself and the translation row for its
    /// source language, so a page is never without the language it was authored in
    /// and `GET /pages/delivery/page?slug=` can match a localized URL from the
    /// first moment. Everything the caller leaves out comes from the tenant's
    /// settings, not from a literal in this app: `bundle` from
    /// default_page_bundle, `sourceLanguage` from default_source_language
    /// (resolved for the request's market), and the status of both the page and
    /// its source translation from default_page_status (draft | published).
    ///
    /// - Parameters:
    ///   - title: String
    ///   - bundle: String (optional)
    ///   - hostOptions: Any (optional)
    ///   - meta: Any (optional)
    ///   - slug: String (optional)
    ///   - sourceLanguage: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesPagesCreate(
        title: String,
        bundle: String? = nil,
        hostOptions: Any? = nil,
        meta: Any? = nil,
        slug: String? = nil,
        sourceLanguage: String? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Writes a tombstone. The page leaves every list, every read and all delivery
    /// at once, and its slug is immediately free for another page — the unique
    /// index counts live rows only. Nothing is erased: the translations, blocks,
    /// edit state, revisions, comments and preview grants that hang off the page
    /// all keep their rows, because their `on delete cascade` belongs to a hard
    /// delete and this is not one. So a page can be brought back intact by
    /// clearing `deleted_at` — but not through this app, which publishes no
    /// route that does it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesPagesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/pages/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// One page RECORD: what it is called, where it routes, what type it is, which
    /// revision is live. Not its content — the blocks are not on this row and no
    /// expansion here returns them. The editor reads them with `GET
    /// /pages/editor/{page_id}/state`, a renderer with `GET /pages/delivery/page`.
    /// A soft-deleted page answers 404 exactly like one that never existed, so
    /// this is also the check for whether an id is still good.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesPagesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/pages/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Corrects the page RECORD — the five fields an editor changes without
    /// opening the visual editor, which are `title`, `slug`, `status`, `meta` and
    /// `bundle`, and no others. Anything else in the body is dropped rather than
    /// refused, and the block tree is unreachable from here by design: content
    /// moves only through the editor's mutation log, so a caller cannot half-edit
    /// a page behind the undo history's back. Two consequences worth knowing
    /// before you call it: a slug is unique among live pages, so claiming one that
    /// is held answers 409; and setting `status` to published does NOT put
    /// anything in front of a visitor — delivery needs a revision, which only
    /// `POST /pages/editor/{page_id}/publish` writes.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - bundle: String (optional)
    ///   - meta: Any (optional)
    ///   - slug: String (optional)
    ///   - status: RevenexxEnums.PageStatus (optional)
    ///   - title: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesPagesUpdate(
        id: String,
        bundle: String? = nil,
        meta: Any? = nil,
        slug: String? = nil,
        status: RevenexxEnums.PageStatus? = nil,
        title: String? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// One entry per publication, newest first, which is the order a history is
    /// read in and the one this route sorts by unless `order` says otherwise. The
    /// `snapshot` — the whole published page, in every language — is
    /// deliberately not in the index: it is page-sized, and nothing that renders a
    /// history needs it.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - label: String (optional)
    ///   - createdBy: String (optional)
    ///   - createdByName: String (optional)
    ///   - createdAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesPagesRevisions(
        id: String,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        label: String? = nil,
        createdBy: String? = nil,
        createdByName: String? = nil,
        createdAt: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/pages/{id}/revisions"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "label": label,
            "created_by": createdBy,
            "created_by_name": createdByName,
            "created_at": createdAt
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The target of a theme activation hook: hand it the theme's default pages
    /// and menus and it creates whatever is missing. Idempotent by `slug` and by
    /// menu key — a slug or a key the tenant already holds is skipped rather
    /// than rewritten, so re-running after a theme update adds only the new ones
    /// and never overwrites what an editor has since changed. A seeded page is
    /// published on the spot, immediately servable by delivery: the
    /// default_page_status setting deliberately does not apply, because a theme
    /// that activates with invisible pages looks broken.
    ///
    /// - Parameters:
    ///   - menus: [Any] (optional)
    ///   - pages: [Any] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.SeedResult
    ///
    open func pagesSeed(
        menus: [Any]? = nil,
        pages: [Any]? = nil
    ) async throws -> RevenexxModels.SeedResult {
        let apiPath: String = "/v1/pages/seed"

        let apiParams: [String: Any?] = [
            "menus": menus,
            "pages": pages
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.SeedResult = { response in
            return RevenexxModels.SeedResult.from(map: response as! [String: Any])
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
    /// Every column of a template is an exact-match filter here:
    /// `?page_bundle=standard&field_name=content` is how a picker asks for the
    /// templates offered in one place, and `?is_default=true` is how a "new page"
    /// flow finds the one to start from.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - id: String (optional)
    ///   - label: String (optional)
    ///   - description: String (optional)
    ///   - pageBundle: String (optional)
    ///   - fieldName: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - createdBy: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesTemplatesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        label: String? = nil,
        description: String? = nil,
        pageBundle: String? = nil,
        fieldName: String? = nil,
        isDefault: Bool? = nil,
        createdBy: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/templates"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "label": label,
            "description": description,
            "page_bundle": pageBundle,
            "field_name": fieldName,
            "is_default": isDefault,
            "created_by": createdBy,
            "created_at": createdAt,
            "updated_at": updatedAt
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Removes the template row outright. This is the one delete in the app that
    /// is not a tombstone — `templates` carries no `deleted_at` — so it cannot
    /// be undone and the id will not come back. Nothing else breaks by it: pages
    /// built from the template hold their own copy of the blocks and never
    /// referenced the row.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesTemplatesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/templates/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The blocks a page would START from if an editor picked this template —
    /// read it to preview the insert. A template is a COPY source, the opposite of
    /// a library item: nothing links back from the pages already built from it, so
    /// this tells you what future pages get and nothing about existing ones.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesTemplatesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/templates/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Edits what a future page will start from. Because templates copy rather
    /// than share, this reaches nothing that already exists — pages built from
    /// it keep the blocks they were handed, which is exactly the property that
    /// makes a template safe to edit and a library item dangerous. `is_default` is
    /// the one field with an effect past the picker: it decides what a new page of
    /// `page_bundle` starts with, and nothing here stops two templates of the same
    /// bundle from both claiming it, so which one wins is left to whoever reads
    /// the list.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - description: String (optional)
    ///   - fieldName: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - label: String (optional)
    ///   - pageBundle: String (optional)
    ///   - tree: [RevenexxModels.PageBlockTree] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesTemplatesUpdate(
        id: String,
        description: String? = nil,
        fieldName: String? = nil,
        isDefault: Bool? = nil,
        label: String? = nil,
        pageBundle: String? = nil,
        tree: [RevenexxModels.PageBlockTree]? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Discovery for the vocabulary routes: the enums this app publishes, each
    /// with its name, its title and what it is for, and none of them unpacked —
    /// the permitted values are not on this route, only on the one that serves a
    /// single vocabulary. Names: edit-state-statuses, page-statuses,
    /// translation-statuses. Fetch one with GET /pages/vocabularies/{name}; a
    /// client holding the qualified pair 'pages.<name>' builds that URL from the
    /// pair alone.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.PagesVocabularyIndex
    ///
    open func pagesVocabulariesList(
    ) async throws -> RevenexxModels.PagesVocabularyIndex {
        let apiPath: String = "/v1/pages/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.PagesVocabularyIndex = { response in
            return RevenexxModels.PagesVocabularyIndex.from(map: response as! [String: Any])
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
    /// One vocabulary unpacked: every value the column permits, each with the
    /// title to show for it, the sentence explaining it and the badge tone to
    /// render it in — everything a select or a status pill needs, so nothing
    /// downstream keeps its own copy of the labels. The values are read out of the
    /// column's CHECK constraint, so the served set IS the enforced set and the
    /// two cannot drift — a value added to the constraint appears here even
    /// before anyone labels it, titled from its own key. Values come back in
    /// constraint order, which is the order a select should offer. 'closed' says
    /// the set is exhaustive, so a value outside it is stale data rather than a
    /// missing label. Names: edit-state-statuses, page-statuses,
    /// translation-statuses.
    ///
    /// - Parameters:
    ///   - name: RevenexxEnums.PagesVocabulariesGetName
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesVocabulariesGet(
        name: RevenexxEnums.PagesVocabulariesGetName
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/vocabularies/{name}"
            .replacingOccurrences(of: "{name}", with: name.rawValue)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}