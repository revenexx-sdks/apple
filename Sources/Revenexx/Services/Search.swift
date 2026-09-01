import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Read-only full-text search over the tenant's installed collections.
open class Search: Service {

    ///
    /// The collections the tenant's installed apps have provisioned. Available on
    /// the API-gateway-trust path only — a `revx_` key authorises a single
    /// collection, so discovery is a gateway concern and a key-authenticated
    /// caller gets 403.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func searchListCollections(
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/search/collections"

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
    /// Returns the Typesense collection definition (fields, defaults, document
    /// count). Requires the `collections:read` action.
    ///
    /// - Parameters:
    ///   - collection: RevenexxEnums.Collection
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func searchGetCollection(
        collection: RevenexxEnums.Collection
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/search/collections/{collection}"
            .replacingOccurrences(of: "{collection}", with: collection.rawValue)

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
    /// Full-text search within one collection. Typesense search parameters are
    /// passed through verbatim as the query string, so parameters not listed here
    /// still reach Typesense. Requires the `documents:search` action.
    ///
    /// - Parameters:
    ///   - collection: RevenexxEnums.Collection
    ///   - q: String (optional)
    ///   - queryBy: String (optional)
    ///   - filterBy: String (optional)
    ///   - sortBy: String (optional)
    ///   - facetBy: String (optional)
    ///   - maxFacetValues: Int (optional)
    ///   - groupBy: String (optional)
    ///   - includeFields: String (optional)
    ///   - excludeFields: String (optional)
    ///   - highlightFullFields: String (optional)
    ///   - numTypos: Int (optional)
    ///   - prefix: String (optional)
    ///   - page: Int (optional)
    ///   - perPage: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func searchSearchDocumentsGet(
        collection: RevenexxEnums.Collection,
        q: String? = nil,
        queryBy: String? = nil,
        filterBy: String? = nil,
        sortBy: String? = nil,
        facetBy: String? = nil,
        maxFacetValues: Int? = nil,
        groupBy: String? = nil,
        includeFields: String? = nil,
        excludeFields: String? = nil,
        highlightFullFields: String? = nil,
        numTypos: Int? = nil,
        `prefix`: String? = nil,
        page: Int? = nil,
        perPage: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/search/collections/{collection}/documents/search"
            .replacingOccurrences(of: "{collection}", with: collection.rawValue)

        let apiParams: [String: Any?] = [
            "q": q,
            "query_by": queryBy,
            "filter_by": filterBy,
            "sort_by": sortBy,
            "facet_by": facetBy,
            "max_facet_values": maxFacetValues,
            "group_by": groupBy,
            "include_fields": includeFields,
            "exclude_fields": excludeFields,
            "highlight_full_fields": highlightFullFields,
            "num_typos": numTypos,
            "prefix": `prefix`,
            "page": page,
            "per_page": perPage
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
    /// Full-text search within one collection, with the Typesense search
    /// parameters in the body. Requires the `documents:search` action.
    ///
    /// - Parameters:
    ///   - collection: RevenexxEnums.Collection
    ///   - excludeFields: String (optional)
    ///   - facetBy: String (optional)
    ///   - filterBy: String (optional)
    ///   - groupBy: String (optional)
    ///   - highlightFullFields: String (optional)
    ///   - includeFields: String (optional)
    ///   - maxFacetValues: Int (optional)
    ///   - numTypos: Int (optional)
    ///   - page: Int (optional)
    ///   - perPage: Int (optional)
    ///   - prefix: String (optional)
    ///   - q: String (optional)
    ///   - queryBy: String (optional)
    ///   - sortBy: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func searchSearchDocuments(
        collection: RevenexxEnums.Collection,
        excludeFields: String? = nil,
        facetBy: String? = nil,
        filterBy: String? = nil,
        groupBy: String? = nil,
        highlightFullFields: String? = nil,
        includeFields: String? = nil,
        maxFacetValues: Int? = nil,
        numTypos: Int? = nil,
        page: Int? = nil,
        perPage: Int? = nil,
        `prefix`: String? = nil,
        q: String? = nil,
        queryBy: String? = nil,
        sortBy: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/search/collections/{collection}/documents/search"
            .replacingOccurrences(of: "{collection}", with: collection.rawValue)

        let apiParams: [String: Any?] = [
            "exclude_fields": excludeFields,
            "facet_by": facetBy,
            "filter_by": filterBy,
            "group_by": groupBy,
            "highlight_full_fields": highlightFullFields,
            "include_fields": includeFields,
            "max_facet_values": maxFacetValues,
            "num_typos": numTypos,
            "page": page,
            "per_page": perPage,
            "prefix": `prefix`,
            "q": q,
            "query_by": queryBy,
            "sort_by": sortBy
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
    /// Fetch a single document by id. The document shape is the collection's own
    /// schema, so it is described as a free-form object. Requires the
    /// `documents:get` action.
    ///
    /// - Parameters:
    ///   - collection: RevenexxEnums.Collection
    ///   - documentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func searchGetDocument(
        collection: RevenexxEnums.Collection,
        documentId: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/search/collections/{collection}/documents/{documentId}"
            .replacingOccurrences(of: "{collection}", with: collection.rawValue)
            .replacingOccurrences(of: "{documentId}", with: documentId)

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
    /// Idempotent, and bounded by the tenant's own configuration: it can add
    /// no field for an attribute the tenant has not marked `is_filterable`,
    /// and drops only fields whose attribute it has itself un-marked. A run
    /// that changes nothing makes zero calls to Typesense.
    /// 
    /// Body (optional) narrows the sweep to one app:
    /// 
    ///     {"vendor": "revenexx", "app": "products"}
    /// 
    /// Omitted, every app the tenant has installed is swept. Apps outside the
    /// facet-sync allowlist are included in the response with
    /// `skipped: app_not_enabled` rather than silently dropped — a caller
    /// asking for an app that cannot have facets deserves to be told so.
    /// 
    /// The response shape below is DECLARED rather than inferred. Its entries
    /// are built by spreading AttributeFacetSyncer::syncForCollection()'s
    /// summary, and the generator cannot see through an array spread: left to
    /// itself it emits an unnamed property and a null in `required`, which
    /// Spectral rejects as `"1" property must be string`.
    /// AppController::resyncFacets() carries the same declaration for the same
    /// reason — keep both in step with syncForApp()'s return type.
    ///
    /// - Parameters:
    ///   - app: String (optional)
    ///   - vendor: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func gatewayFacetResync(
        app: String? = nil,
        vendor: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/search/facets/resync"

        let apiParams: [String: Any?] = [
            "app": app,
            "vendor": vendor
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
    /// Run several searches in one round trip — the endpoint the typesense-js
    /// `multiSearch` helper and the InstantSearch adapter use for every query. On
    /// the gateway-trust path each entry must name a collection the tenant owns.
    /// With a `revx_` key `collection_name` is optional and is forced to the key's
    /// own collection. Requires the `documents:search` action.
    ///
    /// - Parameters:
    ///   - searches: [RevenexxModels.MultiSearchEntry<AnyCodable>]
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func searchMultiSearch(
        searches: [RevenexxModels.MultiSearchEntry<AnyCodable>]
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/search/multi_search"

        let apiParams: [String: Any?] = [
            "searches": searches
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


}