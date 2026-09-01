import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The catalog's SHAPE, which in an attribute-driven PIM is tenant data rather than a schema: a new product property is a row here, not a migration. Attributes and the groups and options that go with them, the families and family variants that decide which attributes a product has, measurement families, association types, asset families — plus the one read that answers "which fields does this family have" as a ready-to-render list. Edited rarely and by few people, which is exactly why it is its own group.
open class ProductsDataModel: Service {

    ///
    /// A class of media with one shared shape — packshots, datasheets, line
    /// drawings. The family decides which attributes an asset of it carries (alt
    /// text, copyright, an expiry date) and, through `naming_convention`, how a
    /// file of it is named — which is what lets an import bind a file to a
    /// product with no mapping table.
    /// 
    /// Every column of `asset_families` is an exact-match query parameter, `order`
    /// sorts by one column, and `limit`/`offset` page through `page.total`. A
    /// query key that is NOT a column is dropped rather than refused, and the
    /// `filter` object echoes the ones that were understood — that echo is the
    /// only way to tell an unfiltered answer from an empty one. It reads rows
    /// exactly as they are stored: no join is resolved, no jsonb value is
    /// unpacked.
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
    ///   - code: String (optional)
    ///   - labels: String (optional)
    ///   - namingConvention: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsAssetFamiliesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        code: String? = nil,
        labels: String? = nil,
        namingConvention: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/asset_families"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "code": code,
            "labels": labels,
            "naming_convention": namingConvention,
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
    /// Creates one asset family and answers 201 with the stored row, including the
    /// id and the timestamps the database filled in — a client never sends an
    /// id, it reads one back and uses it in the path of every later call.
    /// 
    /// A class of media with one shared shape — packshots, datasheets, line
    /// drawings. The family decides which attributes an asset of it carries (alt
    /// text, copyright, an expiry date) and, through `naming_convention`, how a
    /// file of it is named — which is what lets an import bind a file to a
    /// product with no mapping table.
    /// 
    /// `code` is the only column the database refuses the row without; everything
    /// else has a default or is nullable. A second row with the same `code`
    /// answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - namingConvention: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssetFamiliesCreate(
        code: String,
        labels: Any? = nil,
        namingConvention: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/asset_families"

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "naming_convention": namingConvention
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
    /// Deletes one asset family by id. It is a hard delete — the row is gone,
    /// and the answer is a confirmation rather than a result to branch on.
    /// 
    /// It takes what hangs off it: assets (`asset_family_id`) are deleted with it.
    /// 
    /// An id no asset family of this tenant carries answers 404; there is no 409,
    /// because every foreign key pointing at this entity resolves itself on delete
    /// rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssetFamiliesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/asset_families/{id}"
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
    /// Reads one asset family by its id — the whole row, every column, as it is
    /// stored.
    /// 
    /// A class of media with one shared shape — packshots, datasheets, line
    /// drawings. The family decides which attributes an asset of it carries (alt
    /// text, copyright, an expiry date) and, through `naming_convention`, how a
    /// file of it is named — which is what lets an import bind a file to a
    /// product with no mapping table.
    /// 
    /// An id no asset family of this tenant carries answers 404, and so does one
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
    open func productsAssetFamiliesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/asset_families/{id}"
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
    /// Updates one asset family by id. A partial patch: the body names only the
    /// columns to change and every column it leaves out keeps its current value,
    /// so there is no read-modify-write and no way to blank a field by forgetting
    /// it.
    /// 
    /// A class of media with one shared shape — packshots, datasheets, line
    /// drawings. The family decides which attributes an asset of it carries (alt
    /// text, copyright, an expiry date) and, through `naming_convention`, how a
    /// file of it is named — which is what lets an import bind a file to a
    /// product with no mapping table.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - namingConvention: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssetFamiliesUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        namingConvention: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// The KIND of relation two products can have — cross-sell, accessory, spare
    /// part, bill of materials. `is_two_way` declares the relation symmetric and
    /// `is_quantified` declares that it carries a quantity; both are declarations
    /// a client READS rather than behaviour this app performs — it stores one
    /// row per direction and never creates the mirror for you.
    /// 
    /// Every column of `association_types` is an exact-match query parameter,
    /// `order` sorts by one column, and `limit`/`offset` page through
    /// `page.total`. A query key that is NOT a column is dropped rather than
    /// refused, and the `filter` object echoes the ones that were understood —
    /// that echo is the only way to tell an unfiltered answer from an empty one.
    /// It reads rows exactly as they are stored: no join is resolved, no jsonb
    /// value is unpacked.
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
    ///   - code: String (optional)
    ///   - isTwoWay: Bool (optional)
    ///   - isQuantified: Bool (optional)
    ///   - labels: String (optional)
    ///   - createdAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsAssociationTypesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        code: String? = nil,
        isTwoWay: Bool? = nil,
        isQuantified: Bool? = nil,
        labels: String? = nil,
        createdAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/association_types"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "code": code,
            "is_two_way": isTwoWay,
            "is_quantified": isQuantified,
            "labels": labels,
            "created_at": createdAt
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Creates one association type and answers 201 with the stored row, including
    /// the id and the timestamps the database filled in — a client never sends
    /// an id, it reads one back and uses it in the path of every later call.
    /// 
    /// The KIND of relation two products can have — cross-sell, accessory, spare
    /// part, bill of materials. `is_two_way` declares the relation symmetric and
    /// `is_quantified` declares that it carries a quantity; both are declarations
    /// a client READS rather than behaviour this app performs — it stores one
    /// row per direction and never creates the mirror for you.
    /// 
    /// `code` is the only column the database refuses the row without; everything
    /// else has a default or is nullable. A second row with the same `code`
    /// answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - isQuantified: Bool (optional)
    ///   - isTwoWay: Bool (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssociationTypesCreate(
        code: String,
        isQuantified: Bool? = nil,
        isTwoWay: Bool? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one association type by id. It is a hard delete — the row is
    /// gone, and the answer is a confirmation rather than a result to branch on.
    /// 
    /// It takes what hangs off it: product associations (`association_type_id`)
    /// are deleted with it.
    /// 
    /// An id no association type of this tenant carries answers 404; there is no
    /// 409, because every foreign key pointing at this entity resolves itself on
    /// delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssociationTypesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/association_types/{id}"
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
    /// Reads one association type by its id — the whole row, every column, as it
    /// is stored.
    /// 
    /// The KIND of relation two products can have — cross-sell, accessory, spare
    /// part, bill of materials. `is_two_way` declares the relation symmetric and
    /// `is_quantified` declares that it carries a quantity; both are declarations
    /// a client READS rather than behaviour this app performs — it stores one
    /// row per direction and never creates the mirror for you.
    /// 
    /// An id no association type of this tenant carries answers 404, and so does
    /// one belonging to another tenant: row-level security makes that row
    /// invisible rather than forbidden. A malformed id answers 400 before the
    /// route is reached.
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
    open func productsAssociationTypesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/association_types/{id}"
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
    /// Updates one association type by id. A partial patch: the body names only
    /// the columns to change and every column it leaves out keeps its current
    /// value, so there is no read-modify-write and no way to blank a field by
    /// forgetting it.
    /// 
    /// The KIND of relation two products can have — cross-sell, accessory, spare
    /// part, bill of materials. `is_two_way` declares the relation symmetric and
    /// `is_quantified` declares that it carries a quantity; both are declarations
    /// a client READS rather than behaviour this app performs — it stores one
    /// row per direction and never creates the mirror for you.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - isQuantified: Bool (optional)
    ///   - isTwoWay: Bool (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAssociationTypesUpdate(
        id: String,
        code: String? = nil,
        isQuantified: Bool? = nil,
        isTwoWay: Bool? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Which fields does this family have — one ready-to-render list, not six
    /// joined tables. The catalog's SHAPE is tenant data: a product's properties
    /// are rows in `attributes`, grouped by `attribute_groups`, selected per
    /// family by `family_attributes`, with their permitted values in
    /// `attribute_options` and their variant axes in `family_variants`. Reading
    /// that shape used to mean five reads, a join, and a private `attributes.type`
    /// → input mapping in every client — and that mapping is the part that
    /// must live here, because the type list carries no CHECK by design and an
    /// integrator extends it. Answers one field list instead, ordered by group
    /// then by the family's own ordering. Without a family it answers every
    /// attribute declared for `entity_type`/`entity_ref` — the shape of a
    /// reference entity's records or an asset family, which have attributes but no
    /// family. Writes nothing.
    ///
    /// - Parameters:
    ///   - familyId: String (optional)
    ///   - familyCode: String (optional)
    ///   - entityType: RevenexxEnums.EntityType (optional)
    ///   - entityRef: String (optional)
    ///   - locale: String (optional)
    ///   - channel: String (optional)
    ///   - kind: RevenexxEnums.Kind (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAttributeSchema(
        familyId: String? = nil,
        familyCode: String? = nil,
        entityType: RevenexxEnums.EntityType? = nil,
        entityRef: String? = nil,
        locale: String? = nil,
        channel: String? = nil,
        kind: RevenexxEnums.Kind? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/attribute-schema"

