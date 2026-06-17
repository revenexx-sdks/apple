import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// Short-lived file access tokens.
open class Tokens: Service {

    ///
    /// List all the tokens created for a specific file or bucket. You can use the
    /// query params to filter your results.
    ///
    /// - Parameters:
    ///   - bucketId: String
    ///   - fileId: String
    ///   - queries: [String] (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ResourceTokenList
    ///
    open func tokensList(
        bucketId: String,
        fileId: String,
        queries: [String]? = nil,
        total: Bool? = nil
    ) async throws -> Revenexx API — revenexxModels.ResourceTokenList {
        let apiPath: String = "/v1/tokens/buckets/{bucketId}/files/{fileId}"
            .replacingOccurrences(of: "{bucketId}", with: bucketId)
            .replacingOccurrences(of: "{fileId}", with: fileId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ResourceTokenList = { response in
            return RevenexxAPIRevenexxModels.ResourceTokenList.from(map: response as! [String: Any])
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
    /// Create a new token. A token is linked to a file. Token can be passed as a
    /// request URL search parameter.
    ///
    /// - Parameters:
    ///   - bucketId: String
    ///   - fileId: String
    ///   - expire: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ResourceToken
    ///
    open func tokensCreateFileToken(
        bucketId: String,
        fileId: String,
        expire: String? = nil
    ) async throws -> Revenexx API — revenexxModels.ResourceToken {
        let apiPath: String = "/v1/tokens/buckets/{bucketId}/files/{fileId}"
            .replacingOccurrences(of: "{bucketId}", with: bucketId)
            .replacingOccurrences(of: "{fileId}", with: fileId)

        let apiParams: [String: Any?] = [
            "expire": expire
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ResourceToken = { response in
            return RevenexxAPIRevenexxModels.ResourceToken.from(map: response as! [String: Any])
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
    /// Delete a token by its unique ID.
    ///
    /// - Parameters:
    ///   - tokenId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func tokensDelete(
        tokenId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/tokens/{tokenId}"
            .replacingOccurrences(of: "{tokenId}", with: tokenId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a token by its unique ID.
    ///
    /// - Parameters:
    ///   - tokenId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ResourceToken
    ///
    open func tokensGet(
        tokenId: String
    ) async throws -> Revenexx API — revenexxModels.ResourceToken {
        let apiPath: String = "/v1/tokens/{tokenId}"
            .replacingOccurrences(of: "{tokenId}", with: tokenId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ResourceToken = { response in
            return RevenexxAPIRevenexxModels.ResourceToken.from(map: response as! [String: Any])
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
    /// Update a token by its unique ID. Use this endpoint to update a token's
    /// expiry date.
    ///
    /// - Parameters:
    ///   - tokenId: String
    ///   - expire: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ResourceToken
    ///
    open func tokensUpdate(
        tokenId: String,
        expire: String? = nil
    ) async throws -> Revenexx API — revenexxModels.ResourceToken {
        let apiPath: String = "/v1/tokens/{tokenId}"
            .replacingOccurrences(of: "{tokenId}", with: tokenId)

        let apiParams: [String: Any?] = [
            "expire": expire
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ResourceToken = { response in
            return RevenexxAPIRevenexxModels.ResourceToken.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}