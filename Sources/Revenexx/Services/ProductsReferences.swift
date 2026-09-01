import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Reference entities and their records — the domains this catalog POINTS AT instead of duplicating. A brand, a manufacturer, a care instruction is one record here, edited once, and every product that uses it stores only its code. A reference entity carries attributes of its own, so its records hold real data rather than just a name; that shape is declared in Data model and read back with the attribute-schema call there.
open class ProductsReferences: Service {

    ///
    /// A domain of records the catalog POINTS AT instead of duplicating —
    /// brands, manufacturers, care instructions. Declaring one is how a brand
    /// comes to be edited in one place rather than on nine thousand products. A
    /// reference entity has attributes of its own (`attributes` rows with
    /// `entity_type: "reference_entity"` and this entity's code as `entity_ref`),
    /// which is what makes its records more than a label.
    /// 
    /// Every column of `reference_entities` is an exact-match query parameter,
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
    ///   - labels: String (optional)
    ///   - image: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsReferenceEntitiesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        code: String? = nil,
        labels: String? = nil,
        image: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/reference_entities"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "code": code,
            "labels": labels,
            "image": image,
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
    /// Creates one reference entity and answers 201 with the stored row, including
    /// the id and the timestamps the database filled in — a client never sends
    /// an id, it reads one back and uses it in the path of every later call.
    /// 
    /// A domain of records the catalog POINTS AT instead of duplicating —
    /// brands, manufacturers, care instructions. Declaring one is how a brand
    /// comes to be edited in one place rather than on nine thousand products. A
    /// reference entity has attributes of its own (`attributes` rows with
    /// `entity_type: "reference_entity"` and this entity's code as `entity_ref`),
    /// which is what makes its records more than a label.
    /// 
    /// `code` is the only column the database refuses the row without; everything
    /// else has a default or is nullable. A second row with the same `code`
    /// answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - image: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsReferenceEntitiesCreate(
        code: String,
        image: String? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/reference_entities"