        let apiParams: [String: Any?] = [
            "family_id": familyId,
            "family_code": familyCode,
            "entity_type": entityType,
            "entity_ref": entityRef,
            "locale": locale,
            "channel": channel,
            "kind": kind
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
    /// An attribute group is a SECTION of a product form — "Technical
    /// attributes", "Logistics" — and the thing every attribute is filed under.
    /// It carries a `position`, which is the order the sections appear in, and
    /// per-language `labels`, which is what an operator reads; the `code` is what
    /// an attribute joins on and is never shown. `GET /products/attribute-schema`
    /// already resolves a group's heading onto every field it returns, so these
    /// routes are for MANAGING the sections, not for rendering a form.
    /// 
    /// Every column of `attribute_groups` is an exact-match query parameter,
    /// `order` sorts by one column, and `limit`/`offset` page through
    /// `page.total`. A query key that is NOT a column is dropped rather than
    /// refused, and the `filter` object echoes the ones that were understood —
    /// that echo is the only way to tell an unfiltered answer from an empty one.
    /// It reads rows exactly as they are stored: no join is resolved, no jsonb
    /// value is unpacked.
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
    ///   - code: String (optional)
    ///   - position: Int (optional)
    ///   - labels: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsAttributeGroupsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        code: String? = nil,
        position: Int? = nil,
        labels: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attribute_groups"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "code": code,
            "position": position,
            "labels": labels,
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
    /// Creates one attribute group and answers 201 with the stored row, including
    /// the id and the timestamps the database filled in — a client never sends
    /// an id, it reads one back and uses it in the path of every later call.
    /// 
    /// An attribute group is a SECTION of a product form — "Technical
    /// attributes", "Logistics" — and the thing every attribute is filed under.
    /// It carries a `position`, which is the order the sections appear in, and
    /// per-language `labels`, which is what an operator reads; the `code` is what
    /// an attribute joins on and is never shown. `GET /products/attribute-schema`
    /// already resolves a group's heading onto every field it returns, so these
    /// routes are for MANAGING the sections, not for rendering a form.
    /// 
    /// `code` is the only column the database refuses the row without; everything
    /// else has a default or is nullable. A second row with the same `code`
    /// answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAttributeGroupsCreate(
        code: String,
        labels: Any? = nil,
        position: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/attribute_groups"

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "position": position
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
    /// Deletes one attribute group by id. It is a hard delete — the row is gone,
    /// and the answer is a confirmation rather than a result to branch on.
    /// 
    /// `attributes.group_id` is set to null instead, so the rows that pointed at
    /// it survive the delete rather than going with it.
    /// 
    /// An id no attribute group of this tenant carries answers 404; there is no
    /// 409, because every foreign key pointing at this entity resolves itself on
    /// delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAttributeGroupsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/attribute_groups/{id}"
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
    /// Reads one attribute group by its id — the whole row, every column, as it
    /// is stored.
    /// 
    /// An attribute group is a SECTION of a product form — "Technical
    /// attributes", "Logistics" — and the thing every attribute is filed under.
    /// It carries a `position`, which is the order the sections appear in, and
    /// per-language `labels`, which is what an operator reads; the `code` is what
    /// an attribute joins on and is never shown. `GET /products/attribute-schema`
    /// already resolves a group's heading onto every field it returns, so these
    /// routes are for MANAGING the sections, not for rendering a form.
    /// 
    /// An id no attribute group of this tenant carries answers 404, and so does
    /// one belonging to another tenant: row-level security makes that row
    /// invisible rather than forbidden. A malformed id answers 400 before the
    /// route is reached.
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
    open func productsAttributeGroupsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/attribute_groups/{id}"
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
    /// Updates one attribute group by id. A partial patch: the body names only the
    /// columns to change and every column it leaves out keeps its current value,
    /// so there is no read-modify-write and no way to blank a field by forgetting
    /// it.
    /// 
    /// An attribute group is a SECTION of a product form — "Technical
    /// attributes", "Logistics" — and the thing every attribute is filed under.
    /// It carries a `position`, which is the order the sections appear in, and
    /// per-language `labels`, which is what an operator reads; the `code` is what
    /// an attribute joins on and is never shown. `GET /products/attribute-schema`
    /// already resolves a group's heading onto every field it returns, so these
    /// routes are for MANAGING the sections, not for rendering a form.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAttributeGroupsUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        position: Int? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// The permitted values of one select or multi-select attribute. A record
    /// stores the option's CODE and never its label, so renaming an option in
    /// every language leaves every product that picked it untouched, and
    /// `position` is the order it appears in the dropdown. `GET
    /// /products/attribute-schema` republishes these as a field's `options`,
    /// already resolved for a locale.
    /// 
    /// Every column of `attribute_options` is an exact-match query parameter,
    /// `order` sorts by one column, and `limit`/`offset` page through
    /// `page.total`. A query key that is NOT a column is dropped rather than
    /// refused, and the `filter` object echoes the ones that were understood —
    /// that echo is the only way to tell an unfiltered answer from an empty one.
    /// It reads rows exactly as they are stored: no join is resolved, no jsonb
    /// value is unpacked.
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
    ///   - attributeId: String (optional)
    ///   - code: String (optional)
    ///   - position: Int (optional)
    ///   - swatch: String (optional)
    ///   - labels: String (optional)
    ///   - createdAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsAttributeOptionsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        attributeId: String? = nil,
        code: String? = nil,
        position: Int? = nil,
        swatch: String? = nil,
        labels: String? = nil,
        createdAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attribute_options"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "attribute_id": attributeId,
            "code": code,
            "position": position,
            "swatch": swatch,
            "labels": labels,
            "created_at": createdAt
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Creates one attribute option and answers 201 with the stored row, including
    /// the id and the timestamps the database filled in — a client never sends
    /// an id, it reads one back and uses it in the path of every later call.
    /// 
    /// The permitted values of one select or multi-select attribute. A record
    /// stores the option's CODE and never its label, so renaming an option in
    /// every language leaves every product that picked it untouched, and
    /// `position` is the order it appears in the dropdown. `GET
    /// /products/attribute-schema` republishes these as a field's `options`,
    /// already resolved for a locale.
    /// 
    /// `attribute_id` and `code` are the only columns the database refuses the row
    /// without; everything else has a default or is nullable. A second row with
    /// the same `attribute_id` and `code` answers 409.
    ///
    /// - Parameters:
    ///   - attributeId: String
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - swatch: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAttributeOptionsCreate(
        attributeId: String,
        code: String,
        labels: Any? = nil,
        position: Int? = nil,
        swatch: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one attribute option by id. It is a hard delete — the row is
    /// gone, and the answer is a confirmation rather than a result to branch on.
    /// 
    /// Nothing in this schema references it, so nothing else changes.
    /// 
    /// An id no attribute option of this tenant carries answers 404; there is no
    /// 409, because every foreign key pointing at this entity resolves itself on
    /// delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAttributeOptionsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/attribute_options/{id}"
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
    /// Reads one attribute option by its id — the whole row, every column, as it
    /// is stored.
    /// 
    /// The permitted values of one select or multi-select attribute. A record
    /// stores the option's CODE and never its label, so renaming an option in
    /// every language leaves every product that picked it untouched, and
    /// `position` is the order it appears in the dropdown. `GET
    /// /products/attribute-schema` republishes these as a field's `options`,
    /// already resolved for a locale.
    /// 
    /// An id no attribute option of this tenant carries answers 404, and so does
    /// one belonging to another tenant: row-level security makes that row
    /// invisible rather than forbidden. A malformed id answers 400 before the
    /// route is reached.
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
    open func productsAttributeOptionsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/attribute_options/{id}"
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
    /// Updates one attribute option by id. A partial patch: the body names only
    /// the columns to change and every column it leaves out keeps its current
    /// value, so there is no read-modify-write and no way to blank a field by
    /// forgetting it.
    /// 
    /// The permitted values of one select or multi-select attribute. A record
    /// stores the option's CODE and never its label, so renaming an option in
    /// every language leaves every product that picked it untouched, and
    /// `position` is the order it appears in the dropdown. `GET
    /// /products/attribute-schema` republishes these as a field's `options`,
    /// already resolved for a locale.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `attribute_id` and `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - attributeId: String (optional)
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - swatch: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAttributeOptionsUpdate(
        id: String,
        attributeId: String? = nil,
        code: String? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        swatch: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// An attribute is one property a record can carry, and in an attribute-driven
    /// PIM it is a ROW rather than a column: giving the catalog a "net weight" is
    /// a create here, not a migration. Its own flags decide everything downstream
    /// — `localizable` and `scopable` pick which of the four `attribute_values`
    /// buckets its values are written to, `type` picks the editor that renders it,
    /// `usable_in_grid` and `is_filterable` are what the product grid reads.
    /// `entity_type`/`entity_ref` say which kind of record carries it: a product,
    /// one reference entity's records, one asset family, or a category.
    /// 
    /// Every column of `attributes` is an exact-match query parameter, `order`
    /// sorts by one column, and `limit`/`offset` page through `page.total`. A
    /// query key that is NOT a column is dropped rather than refused, and the
    /// `filter` object echoes the ones that were understood — that echo is the
    /// only way to tell an unfiltered answer from an empty one. It reads rows
    /// exactly as they are stored: no join is resolved, no jsonb value is
    /// unpacked.
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
    ///   - code: String (optional)
    ///   - entityType: String (optional)
    ///   - entityRef: String (optional)
    ///   - type: String (optional)
    ///   - groupId: String (optional)
    ///   - localizable: Bool (optional)
    ///   - scopable: Bool (optional)
    ///   - isUnique: Bool (optional)
    ///   - isFilterable: Bool (optional)
    ///   - usableInGrid: Bool (optional)
    ///   - validation: String (optional)
    ///   - config: String (optional)
    ///   - labels: String (optional)
    ///   - position: Int (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsAttributesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        code: String? = nil,
        entityType: String? = nil,
        entityRef: String? = nil,
        type: String? = nil,
        groupId: String? = nil,
        localizable: Bool? = nil,
        scopable: Bool? = nil,
        isUnique: Bool? = nil,
        isFilterable: Bool? = nil,
        usableInGrid: Bool? = nil,
        validation: String? = nil,
        config: String? = nil,
        labels: String? = nil,
        position: Int? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/attributes"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "code": code,
            "entity_type": entityType,
            "entity_ref": entityRef,
            "type": type,
            "group_id": groupId,
            "localizable": localizable,
            "scopable": scopable,
            "is_unique": isUnique,
            "is_filterable": isFilterable,
            "usable_in_grid": usableInGrid,
            "validation": validation,
            "config": config,
            "labels": labels,
            "position": position,
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
    /// Creates one attribute and answers 201 with the stored row, including the id
    /// and the timestamps the database filled in — a client never sends an id,
    /// it reads one back and uses it in the path of every later call.
    /// 
    /// An attribute is one property a record can carry, and in an attribute-driven
    /// PIM it is a ROW rather than a column: giving the catalog a "net weight" is
    /// a create here, not a migration. Its own flags decide everything downstream
    /// — `localizable` and `scopable` pick which of the four `attribute_values`
    /// buckets its values are written to, `type` picks the editor that renders it,
    /// `usable_in_grid` and `is_filterable` are what the product grid reads.
    /// `entity_type`/`entity_ref` say which kind of record carries it: a product,
    /// one reference entity's records, one asset family, or a category.
    /// 
    /// `code` and `type` are the only columns the database refuses the row
    /// without; everything else has a default or is nullable. A second row with
    /// the same `entity_type`, `entity_ref`, `code` answers 409.
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
    /// - Returns: RevenexxModels.Error
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
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one attribute by id. It is a hard delete — the row is gone, and
    /// the answer is a confirmation rather than a result to branch on.
    /// 
    /// It takes what hangs off it: attribute options (`attribute_id`), family
    /// attributes (`attribute_id`) are deleted with it.
    /// 
    /// An id no attribute of this tenant carries answers 404; there is no 409,
    /// because every foreign key pointing at this entity resolves itself on delete
    /// rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsAttributesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/attributes/{id}"
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
    /// Reads one attribute by its id — the whole row, every column, as it is
    /// stored.
    /// 
    /// An attribute is one property a record can carry, and in an attribute-driven
    /// PIM it is a ROW rather than a column: giving the catalog a "net weight" is
    /// a create here, not a migration. Its own flags decide everything downstream
    /// — `localizable` and `scopable` pick which of the four `attribute_values`
    /// buckets its values are written to, `type` picks the editor that renders it,
    /// `usable_in_grid` and `is_filterable` are what the product grid reads.
    /// `entity_type`/`entity_ref` say which kind of record carries it: a product,
    /// one reference entity's records, one asset family, or a category.
    /// 
    /// An id no attribute of this tenant carries answers 404, and so does one
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
    open func productsAttributesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/attributes/{id}"
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
    /// Updates one attribute by id. A partial patch: the body names only the
    /// columns to change and every column it leaves out keeps its current value,
    /// so there is no read-modify-write and no way to blank a field by forgetting
    /// it.
    /// 
    /// An attribute is one property a record can carry, and in an attribute-driven
    /// PIM it is a ROW rather than a column: giving the catalog a "net weight" is
    /// a create here, not a migration. Its own flags decide everything downstream
    /// — `localizable` and `scopable` pick which of the four `attribute_values`
    /// buckets its values are written to, `type` picks the editor that renders it,
    /// `usable_in_grid` and `is_filterable` are what the product grid reads.
    /// `entity_type`/`entity_ref` say which kind of record carries it: a product,
    /// one reference entity's records, one asset family, or a category.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `entity_type`, `entity_ref`, `code` answers 409.
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
    /// - Returns: RevenexxModels.Error
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
    ) async throws -> RevenexxModels.Error {
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
    /// A family decides WHICH attributes a product has — the set is
    /// `family_attributes`, and every family-driven surface follows from it. It
    /// also names which attribute carries the display name (`label_attribute`) and
    /// which carries the main image. A product with no family has no required
    /// attributes at all, so its completeness cannot be measured and its name
    /// never resolves past the SKU; `POST /products/{id}/family` is the call that
    /// ends that state.
    /// 
    /// Every column of `families` is an exact-match query parameter, `order` sorts
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
    ///   - code: String (optional)
    ///   - labelAttribute: String (optional)
    ///   - imageAttribute: String (optional)
    ///   - labels: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsFamiliesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        code: String? = nil,
        labelAttribute: String? = nil,
        imageAttribute: String? = nil,
        labels: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/families"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "code": code,
            "label_attribute": labelAttribute,
            "image_attribute": imageAttribute,
            "labels": labels,
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
    /// Creates one family and answers 201 with the stored row, including the id
    /// and the timestamps the database filled in — a client never sends an id,
    /// it reads one back and uses it in the path of every later call.
    /// 
    /// A family decides WHICH attributes a product has — the set is
    /// `family_attributes`, and every family-driven surface follows from it. It
    /// also names which attribute carries the display name (`label_attribute`) and
    /// which carries the main image. A product with no family has no required
    /// attributes at all, so its completeness cannot be measured and its name
    /// never resolves past the SKU; `POST /products/{id}/family` is the call that
    /// ends that state.
    /// 
    /// `code` is the only column the database refuses the row without; everything
    /// else has a default or is nullable. A second row with the same `code`
    /// answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - imageAttribute: String (optional)
    ///   - labelAttribute: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamiliesCreate(
        code: String,
        imageAttribute: String? = nil,
        labelAttribute: String? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one family by id. It is a hard delete — the row is gone, and the
    /// answer is a confirmation rather than a result to branch on.
    /// 
    /// It takes what hangs off it: family attributes (`family_id`), family
    /// variants (`family_id`) are deleted with it. `products.family_id` is set to
    /// null instead, so the rows that pointed at it survive the delete rather than
    /// going with it.
    /// 
    /// An id no family of this tenant carries answers 404; there is no 409,
    /// because every foreign key pointing at this entity resolves itself on delete
    /// rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamiliesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/families/{id}"
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
    /// Reads one family by its id — the whole row, every column, as it is
    /// stored.
    /// 
    /// A family decides WHICH attributes a product has — the set is
    /// `family_attributes`, and every family-driven surface follows from it. It
    /// also names which attribute carries the display name (`label_attribute`) and
    /// which carries the main image. A product with no family has no required
    /// attributes at all, so its completeness cannot be measured and its name
    /// never resolves past the SKU; `POST /products/{id}/family` is the call that
    /// ends that state.
    /// 
    /// An id no family of this tenant carries answers 404, and so does one
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
    open func productsFamiliesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/families/{id}"
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
    /// Updates one family by id. A partial patch: the body names only the columns
    /// to change and every column it leaves out keeps its current value, so there
    /// is no read-modify-write and no way to blank a field by forgetting it.
    /// 
    /// A family decides WHICH attributes a product has — the set is
    /// `family_attributes`, and every family-driven surface follows from it. It
    /// also names which attribute carries the display name (`label_attribute`) and
    /// which carries the main image. A product with no family has no required
    /// attributes at all, so its completeness cannot be measured and its name
    /// never resolves past the SKU; `POST /products/{id}/family` is the call that
    /// ends that state.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - imageAttribute: String (optional)
    ///   - labelAttribute: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamiliesUpdate(
        id: String,
        code: String? = nil,
        imageAttribute: String? = nil,
        labelAttribute: String? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// One link between a family and an attribute — the row that puts an
    /// attribute INTO a family's form. It carries the family's own ordering of
    /// that attribute, which overrides the attribute's default position, and
    /// `is_required`, which is the flag `POST /products/{id}/completeness`
    /// measures and nothing else reads. `required_channels` narrows "required" to
    /// named channels; null or empty means required EVERYWHERE, not nowhere.
    /// 
    /// Every column of `family_attributes` is an exact-match query parameter,
    /// `order` sorts by one column, and `limit`/`offset` page through
    /// `page.total`. A query key that is NOT a column is dropped rather than
    /// refused, and the `filter` object echoes the ones that were understood —
    /// that echo is the only way to tell an unfiltered answer from an empty one.
    /// It reads rows exactly as they are stored: no join is resolved, no jsonb
    /// value is unpacked.
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
    ///   - familyId: String (optional)
    ///   - attributeId: String (optional)
    ///   - position: Int (optional)
    ///   - isRequired: Bool (optional)
    ///   - requiredChannels: String (optional)
    ///   - createdAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsFamilyAttributesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        familyId: String? = nil,
        attributeId: String? = nil,
        position: Int? = nil,
        isRequired: Bool? = nil,
        requiredChannels: String? = nil,
        createdAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/family_attributes"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "family_id": familyId,
            "attribute_id": attributeId,
            "position": position,
            "is_required": isRequired,
            "required_channels": requiredChannels,
            "created_at": createdAt
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Creates one family attribute and answers 201 with the stored row, including
    /// the id and the timestamps the database filled in — a client never sends
    /// an id, it reads one back and uses it in the path of every later call.
    /// 
    /// One link between a family and an attribute — the row that puts an
    /// attribute INTO a family's form. It carries the family's own ordering of
    /// that attribute, which overrides the attribute's default position, and
    /// `is_required`, which is the flag `POST /products/{id}/completeness`
    /// measures and nothing else reads. `required_channels` narrows "required" to
    /// named channels; null or empty means required EVERYWHERE, not nowhere.
    /// 
    /// `family_id` and `attribute_id` are the only columns the database refuses
    /// the row without; everything else has a default or is nullable. A second row
    /// with the same `family_id` and `attribute_id` answers 409.
    ///
    /// - Parameters:
    ///   - attributeId: String
    ///   - familyId: String
    ///   - isRequired: Bool (optional)
    ///   - position: Int (optional)
    ///   - requiredChannels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamilyAttributesCreate(
        attributeId: String,
        familyId: String,
        isRequired: Bool? = nil,
        position: Int? = nil,
        requiredChannels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one family attribute by id. It is a hard delete — the row is
    /// gone, and the answer is a confirmation rather than a result to branch on.
    /// 
    /// Nothing in this schema references it, so nothing else changes.
    /// 
    /// An id no family attribute of this tenant carries answers 404; there is no
    /// 409, because every foreign key pointing at this entity resolves itself on
    /// delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamilyAttributesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/family_attributes/{id}"
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
    /// Reads one family attribute by its id — the whole row, every column, as it
    /// is stored.
    /// 
    /// One link between a family and an attribute — the row that puts an
    /// attribute INTO a family's form. It carries the family's own ordering of
    /// that attribute, which overrides the attribute's default position, and
    /// `is_required`, which is the flag `POST /products/{id}/completeness`
    /// measures and nothing else reads. `required_channels` narrows "required" to
    /// named channels; null or empty means required EVERYWHERE, not nowhere.
    /// 
    /// An id no family attribute of this tenant carries answers 404, and so does
    /// one belonging to another tenant: row-level security makes that row
    /// invisible rather than forbidden. A malformed id answers 400 before the
    /// route is reached.
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
    open func productsFamilyAttributesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/family_attributes/{id}"
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
    /// Updates one family attribute by id. A partial patch: the body names only
    /// the columns to change and every column it leaves out keeps its current
    /// value, so there is no read-modify-write and no way to blank a field by
    /// forgetting it.
    /// 
    /// One link between a family and an attribute — the row that puts an
    /// attribute INTO a family's form. It carries the family's own ordering of
    /// that attribute, which overrides the attribute's default position, and
    /// `is_required`, which is the flag `POST /products/{id}/completeness`
    /// measures and nothing else reads. `required_channels` narrows "required" to
    /// named channels; null or empty means required EVERYWHERE, not nowhere.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `family_id` and `attribute_id` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - attributeId: String (optional)
    ///   - familyId: String (optional)
    ///   - isRequired: Bool (optional)
    ///   - position: Int (optional)
    ///   - requiredChannels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamilyAttributesUpdate(
        id: String,
        attributeId: String? = nil,
        familyId: String? = nil,
        isRequired: Bool? = nil,
        position: Int? = nil,
        requiredChannels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// A variant structure of a family: the attribute axes a product model splits
    /// its variants on — colour, then size. A product follows one through
    /// `family_variant_id`, and an attribute named as an axis becomes read-only on
    /// the model and is set on each variant instead, which is what `GET
    /// /products/attribute-schema` reports as `readonly_reason`. Two axis shapes
    /// are in the wild and both are read: a bare list of codes, or one entry per
    /// level.
    /// 
    /// Every column of `family_variants` is an exact-match query parameter,
    /// `order` sorts by one column, and `limit`/`offset` page through
    /// `page.total`. A query key that is NOT a column is dropped rather than
    /// refused, and the `filter` object echoes the ones that were understood —
    /// that echo is the only way to tell an unfiltered answer from an empty one.
    /// It reads rows exactly as they are stored: no join is resolved, no jsonb
    /// value is unpacked.
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
    ///   - familyId: String (optional)
    ///   - code: String (optional)
    ///   - labels: String (optional)
    ///   - axes: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsFamilyVariantsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        familyId: String? = nil,
        code: String? = nil,
        labels: String? = nil,
        axes: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/family_variants"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "family_id": familyId,
            "code": code,
            "labels": labels,
            "axes": axes,
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
    /// Creates one family variant and answers 201 with the stored row, including
    /// the id and the timestamps the database filled in — a client never sends
    /// an id, it reads one back and uses it in the path of every later call.
    /// 
    /// A variant structure of a family: the attribute axes a product model splits
    /// its variants on — colour, then size. A product follows one through
    /// `family_variant_id`, and an attribute named as an axis becomes read-only on
    /// the model and is set on each variant instead, which is what `GET
    /// /products/attribute-schema` reports as `readonly_reason`. Two axis shapes
    /// are in the wild and both are read: a bare list of codes, or one entry per
    /// level.
    /// 
    /// `family_id` and `code` are the only columns the database refuses the row
    /// without; everything else has a default or is nullable. A second row with
    /// the same `code` answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - familyId: String
    ///   - axes: Any (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamilyVariantsCreate(
        code: String,
        familyId: String,
        axes: Any? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one family variant by id. It is a hard delete — the row is gone,
    /// and the answer is a confirmation rather than a result to branch on.
    /// 
    /// `products.family_variant_id` is set to null instead, so the rows that
    /// pointed at it survive the delete rather than going with it.
    /// 
    /// An id no family variant of this tenant carries answers 404; there is no
    /// 409, because every foreign key pointing at this entity resolves itself on
    /// delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamilyVariantsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/family_variants/{id}"
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
    /// Reads one family variant by its id — the whole row, every column, as it
    /// is stored.
    /// 
    /// A variant structure of a family: the attribute axes a product model splits
    /// its variants on — colour, then size. A product follows one through
    /// `family_variant_id`, and an attribute named as an axis becomes read-only on
    /// the model and is set on each variant instead, which is what `GET
    /// /products/attribute-schema` reports as `readonly_reason`. Two axis shapes
    /// are in the wild and both are read: a bare list of codes, or one entry per
    /// level.
    /// 
    /// An id no family variant of this tenant carries answers 404, and so does one
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
    open func productsFamilyVariantsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/family_variants/{id}"
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
    /// Updates one family variant by id. A partial patch: the body names only the
    /// columns to change and every column it leaves out keeps its current value,
    /// so there is no read-modify-write and no way to blank a field by forgetting
    /// it.
    /// 
    /// A variant structure of a family: the attribute axes a product model splits
    /// its variants on — colour, then size. A product follows one through
    /// `family_variant_id`, and an attribute named as an axis becomes read-only on
    /// the model and is set on each variant instead, which is what `GET
    /// /products/attribute-schema` reports as `readonly_reason`. Two axis shapes
    /// are in the wild and both are read: a bare list of codes, or one entry per
    /// level.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - axes: Any (optional)
    ///   - code: String (optional)
    ///   - familyId: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamilyVariantsUpdate(
        id: String,
        axes: Any? = nil,
        code: String? = nil,
        familyId: String? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// A family of units and the standard one they all convert to — weight in
    /// kilograms, length in metres. A `measure` attribute names one and then
    /// offers exactly that family's units, and each unit's `convert_factor` is
    /// what makes two values recorded in different units comparable at all.
    /// 
    /// Every column of `measurement_families` is an exact-match query parameter,
    /// `order` sorts by one column, and `limit`/`offset` page through
    /// `page.total`. A query key that is NOT a column is dropped rather than
    /// refused, and the `filter` object echoes the ones that were understood —
    /// that echo is the only way to tell an unfiltered answer from an empty one.
    /// It reads rows exactly as they are stored: no join is resolved, no jsonb
    /// value is unpacked.
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
    ///   - code: String (optional)
    ///   - standardUnit: String (optional)
    ///   - units: String (optional)
    ///   - labels: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsMeasurementFamiliesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        code: String? = nil,
        standardUnit: String? = nil,
        units: String? = nil,
        labels: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/measurement_families"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "code": code,
            "standard_unit": standardUnit,
            "units": units,
            "labels": labels,
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
    /// Creates one measurement family and answers 201 with the stored row,
    /// including the id and the timestamps the database filled in — a client
    /// never sends an id, it reads one back and uses it in the path of every later
    /// call.
    /// 
    /// A family of units and the standard one they all convert to — weight in
    /// kilograms, length in metres. A `measure` attribute names one and then
    /// offers exactly that family's units, and each unit's `convert_factor` is
    /// what makes two values recorded in different units comparable at all.
    /// 
    /// `code` and `standard_unit` are the only columns the database refuses the
    /// row without; everything else has a default or is nullable. A second row
    /// with the same `code` answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - standardUnit: String
    ///   - labels: Any (optional)
    ///   - units: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsMeasurementFamiliesCreate(
        code: String,
        standardUnit: String,
        labels: Any? = nil,
        units: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one measurement family by id. It is a hard delete — the row is
    /// gone, and the answer is a confirmation rather than a result to branch on.
    /// 
    /// Nothing in this schema references it, so nothing else changes.
    /// 
    /// An id no measurement family of this tenant carries answers 404; there is no
    /// 409, because every foreign key pointing at this entity resolves itself on
    /// delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsMeasurementFamiliesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/measurement_families/{id}"
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
    /// Reads one measurement family by its id — the whole row, every column, as
    /// it is stored.
    /// 
    /// A family of units and the standard one they all convert to — weight in
    /// kilograms, length in metres. A `measure` attribute names one and then
    /// offers exactly that family's units, and each unit's `convert_factor` is
    /// what makes two values recorded in different units comparable at all.
    /// 
    /// An id no measurement family of this tenant carries answers 404, and so does
    /// one belonging to another tenant: row-level security makes that row
    /// invisible rather than forbidden. A malformed id answers 400 before the
    /// route is reached.
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
    open func productsMeasurementFamiliesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/measurement_families/{id}"
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
    /// Updates one measurement family by id. A partial patch: the body names only
    /// the columns to change and every column it leaves out keeps its current
    /// value, so there is no read-modify-write and no way to blank a field by
    /// forgetting it.
    /// 
    /// A family of units and the standard one they all convert to — weight in
    /// kilograms, length in metres. A `measure` attribute names one and then
    /// offers exactly that family's units, and each unit's `convert_factor` is
    /// what makes two values recorded in different units comparable at all.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - standardUnit: String (optional)
    ///   - units: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsMeasurementFamiliesUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        standardUnit: String? = nil,
        units: Any? = nil
    ) async throws -> RevenexxModels.Error {
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