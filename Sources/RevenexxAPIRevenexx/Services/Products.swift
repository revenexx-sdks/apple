import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Products: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products"

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
    ///   - sku: String
    ///   - attributeValues: Any (optional)
    ///   - completeness: Any (optional)
    ///   - deletedAt: String (optional)
    ///   - enabled: Bool (optional)
    ///   - familyId: String (optional)
    ///   - familyVariantId: String (optional)
    ///   - kind: String (optional)
    ///   - parentId: String (optional)
    ///   - quantifiedAssociations: Any (optional)
    ///   - taxClass: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Products
    ///
    open func productsCreate(
        sku: String,
        attributeValues: Any? = nil,
        completeness: Any? = nil,
        deletedAt: String? = nil,
        enabled: Bool? = nil,
        familyId: String? = nil,
        familyVariantId: String? = nil,
        kind: String? = nil,
        parentId: String? = nil,
        quantifiedAssociations: Any? = nil,
        taxClass: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Products {
        let apiPath: String = "/v1/products"

        let apiParams: [String: Any?] = [
            "attribute_values": attributeValues,
            "completeness": completeness,
            "deleted_at": deletedAt,
            "enabled": enabled,
            "family_id": familyId,
            "family_variant_id": familyVariantId,
            "kind": kind,
            "parent_id": parentId,
            "quantified_associations": quantifiedAssociations,
            "sku": sku,
            "tax_class": taxClass
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Products = { response in
            return RevenexxAPIRevenexxModels.Products.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsAssetFamiliesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/asset_families"

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
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - namingConvention: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AssetFamilies
    ///
    open func productsAssetFamiliesCreate(
        code: String,
        labels: Any? = nil,
        namingConvention: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.AssetFamilies {
        let apiPath: String = "/v1/products/asset_families"

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "naming_convention": namingConvention
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AssetFamilies = { response in
            return RevenexxAPIRevenexxModels.AssetFamilies.from(map: response as! [String: Any])
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
    open func productsAssetFamiliesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/asset_families/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.AssetFamilies
    ///
    open func productsAssetFamiliesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.AssetFamilies {
        let apiPath: String = "/v1/products/asset_families/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.AssetFamilies = { response in
            return RevenexxAPIRevenexxModels.AssetFamilies.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - namingConvention: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AssetFamilies
    ///
    open func productsAssetFamiliesUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        namingConvention: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.AssetFamilies {
        let apiPath: String = "/v1/products/asset_families/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "naming_convention": namingConvention
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AssetFamilies = { response in
            return RevenexxAPIRevenexxModels.AssetFamilies.from(map: response as! [String: Any])
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
    open func productsAssetsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/assets"

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
    ///   - assetFamilyId: String
    ///   - code: String
    ///   - attributeValues: Any (optional)
    ///   - mediaUuid: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Assets
    ///
    open func productsAssetsCreate(
        assetFamilyId: String,
        code: String,
        attributeValues: Any? = nil,
        mediaUuid: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Assets {
        let apiPath: String = "/v1/products/assets"

        let apiParams: [String: Any?] = [
            "asset_family_id": assetFamilyId,
            "attribute_values": attributeValues,
            "code": code,
            "media_uuid": mediaUuid
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Assets = { response in
            return RevenexxAPIRevenexxModels.Assets.from(map: response as! [String: Any])
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
    open func productsAssetsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/assets/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Assets
    ///
    open func productsAssetsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Assets {
        let apiPath: String = "/v1/products/assets/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Assets = { response in
            return RevenexxAPIRevenexxModels.Assets.from(map: response as! [String: Any])
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
    ///   - assetFamilyId: String (optional)
    ///   - attributeValues: Any (optional)
    ///   - code: String (optional)
    ///   - mediaUuid: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Assets
    ///
    open func productsAssetsUpdate(
        id: String,
        assetFamilyId: String? = nil,
        attributeValues: Any? = nil,
        code: String? = nil,
        mediaUuid: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Assets {
        let apiPath: String = "/v1/products/assets/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "asset_family_id": assetFamilyId,
            "attribute_values": attributeValues,
            "code": code,
            "media_uuid": mediaUuid
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Assets = { response in
            return RevenexxAPIRevenexxModels.Assets.from(map: response as! [String: Any])
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
    open func productsAssociationTypesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/association_types"

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
    ///   - code: String
    ///   - isQuantified: Bool (optional)
    ///   - isTwoWay: Bool (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AssociationTypes
    ///
    open func productsAssociationTypesCreate(
        code: String,
        isQuantified: Bool? = nil,
        isTwoWay: Bool? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.AssociationTypes {
        let apiPath: String = "/v1/products/association_types"

        let apiParams: [String: Any?] = [
            "code": code,
            "is_quantified": isQuantified,
            "is_two_way": isTwoWay,
            "labels": labels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AssociationTypes = { response in
            return RevenexxAPIRevenexxModels.AssociationTypes.from(map: response as! [String: Any])
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
    open func productsAssociationTypesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/association_types/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.AssociationTypes
    ///
    open func productsAssociationTypesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.AssociationTypes {
        let apiPath: String = "/v1/products/association_types/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.AssociationTypes = { response in
            return RevenexxAPIRevenexxModels.AssociationTypes.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - isQuantified: Bool (optional)
    ///   - isTwoWay: Bool (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AssociationTypes
    ///
    open func productsAssociationTypesUpdate(
        id: String,
        code: String? = nil,
        isQuantified: Bool? = nil,
        isTwoWay: Bool? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.AssociationTypes {
        let apiPath: String = "/v1/products/association_types/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_quantified": isQuantified,
            "is_two_way": isTwoWay,
            "labels": labels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AssociationTypes = { response in
            return RevenexxAPIRevenexxModels.AssociationTypes.from(map: response as! [String: Any])
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
    open func productsAttributeGroupsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attribute_groups"

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
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AttributeGroups
    ///
    open func productsAttributeGroupsCreate(
        code: String,
        labels: Any? = nil,
        position: Int? = nil
    ) async throws -> Revenexx API — revenexxModels.AttributeGroups {
        let apiPath: String = "/v1/products/attribute_groups"

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "position": position
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AttributeGroups = { response in
            return RevenexxAPIRevenexxModels.AttributeGroups.from(map: response as! [String: Any])
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
    open func productsAttributeGroupsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attribute_groups/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.AttributeGroups
    ///
    open func productsAttributeGroupsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.AttributeGroups {
        let apiPath: String = "/v1/products/attribute_groups/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.AttributeGroups = { response in
            return RevenexxAPIRevenexxModels.AttributeGroups.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AttributeGroups
    ///
    open func productsAttributeGroupsUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        position: Int? = nil
    ) async throws -> Revenexx API — revenexxModels.AttributeGroups {
        let apiPath: String = "/v1/products/attribute_groups/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "position": position
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AttributeGroups = { response in
            return RevenexxAPIRevenexxModels.AttributeGroups.from(map: response as! [String: Any])
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
    open func productsAttributeOptionsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attribute_options"

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
    ///   - attributeId: String
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - swatch: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AttributeOptions
    ///
    open func productsAttributeOptionsCreate(
        attributeId: String,
        code: String,
        labels: Any? = nil,
        position: Int? = nil,
        swatch: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.AttributeOptions {
        let apiPath: String = "/v1/products/attribute_options"

        let apiParams: [String: Any?] = [
            "attribute_id": attributeId,
            "code": code,
            "labels": labels,
            "position": position,
            "swatch": swatch
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AttributeOptions = { response in
            return RevenexxAPIRevenexxModels.AttributeOptions.from(map: response as! [String: Any])
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
    open func productsAttributeOptionsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attribute_options/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.AttributeOptions
    ///
    open func productsAttributeOptionsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.AttributeOptions {
        let apiPath: String = "/v1/products/attribute_options/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.AttributeOptions = { response in
            return RevenexxAPIRevenexxModels.AttributeOptions.from(map: response as! [String: Any])
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
    ///   - attributeId: String (optional)
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - swatch: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AttributeOptions
    ///
    open func productsAttributeOptionsUpdate(
        id: String,
        attributeId: String? = nil,
        code: String? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        swatch: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.AttributeOptions {
        let apiPath: String = "/v1/products/attribute_options/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "attribute_id": attributeId,
            "code": code,
            "labels": labels,
            "position": position,
            "swatch": swatch
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AttributeOptions = { response in
            return RevenexxAPIRevenexxModels.AttributeOptions.from(map: response as! [String: Any])
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
    open func productsAttributesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attributes"

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
    ///   - code: String
    ///   - type: String
    ///   - config: Any (optional)
    ///   - entityRef: String (optional)
    ///   - entityType: String (optional)
    ///   - groupId: String (optional)
    ///   - isFilterable: Bool (optional)
    ///   - isUnique: Bool (optional)
    ///   - labels: Any (optional)
    ///   - localizable: Bool (optional)
    ///   - position: Int (optional)
    ///   - scopable: Bool (optional)
    ///   - usableInGrid: Bool (optional)
    ///   - validation: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Attributes
    ///
    open func productsAttributesCreate(
        code: String,
        type: String,
        config: Any? = nil,
        entityRef: String? = nil,
        entityType: String? = nil,
        groupId: String? = nil,
        isFilterable: Bool? = nil,
        isUnique: Bool? = nil,
        labels: Any? = nil,
        localizable: Bool? = nil,
        position: Int? = nil,
        scopable: Bool? = nil,
        usableInGrid: Bool? = nil,
        validation: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.Attributes {
        let apiPath: String = "/v1/products/attributes"

        let apiParams: [String: Any?] = [
            "code": code,
            "config": config,
            "entity_ref": entityRef,
            "entity_type": entityType,
            "group_id": groupId,
            "is_filterable": isFilterable,
            "is_unique": isUnique,
            "labels": labels,
            "localizable": localizable,
            "position": position,
            "scopable": scopable,
            "type": type,
            "usable_in_grid": usableInGrid,
            "validation": validation
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Attributes = { response in
            return RevenexxAPIRevenexxModels.Attributes.from(map: response as! [String: Any])
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
    open func productsAttributesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attributes/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Attributes
    ///
    open func productsAttributesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Attributes {
        let apiPath: String = "/v1/products/attributes/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Attributes = { response in
            return RevenexxAPIRevenexxModels.Attributes.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - config: Any (optional)
    ///   - entityRef: String (optional)
    ///   - entityType: String (optional)
    ///   - groupId: String (optional)
    ///   - isFilterable: Bool (optional)
    ///   - isUnique: Bool (optional)
    ///   - labels: Any (optional)
    ///   - localizable: Bool (optional)
    ///   - position: Int (optional)
    ///   - scopable: Bool (optional)
    ///   - type: String (optional)
    ///   - usableInGrid: Bool (optional)
    ///   - validation: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Attributes
    ///
    open func productsAttributesUpdate(
        id: String,
        code: String? = nil,
        config: Any? = nil,
        entityRef: String? = nil,
        entityType: String? = nil,
        groupId: String? = nil,
        isFilterable: Bool? = nil,
        isUnique: Bool? = nil,
        labels: Any? = nil,
        localizable: Bool? = nil,
        position: Int? = nil,
        scopable: Bool? = nil,
        type: String? = nil,
        usableInGrid: Bool? = nil,
        validation: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.Attributes {
        let apiPath: String = "/v1/products/attributes/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "config": config,
            "entity_ref": entityRef,
            "entity_type": entityType,
            "group_id": groupId,
            "is_filterable": isFilterable,
            "is_unique": isUnique,
            "labels": labels,
            "localizable": localizable,
            "position": position,
            "scopable": scopable,
            "type": type,
            "usable_in_grid": usableInGrid,
            "validation": validation
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Attributes = { response in
            return RevenexxAPIRevenexxModels.Attributes.from(map: response as! [String: Any])
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
    ///   - ids: [String] (optional)
    ///   - skus: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsBatch(
        ids: [String]? = nil,
        skus: [String]? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/batch"

        let apiParams: [String: Any?] = [
            "ids": ids,
            "skus": skus
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
    open func productsCategoriesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/categories"

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
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - parentId: String (optional)
    ///   - path: String (optional)
    ///   - position: Int (optional)
    ///   - values: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Categories
    ///
    open func productsCategoriesCreate(
        code: String,
        labels: Any? = nil,
        parentId: String? = nil,
        path: String? = nil,
        position: Int? = nil,
        values: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.Categories {
        let apiPath: String = "/v1/products/categories"

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "parent_id": parentId,
            "path": path,
            "position": position,
            "values": values
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Categories = { response in
            return RevenexxAPIRevenexxModels.Categories.from(map: response as! [String: Any])
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
    open func productsCategoriesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/categories/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Categories
    ///
    open func productsCategoriesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Categories {
        let apiPath: String = "/v1/products/categories/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Categories = { response in
            return RevenexxAPIRevenexxModels.Categories.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - parentId: String (optional)
    ///   - path: String (optional)
    ///   - position: Int (optional)
    ///   - values: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Categories
    ///
    open func productsCategoriesUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        parentId: String? = nil,
        path: String? = nil,
        position: Int? = nil,
        values: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.Categories {
        let apiPath: String = "/v1/products/categories/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "parent_id": parentId,
            "path": path,
            "position": position,
            "values": values
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Categories = { response in
            return RevenexxAPIRevenexxModels.Categories.from(map: response as! [String: Any])
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
    open func productsFamiliesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/families"

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
    ///   - code: String
    ///   - imageAttribute: String (optional)
    ///   - labelAttribute: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Families
    ///
    open func productsFamiliesCreate(
        code: String,
        imageAttribute: String? = nil,
        labelAttribute: String? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.Families {
        let apiPath: String = "/v1/products/families"

        let apiParams: [String: Any?] = [
            "code": code,
            "image_attribute": imageAttribute,
            "label_attribute": labelAttribute,
            "labels": labels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Families = { response in
            return RevenexxAPIRevenexxModels.Families.from(map: response as! [String: Any])
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
    open func productsFamiliesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/families/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Families
    ///
    open func productsFamiliesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Families {
        let apiPath: String = "/v1/products/families/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Families = { response in
            return RevenexxAPIRevenexxModels.Families.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - imageAttribute: String (optional)
    ///   - labelAttribute: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Families
    ///
    open func productsFamiliesUpdate(
        id: String,
        code: String? = nil,
        imageAttribute: String? = nil,
        labelAttribute: String? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.Families {
        let apiPath: String = "/v1/products/families/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "image_attribute": imageAttribute,
            "label_attribute": labelAttribute,
            "labels": labels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Families = { response in
            return RevenexxAPIRevenexxModels.Families.from(map: response as! [String: Any])
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
    open func productsFamilyAttributesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/family_attributes"

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
    ///   - attributeId: String
    ///   - familyId: String
    ///   - isRequired: Bool (optional)
    ///   - position: Int (optional)
    ///   - requiredChannels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.FamilyAttributes
    ///
    open func productsFamilyAttributesCreate(
        attributeId: String,
        familyId: String,
        isRequired: Bool? = nil,
        position: Int? = nil,
        requiredChannels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.FamilyAttributes {
        let apiPath: String = "/v1/products/family_attributes"

        let apiParams: [String: Any?] = [
            "attribute_id": attributeId,
            "family_id": familyId,
            "is_required": isRequired,
            "position": position,
            "required_channels": requiredChannels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.FamilyAttributes = { response in
            return RevenexxAPIRevenexxModels.FamilyAttributes.from(map: response as! [String: Any])
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
    open func productsFamilyAttributesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/family_attributes/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.FamilyAttributes
    ///
    open func productsFamilyAttributesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.FamilyAttributes {
        let apiPath: String = "/v1/products/family_attributes/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.FamilyAttributes = { response in
            return RevenexxAPIRevenexxModels.FamilyAttributes.from(map: response as! [String: Any])
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
    ///   - attributeId: String (optional)
    ///   - familyId: String (optional)
    ///   - isRequired: Bool (optional)
    ///   - position: Int (optional)
    ///   - requiredChannels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.FamilyAttributes
    ///
    open func productsFamilyAttributesUpdate(
        id: String,
        attributeId: String? = nil,
        familyId: String? = nil,
        isRequired: Bool? = nil,
        position: Int? = nil,
        requiredChannels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.FamilyAttributes {
        let apiPath: String = "/v1/products/family_attributes/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "attribute_id": attributeId,
            "family_id": familyId,
            "is_required": isRequired,
            "position": position,
            "required_channels": requiredChannels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.FamilyAttributes = { response in
            return RevenexxAPIRevenexxModels.FamilyAttributes.from(map: response as! [String: Any])
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
    open func productsFamilyVariantsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/family_variants"

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
    ///   - code: String
    ///   - familyId: String
    ///   - axes: Any (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.FamilyVariants
    ///
    open func productsFamilyVariantsCreate(
        code: String,
        familyId: String,
        axes: Any? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.FamilyVariants {
        let apiPath: String = "/v1/products/family_variants"

        let apiParams: [String: Any?] = [
            "axes": axes,
            "code": code,
            "family_id": familyId,
            "labels": labels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.FamilyVariants = { response in
            return RevenexxAPIRevenexxModels.FamilyVariants.from(map: response as! [String: Any])
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
    open func productsFamilyVariantsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/family_variants/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.FamilyVariants
    ///
    open func productsFamilyVariantsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.FamilyVariants {
        let apiPath: String = "/v1/products/family_variants/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.FamilyVariants = { response in
            return RevenexxAPIRevenexxModels.FamilyVariants.from(map: response as! [String: Any])
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
    ///   - axes: Any (optional)
    ///   - code: String (optional)
    ///   - familyId: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.FamilyVariants
    ///
    open func productsFamilyVariantsUpdate(
        id: String,
        axes: Any? = nil,
        code: String? = nil,
        familyId: String? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.FamilyVariants {
        let apiPath: String = "/v1/products/family_variants/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "axes": axes,
            "code": code,
            "family_id": familyId,
            "labels": labels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.FamilyVariants = { response in
            return RevenexxAPIRevenexxModels.FamilyVariants.from(map: response as! [String: Any])
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
    open func productsMeasurementFamiliesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/measurement_families"

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
    ///   - code: String
    ///   - standardUnit: String
    ///   - labels: Any (optional)
    ///   - units: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MeasurementFamilies
    ///
    open func productsMeasurementFamiliesCreate(
        code: String,
        standardUnit: String,
        labels: Any? = nil,
        units: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.MeasurementFamilies {
        let apiPath: String = "/v1/products/measurement_families"

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "standard_unit": standardUnit,
            "units": units
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MeasurementFamilies = { response in
            return RevenexxAPIRevenexxModels.MeasurementFamilies.from(map: response as! [String: Any])
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
    open func productsMeasurementFamiliesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/measurement_families/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.MeasurementFamilies
    ///
    open func productsMeasurementFamiliesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.MeasurementFamilies {
        let apiPath: String = "/v1/products/measurement_families/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.MeasurementFamilies = { response in
            return RevenexxAPIRevenexxModels.MeasurementFamilies.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - standardUnit: String (optional)
    ///   - units: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.MeasurementFamilies
    ///
    open func productsMeasurementFamiliesUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        standardUnit: String? = nil,
        units: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.MeasurementFamilies {
        let apiPath: String = "/v1/products/measurement_families/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "standard_unit": standardUnit,
            "units": units
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.MeasurementFamilies = { response in
            return RevenexxAPIRevenexxModels.MeasurementFamilies.from(map: response as! [String: Any])
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
    open func productsProductAssociationsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/product_associations"

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
    ///   - associationTypeId: String
    ///   - productId: String
    ///   - targetProductId: String
    ///   - position: Int (optional)
    ///   - quantity: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ProductAssociations
    ///
    open func productsProductAssociationsCreate(
        associationTypeId: String,
        productId: String,
        targetProductId: String,
        position: Int? = nil,
        quantity: Double? = nil
    ) async throws -> Revenexx API — revenexxModels.ProductAssociations {
        let apiPath: String = "/v1/products/product_associations"

        let apiParams: [String: Any?] = [
            "association_type_id": associationTypeId,
            "position": position,
            "product_id": productId,
            "quantity": quantity,
            "target_product_id": targetProductId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ProductAssociations = { response in
            return RevenexxAPIRevenexxModels.ProductAssociations.from(map: response as! [String: Any])
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
    open func productsProductAssociationsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/product_associations/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.ProductAssociations
    ///
    open func productsProductAssociationsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.ProductAssociations {
        let apiPath: String = "/v1/products/product_associations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ProductAssociations = { response in
            return RevenexxAPIRevenexxModels.ProductAssociations.from(map: response as! [String: Any])
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
    ///   - associationTypeId: String (optional)
    ///   - position: Int (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - targetProductId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ProductAssociations
    ///
    open func productsProductAssociationsUpdate(
        id: String,
        associationTypeId: String? = nil,
        position: Int? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        targetProductId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.ProductAssociations {
        let apiPath: String = "/v1/products/product_associations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "association_type_id": associationTypeId,
            "position": position,
            "product_id": productId,
            "quantity": quantity,
            "target_product_id": targetProductId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ProductAssociations = { response in
            return RevenexxAPIRevenexxModels.ProductAssociations.from(map: response as! [String: Any])
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
    open func productsProductCategoriesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/product_categories"

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
    ///   - categoryId: String
    ///   - productId: String
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ProductCategories
    ///
    open func productsProductCategoriesCreate(
        categoryId: String,
        productId: String,
        position: Int? = nil
    ) async throws -> Revenexx API — revenexxModels.ProductCategories {
        let apiPath: String = "/v1/products/product_categories"

        let apiParams: [String: Any?] = [
            "category_id": categoryId,
            "position": position,
            "product_id": productId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ProductCategories = { response in
            return RevenexxAPIRevenexxModels.ProductCategories.from(map: response as! [String: Any])
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
    open func productsProductCategoriesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/product_categories/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.ProductCategories
    ///
    open func productsProductCategoriesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.ProductCategories {
        let apiPath: String = "/v1/products/product_categories/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ProductCategories = { response in
            return RevenexxAPIRevenexxModels.ProductCategories.from(map: response as! [String: Any])
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
    ///   - categoryId: String (optional)
    ///   - position: Int (optional)
    ///   - productId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ProductCategories
    ///
    open func productsProductCategoriesUpdate(
        id: String,
        categoryId: String? = nil,
        position: Int? = nil,
        productId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.ProductCategories {
        let apiPath: String = "/v1/products/product_categories/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "category_id": categoryId,
            "position": position,
            "product_id": productId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ProductCategories = { response in
            return RevenexxAPIRevenexxModels.ProductCategories.from(map: response as! [String: Any])
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
    open func productsReferenceEntitiesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/reference_entities"

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
    ///   - code: String
    ///   - image: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ReferenceEntities
    ///
    open func productsReferenceEntitiesCreate(
        code: String,
        image: String? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.ReferenceEntities {
        let apiPath: String = "/v1/products/reference_entities"

        let apiParams: [String: Any?] = [
            "code": code,
            "image": image,
            "labels": labels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ReferenceEntities = { response in
            return RevenexxAPIRevenexxModels.ReferenceEntities.from(map: response as! [String: Any])
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
    open func productsReferenceEntitiesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/reference_entities/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.ReferenceEntities
    ///
    open func productsReferenceEntitiesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.ReferenceEntities {
        let apiPath: String = "/v1/products/reference_entities/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ReferenceEntities = { response in
            return RevenexxAPIRevenexxModels.ReferenceEntities.from(map: response as! [String: Any])
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
    ///   - code: String (optional)
    ///   - image: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ReferenceEntities
    ///
    open func productsReferenceEntitiesUpdate(
        id: String,
        code: String? = nil,
        image: String? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.ReferenceEntities {
        let apiPath: String = "/v1/products/reference_entities/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "image": image,
            "labels": labels
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ReferenceEntities = { response in
            return RevenexxAPIRevenexxModels.ReferenceEntities.from(map: response as! [String: Any])
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
    open func productsReferenceEntityRecordsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/reference_entity_records"

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
    ///   - code: String
    ///   - referenceEntityId: String
    ///   - attributeValues: Any (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ReferenceEntityRecords
    ///
    open func productsReferenceEntityRecordsCreate(
        code: String,
        referenceEntityId: String,
        attributeValues: Any? = nil,
        labels: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.ReferenceEntityRecords {
        let apiPath: String = "/v1/products/reference_entity_records"

        let apiParams: [String: Any?] = [
            "attribute_values": attributeValues,
            "code": code,
            "labels": labels,
            "reference_entity_id": referenceEntityId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ReferenceEntityRecords = { response in
            return RevenexxAPIRevenexxModels.ReferenceEntityRecords.from(map: response as! [String: Any])
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
    open func productsReferenceEntityRecordsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/reference_entity_records/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.ReferenceEntityRecords
    ///
    open func productsReferenceEntityRecordsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.ReferenceEntityRecords {
        let apiPath: String = "/v1/products/reference_entity_records/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.ReferenceEntityRecords = { response in
            return RevenexxAPIRevenexxModels.ReferenceEntityRecords.from(map: response as! [String: Any])
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
    ///   - attributeValues: Any (optional)
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - referenceEntityId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.ReferenceEntityRecords
    ///
    open func productsReferenceEntityRecordsUpdate(
        id: String,
        attributeValues: Any? = nil,
        code: String? = nil,
        labels: Any? = nil,
        referenceEntityId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.ReferenceEntityRecords {
        let apiPath: String = "/v1/products/reference_entity_records/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "attribute_values": attributeValues,
            "code": code,
            "labels": labels,
            "reference_entity_id": referenceEntityId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.ReferenceEntityRecords = { response in
            return RevenexxAPIRevenexxModels.ReferenceEntityRecords.from(map: response as! [String: Any])
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
    open func productsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/products/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.Products
    ///
    open func productsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Products {
        let apiPath: String = "/v1/products/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Products = { response in
            return RevenexxAPIRevenexxModels.Products.from(map: response as! [String: Any])
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
    ///   - attributeValues: Any (optional)
    ///   - completeness: Any (optional)
    ///   - deletedAt: String (optional)
    ///   - enabled: Bool (optional)
    ///   - familyId: String (optional)
    ///   - familyVariantId: String (optional)
    ///   - kind: String (optional)
    ///   - parentId: String (optional)
    ///   - quantifiedAssociations: Any (optional)
    ///   - sku: String (optional)
    ///   - taxClass: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Products
    ///
    open func productsUpdate(
        id: String,
        attributeValues: Any? = nil,
        completeness: Any? = nil,
        deletedAt: String? = nil,
        enabled: Bool? = nil,
        familyId: String? = nil,
        familyVariantId: String? = nil,
        kind: String? = nil,
        parentId: String? = nil,
        quantifiedAssociations: Any? = nil,
        sku: String? = nil,
        taxClass: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Products {
        let apiPath: String = "/v1/products/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "attribute_values": attributeValues,
            "completeness": completeness,
            "deleted_at": deletedAt,
            "enabled": enabled,
            "family_id": familyId,
            "family_variant_id": familyVariantId,
            "kind": kind,
            "parent_id": parentId,
            "quantified_associations": quantifiedAssociations,
            "sku": sku,
            "tax_class": taxClass
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Products = { response in
            return RevenexxAPIRevenexxModels.Products.from(map: response as! [String: Any])
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