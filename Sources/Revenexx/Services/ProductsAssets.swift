import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The decoupled media domain: the asset rows a product's media attribute points at, whether their bytes sit in this platform's object store or on somebody else's host. An asset is addressed by code within its family and is never linked to a product by a join table — a product references it through an attribute value. The families that give assets their shape and their file-naming convention live in Data model.
open class ProductsAssets: Service {

    ///
    /// One piece of media in the decoupled asset domain. The bytes live either in
    /// this platform's object store (`source: "storage"` with a `storage_asset_id`
    /// that survives a rename) or on somebody else's host (`source: "external"`
    /// with an `external_url`), and the database enforces the pair so neither half
    /// can be stored alone. A product points at an asset by its code through a
    /// media attribute; there is no product-to-asset link table in this app.
    /// 
    /// Every column of `assets` is an exact-match query parameter, `order` sorts
    /// by one column, and `limit`/`offset` page through `page.total`. A query key
    /// that is NOT a column is dropped rather than refused, and the `filter`
    /// object echoes the ones that were understood — that echo is the only way
    /// to tell an unfiltered answer from an empty one. It reads rows exactly as
    /// they are stored: no join is resolved, no jsonb value is unpacked.
    /// 
    /// Answered from the gateway's tenant cache for up to 30 minutes and dropped
    /// the moment this entity is written, because the data model changes weekly at
    /// most and every product page asks the same question.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - id: String (optional)
    ///   - assetFamilyId: String (optional)
    ///   - code: String (optional)
    ///   - source: RevenexxEnums.ProductsAssetsListSource (optional)
    ///   - storageAssetId: String (optional)
    ///   - deliveryPath: String (optional)
    ///   - externalUrl: String (optional)
    ///   - attributeValues: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsAssetsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        assetFamilyId: String? = nil,
        code: String? = nil,
        source: RevenexxEnums.ProductsAssetsListSource? = nil,
        storageAssetId: String? = nil,
        deliveryPath: String? = nil,
        externalUrl: String? = nil,
        attributeValues: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/assets"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "asset_family_id": assetFamilyId,
            "code": code,
            "source": source,
            "storage_asset_id": storageAssetId,
            "delivery_path": deliveryPath,
            "external_url": externalUrl,
            "attribute_values": attributeValues,
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
    /// Creates one asset and answers 201 with the stored row, including the id and
    /// the timestamps the database filled in — a client never sends an id, it
    /// reads one back and uses it in the path of every later call.
    /// 
    /// One piece of media in the decoupled asset domain. The bytes live either in
    /// this platform's object store (`source: "storage"` with a `storage_asset_id`
    /// that survives a rename) or on somebody else's host (`source: "external"`
    /// with an `external_url`), and the database enforces the pair so neither half
    /// can be stored alone. A product points at an asset by its code through a
    /// media attribute; there is no product-to-asset link table in this app.
    /// 
    /// `asset_family_id` and `code` are the only columns the database refuses the
    /// row without; everything else has a default or is nullable. A second row
    /// with the same `asset_family_id` and `code` answers 409. This app owns the
    /// create, because it is the only place an external URL can enter the catalog:
    /// an asset with no family falls back to the `default_asset_family` setting,
    /// and an `external` one is refused unless the tenant allows external media
    /// and the URL's host is on its allow-list.
    ///
    /// - Parameters:
    ///   - assetFamilyId: String
    ///   - code: String
    ///   - attributeValues: Any (optional)
    ///   - deliveryPath: String (optional)
    ///   - externalUrl: String (optional)
    ///   - source: RevenexxEnums.AssetsSource (optional)
    ///   - storageAssetId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssetsCreate(
        assetFamilyId: String,
        code: String,
        attributeValues: Any? = nil,
        deliveryPath: String? = nil,
        externalUrl: String? = nil,
        source: RevenexxEnums.AssetsSource? = nil,
        storageAssetId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/assets"

        let apiParams: [String: Any?] = [
            "asset_family_id": assetFamilyId,
            "attribute_values": attributeValues,
            "code": code,
            "delivery_path": deliveryPath,
            "external_url": externalUrl,
            "source": source,
            "storage_asset_id": storageAssetId
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
    /// Deletes one asset by id. It is a hard delete — the row is gone, and the
    /// answer is a confirmation rather than a result to branch on.
    /// 
    /// Nothing in this schema references it, so nothing else changes.
    /// 
    /// An id no asset of this tenant carries answers 404; there is no 409, because
    /// every foreign key pointing at this entity resolves itself on delete rather
    /// than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssetsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/assets/{id}"
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
    /// Reads one asset by its id — the whole row, every column, as it is stored.
    /// 
    /// One piece of media in the decoupled asset domain. The bytes live either in
    /// this platform's object store (`source: "storage"` with a `storage_asset_id`
    /// that survives a rename) or on somebody else's host (`source: "external"`
    /// with an `external_url`), and the database enforces the pair so neither half
    /// can be stored alone. A product points at an asset by its code through a
    /// media attribute; there is no product-to-asset link table in this app.
    /// 
    /// An id no asset of this tenant carries answers 404, and so does one
    /// belonging to another tenant: row-level security makes that row invisible
    /// rather than forbidden. A malformed id answers 400 before the route is
    /// reached.
    /// 
    /// Answered from the gateway's tenant cache for up to 30 minutes and dropped
    /// the moment this entity is written, because the data model changes weekly at
    /// most and every product page asks the same question.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssetsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/assets/{id}"
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
    /// Updates one asset by id. A partial patch: the body names only the columns
    /// to change and every column it leaves out keeps its current value, so there
    /// is no read-modify-write and no way to blank a field by forgetting it.
    /// 
    /// One piece of media in the decoupled asset domain. The bytes live either in
    /// this platform's object store (`source: "storage"` with a `storage_asset_id`
    /// that survives a rename) or on somebody else's host (`source: "external"`
    /// with an `external_url`), and the database enforces the pair so neither half
    /// can be stored alone. A product points at an asset by its code through a
    /// media attribute; there is no product-to-asset link table in this app.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `asset_family_id` and `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - assetFamilyId: String (optional)
    ///   - attributeValues: Any (optional)
    ///   - code: String (optional)
    ///   - deliveryPath: String (optional)
    ///   - externalUrl: String (optional)
    ///   - source: RevenexxEnums.AssetsSource (optional)
    ///   - storageAssetId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssetsUpdate(
        id: String,
        assetFamilyId: String? = nil,
        attributeValues: Any? = nil,
        code: String? = nil,
        deliveryPath: String? = nil,
        externalUrl: String? = nil,
        source: RevenexxEnums.AssetsSource? = nil,
        storageAssetId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/assets/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "asset_family_id": assetFamilyId,
            "attribute_values": attributeValues,
            "code": code,
            "delivery_path": deliveryPath,
            "external_url": externalUrl,
            "source": source,
            "storage_asset_id": storageAssetId
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


}