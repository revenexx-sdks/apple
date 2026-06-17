import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// Read-only full-text search over the tenant&#039;s installed collections.
open class Search: Service {

    ///
    /// The collections the tenant's installed apps have provisioned.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func searchListCollections(
    ) async throws -> Any {
        let apiPath: String = "/v1/search/collections"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Full-text search within one collection using Typesense query parameters as
    /// the query string.
    ///
    /// - Parameters:
    ///   - collection: Revenexx API — revenexxEnums.Collection
    ///   - q: String (optional)
    ///   - queryBy: String (optional)
    ///   - filterBy: String (optional)
    ///   - sortBy: String (optional)
    ///   - page: Int (optional)
    ///   - perPage: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func searchSearchDocumentsGet(
        collection: Revenexx API — revenexxEnums.Collection,
        q: String? = nil,
        queryBy: String? = nil,
        filterBy: String? = nil,
        sortBy: String? = nil,
        page: Int? = nil,
        perPage: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/search/collections/{collection}/documents/search"
            .replacingOccurrences(of: "{collection}", with: collection.rawValue)

        let apiParams: [String: Any?] = [
            "q": q,
            "query_by": queryBy,
            "filter_by": filterBy,
            "sort_by": sortBy,
            "page": page,
            "per_page": perPage
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Full-text search within one collection. The body holds Typesense search
    /// parameters.
    ///
    /// - Parameters:
    ///   - collection: Revenexx API — revenexxEnums.Collection
    ///   - facetBy: String (optional)
    ///   - filterBy: String (optional)
    ///   - page: Int (optional)
    ///   - perPage: Int (optional)
    ///   - q: String (optional)
    ///   - queryBy: String (optional)
    ///   - sortBy: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func searchSearchDocuments(
        collection: Revenexx API — revenexxEnums.Collection,
        facetBy: String? = nil,
        filterBy: String? = nil,
        page: Int? = nil,
        perPage: Int? = nil,
        q: String? = nil,
        queryBy: String? = nil,
        sortBy: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/search/collections/{collection}/documents/search"
            .replacingOccurrences(of: "{collection}", with: collection.rawValue)

        let apiParams: [String: Any?] = [
            "facet_by": facetBy,
            "filter_by": filterBy,
            "page": page,
            "per_page": perPage,
            "q": q,
            "query_by": queryBy,
            "sort_by": sortBy
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
    /// Fetch a single document by id from a collection the tenant has installed.
    ///
    /// - Parameters:
    ///   - collection: Revenexx API — revenexxEnums.Collection
    ///   - documentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func searchGetDocument(
        collection: Revenexx API — revenexxEnums.Collection,
        documentId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/search/collections/{collection}/documents/{documentId}"
            .replacingOccurrences(of: "{collection}", with: collection.rawValue)
            .replacingOccurrences(of: "{documentId}", with: documentId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Run several searches in one request (the InstantSearch adapter uses this).
    /// Each entry names its collection.
    ///
    /// - Parameters:
    ///   - searches: [Any]
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func searchMultiSearch(
        searches: [Any]
    ) async throws -> Any {
        let apiPath: String = "/v1/search/multi_search"

        let apiParams: [String: Any?] = [
            "searches": searches
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


}