        let apiParams: [String: Any?] = [
            "code": code,
            "image": image,
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
    /// Deletes one reference entity by id. It is a hard delete — the row is
    /// gone, and the answer is a confirmation rather than a result to branch on.
    /// 
    /// It takes what hangs off it: reference entity records
    /// (`reference_entity_id`) are deleted with it.
    /// 
    /// An id no reference entity of this tenant carries answers 404; there is no
    /// 409, because every foreign key pointing at this entity resolves itself on
    /// delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsReferenceEntitiesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/reference_entities/{id}"
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
    /// Reads one reference entity by its id — the whole row, every column, as it
    /// is stored.
    /// 
    /// A domain of records the catalog POINTS AT instead of duplicating —
    /// brands, manufacturers, care instructions. Declaring one is how a brand
    /// comes to be edited in one place rather than on nine thousand products. A
    /// reference entity has attributes of its own (`attributes` rows with
    /// `entity_type: "reference_entity"` and this entity's code as `entity_ref`),
    /// which is what makes its records more than a label.
    /// 
    /// An id no reference entity of this tenant carries answers 404, and so does
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
    open func productsReferenceEntitiesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/reference_entities/{id}"
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
    /// Updates one reference entity by id. A partial patch: the body names only
    /// the columns to change and every column it leaves out keeps its current
    /// value, so there is no read-modify-write and no way to blank a field by
    /// forgetting it.
    /// 
    /// A domain of records the catalog POINTS AT instead of duplicating —
    /// brands, manufacturers, care instructions. Declaring one is how a brand
    /// comes to be edited in one place rather than on nine thousand products. A
    /// reference entity has attributes of its own (`attributes` rows with
    /// `entity_type: "reference_entity"` and this entity's code as `entity_ref`),
    /// which is what makes its records more than a label.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - image: String (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsReferenceEntitiesUpdate(
        id: String,
        code: String? = nil,
        image: String? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// One record of a reference entity — one brand, one manufacturer. A product
    /// that points at it stores this record's CODE, exactly the way a select
    /// stores an option code, and the record's own properties live in its scoped
    /// `attribute_values` document. `GET /products/attribute-schema` offers these
    /// records as the `options` of any attribute that points at their entity, so a
    /// picker needs no second call.
    /// 
    /// Every column of `reference_entity_records` is an exact-match query
    /// parameter, `order` sorts by one column, and `limit`/`offset` page through
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
    ///   - referenceEntityId: String (optional)
    ///   - code: String (optional)
    ///   - labels: String (optional)
    ///   - attributeValues: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsReferenceEntityRecordsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        referenceEntityId: String? = nil,
        code: String? = nil,
        labels: String? = nil,
        attributeValues: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/reference_entity_records"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "reference_entity_id": referenceEntityId,
            "code": code,
            "labels": labels,
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
    /// Creates one reference entity record and answers 201 with the stored row,
    /// including the id and the timestamps the database filled in — a client
    /// never sends an id, it reads one back and uses it in the path of every later
    /// call.
    /// 
    /// One record of a reference entity — one brand, one manufacturer. A product
    /// that points at it stores this record's CODE, exactly the way a select
    /// stores an option code, and the record's own properties live in its scoped
    /// `attribute_values` document. `GET /products/attribute-schema` offers these
    /// records as the `options` of any attribute that points at their entity, so a
    /// picker needs no second call.
    /// 
    /// `reference_entity_id` and `code` are the only columns the database refuses
    /// the row without; everything else has a default or is nullable. A second row
    /// with the same `reference_entity_id` and `code` answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - referenceEntityId: String
    ///   - attributeValues: Any (optional)
    ///   - labels: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsReferenceEntityRecordsCreate(
        code: String,
        referenceEntityId: String,
        attributeValues: Any? = nil,
        labels: Any? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one reference entity record by id. It is a hard delete — the row
    /// is gone, and the answer is a confirmation rather than a result to branch
    /// on.
    /// 
    /// Nothing in this schema references it, so nothing else changes.
    /// 
    /// An id no reference entity record of this tenant carries answers 404; there
    /// is no 409, because every foreign key pointing at this entity resolves
    /// itself on delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsReferenceEntityRecordsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/reference_entity_records/{id}"
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
    /// Reads one reference entity record by its id — the whole row, every
    /// column, as it is stored.
    /// 
    /// One record of a reference entity — one brand, one manufacturer. A product
    /// that points at it stores this record's CODE, exactly the way a select
    /// stores an option code, and the record's own properties live in its scoped
    /// `attribute_values` document. `GET /products/attribute-schema` offers these
    /// records as the `options` of any attribute that points at their entity, so a
    /// picker needs no second call.
    /// 
    /// An id no reference entity record of this tenant carries answers 404, and so
    /// does one belonging to another tenant: row-level security makes that row
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
    open func productsReferenceEntityRecordsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/reference_entity_records/{id}"
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
    /// Updates one reference entity record by id. A partial patch: the body names
    /// only the columns to change and every column it leaves out keeps its current
    /// value, so there is no read-modify-write and no way to blank a field by
    /// forgetting it.
    /// 
    /// One record of a reference entity — one brand, one manufacturer. A product
    /// that points at it stores this record's CODE, exactly the way a select
    /// stores an option code, and the record's own properties live in its scoped
    /// `attribute_values` document. `GET /products/attribute-schema` offers these
    /// records as the `options` of any attribute that points at their entity, so a
    /// picker needs no second call.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `reference_entity_id` and `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - attributeValues: Any (optional)
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - referenceEntityId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsReferenceEntityRecordsUpdate(
        id: String,
        attributeValues: Any? = nil,
        code: String? = nil,
        labels: Any? = nil,
        referenceEntityId: String? = nil
    ) async throws -> RevenexxModels.Error {
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