import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// What a storefront calls, and the group to start in if you are building a theme. Four read-only routes, no editorial concepts in any of them: resolve one published page by slug or id into a ready-to-render block tree, list the published pages for routing and sitemaps, read the navigation menus, and resolve a share token into the CURRENT unpublished state for a preview link. These serve the published revision — not the live rows — with the requested language filled in from its fallback chain, block-level publish windows applied and library references expanded, so a renderer needs no second call and no knowledge of how any of it was authored.
open class PagesDelivery: Service {

    ///
    /// One call gives a theme its whole chrome: header, footer and account
    /// navigation, each under the key the theme looks it up by. This route reads
    /// no filter — fetch all of them once and index by `id`.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesDeliveryMenus(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/delivery/menus"

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
    /// What a storefront calls to render a URL: `GET
    /// /pages/delivery/page?slug=about-us&langcode=de`. Send exactly one selector
    /// — `slug` or `id`. `slug` is matched against the page and then against its
    /// translations, so a localized URL resolves to its page. Only the PUBLISHED
    /// revision is served, so an edit in progress never leaks. What comes back is
    /// finished rather than raw: `langcode` is resolved field by field with the
    /// page's source language behind it, blocks whose publish window has not
    /// opened or has already closed are left out, and every library reference is
    /// expanded into the subtree it points at — so a renderer walks the tree it
    /// is given and makes no second call for any of it.
    ///
    /// - Parameters:
    ///   - slug: String (optional)
    ///   - id: String (optional)
    ///   - langcode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesDeliveryPage(
        slug: String? = nil,
        id: String? = nil,
        langcode: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/delivery/page"

        let apiParams: [String: Any?] = [
            "slug": slug,
            "id": id,
            "langcode": langcode
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
    /// The route a sitemap, a static build or a link picker is generated from.
    /// Only published pages, never a soft-deleted one — `filter` echoes both
    /// predicates the route applies on its own. A `?status=` of your own is
    /// ignored: this route is the published view by definition.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - bundle: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func pagesDeliveryPages(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        bundle: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/pages/delivery/pages"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "bundle": bundle
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// The same shape `GET /pages/delivery/page` answers, built from the
    /// UNPUBLISHED working copy instead of the published revision — so a
    /// reviewer without an editor account sees exactly what the storefront would
    /// render.
    ///
    /// - Parameters:
    ///   - token: String
    ///   - langcode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pagesDeliveryPreview(
        token: String,
        langcode: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/pages/delivery/preview/{token}"
            .replacingOccurrences(of: "{token}", with: token)

        let apiParams: [String: Any?] = [
            "langcode": langcode
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


}