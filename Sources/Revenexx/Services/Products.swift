import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The catalog itself — the product rows a merchant works on, and everything keyed by a product: the grid a person scans, the display name a product resolves to (which is an attribute, not a column), the completeness measured against its family, and the associations that point one product at another. Start here for anything about A PRODUCT; the shape a product has is in Data model, and the categories it is filed into are in Categories.
open class Products: Service {

    ///
    /// The catalog itself. A product row carries only what every product has —
    /// SKU, kind, family, enabled, tax class — and everything the tenant
    /// modelled lives in the `attribute_values` jsonb document, keyed by attribute
    /// CODE inside one of four scope buckets (common, per locale, per channel, per
    /// channel and locale). `label` is a generated column, maintained by the
    /// database so a grid of twenty thousand rows can sort and filter on a name
    /// with no join. `kind` says where the row sits in the variant hierarchy: a
    /// `model` carries what its variants share and is never sold itself.
    /// 
    /// Every column of `products` is an exact-match query parameter, `order` sorts
    /// by one column, and `limit`/`offset` page through `page.total`. A query key
    /// that is NOT a column is dropped rather than refused, and the `filter`
    /// object echoes the ones that were understood — that echo is the only way
    /// to tell an unfiltered answer from an empty one. It reads rows exactly as
    /// they are stored: no join is resolved, no jsonb value is unpacked, and
    /// soft-deleted products are included — filter on `deleted_at` to read the
    /// live catalog, or use `GET /products/grid`, which excludes them.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - id: String (optional)
    ///   - sku: String (optional)
    ///   - kind: RevenexxEnums.Kind (optional)
    ///   - parentId: String (optional)
    ///   - familyId: String (optional)
    ///   - familyVariantId: String (optional)
    ///   - enabled: Bool (optional)
    ///   - taxClass: String (optional)
    ///   - attributeValues: String (optional)
    ///   - label: String (optional)
    ///   - quantifiedAssociations: String (optional)
    ///   - completeness: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - deletedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        sku: String? = nil,
        kind: RevenexxEnums.Kind? = nil,
        parentId: String? = nil,
        familyId: String? = nil,
        familyVariantId: String? = nil,
        enabled: Bool? = nil,
        taxClass: String? = nil,
        attributeValues: String? = nil,
        label: String? = nil,
        quantifiedAssociations: String? = nil,
        completeness: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        deletedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "sku": sku,
            "kind": kind,
            "parent_id": parentId,
            "family_id": familyId,
            "family_variant_id": familyVariantId,
            "enabled": enabled,
            "tax_class": taxClass,
            "attribute_values": attributeValues,
            "label": label,
            "quantified_associations": quantifiedAssociations,
            "completeness": completeness,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "deleted_at": deletedAt
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Creates one product and answers 201 with the stored row, including the id
    /// and the timestamps the database filled in — a client never sends an id,
    /// it reads one back and uses it in the path of every later call.
    /// 
    /// The catalog itself. A product row carries only what every product has —
    /// SKU, kind, family, enabled, tax class — and everything the tenant
    /// modelled lives in the `attribute_values` jsonb document, keyed by attribute
    /// CODE inside one of four scope buckets (common, per locale, per channel, per
    /// channel and locale). `label` is a generated column, maintained by the
    /// database so a grid of twenty thousand rows can sort and filter on a name
    /// with no join. `kind` says where the row sits in the variant hierarchy: a
    /// `model` carries what its variants share and is never sold itself.
    /// 
    /// `sku` is the only column the database refuses the row without; everything
    /// else has a default or is nullable. A second row with the same `sku` answers
    /// 409. This app owns the create: `enabled` defaults from the
    /// `new_products_enabled_by_default` tenant setting rather than blindly to
    /// true, so an import cannot publish twenty thousand unfinished products the
    /// moment it lands, and a product that names no family gets the
    /// `default_product_family` one. An explicit value in the body always wins
    /// over both.
    ///
    /// - Parameters:
    ///   - sku: String
    ///   - attributeValues: Any (optional)
    ///   - completeness: Any (optional)
    ///   - deletedAt: String (optional)
    ///   - enabled: Bool (optional)
    ///   - familyId: String (optional)
    ///   - familyVariantId: String (optional)
    ///   - kind: RevenexxEnums.ProductsKind (optional)
    ///   - parentId: String (optional)
    ///   - quantifiedAssociations: Any (optional)
    ///   - taxClass: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCreate(
        sku: String,
        attributeValues: Any? = nil,
        completeness: Any? = nil,
        deletedAt: String? = nil,
        enabled: Bool? = nil,
        familyId: String? = nil,
        familyVariantId: String? = nil,
        kind: RevenexxEnums.ProductsKind? = nil,
        parentId: String? = nil,
        quantifiedAssociations: Any? = nil,
        taxClass: String? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Answers four fields — id, sku, tax_class and the resolved display name
    /// — for a list of ids and/or SKUs in ONE call. It exists for the app on the
    /// other side of a product reference: the prices app holds SKUs and needs a
    /// tax class, a feed builder holds ids and needs names, and neither should
    /// page through the catalog or fire a request per line. Ask by either
    /// identifier or both; the two are unioned and a product named twice comes
    /// back once.
    /// 
    /// It answers what it FOUND: an id or SKU that names nothing is simply absent
    /// from `items` rather than an error, so compare the length of what you sent
    /// with what came back if a miss matters. It is not a general product read —
    /// for the whole row use `GET /products/{id}`, and for a scannable list use
    /// `GET /products/grid`.
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
    /// The list a merchant can actually scan, as opposed to `GET /products`, which
    /// answers SKUs and a jsonb blob. Every row arrives already flattened: its
    /// resolved display name and where that name came from, its family code, its
    /// stored completeness, and the value of every attribute the catalog marks
    /// `usable_in_grid` — no join, no second call. `q` is a case-insensitive
    /// substring of the stored `label` column, which falls back to the SKU, so one
    /// box finds a product by either. Soft-deleted products are excluded here,
    /// unlike `GET /products`.
    /// 
    /// It filters on `q`, `kind`, `enabled` and `family_id`, and on NOTHING ELSE
    /// — a query parameter it does not accept is refused with 400 rather than
    /// dropped. That matters because of `filters`: the array reports the
    /// attributes marked `is_filterable`, which is what a filter bar should OFFER,
    /// and it is not a query surface. Filtering on an attribute value is not
    /// offered by this API at all — the values live inside a four-bucket jsonb
    /// document and are read through a fallback chain, so it is a feature with a
    /// design of its own rather than a parameter that was forgotten.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - q: String (optional)
    ///   - kind: RevenexxEnums.Kind (optional)
    ///   - enabled: Bool (optional)
    ///   - familyId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsGrid(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        q: String? = nil,
        kind: RevenexxEnums.Kind? = nil,
        enabled: Bool? = nil,
        familyId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/grid"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "q": q,
            "kind": kind,
            "enabled": enabled,
            "family_id": familyId
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
    /// What is this product CALLED? A product's name is an attribute rather than a
    /// column, and which attribute it is, is per family — so no plain read can
    /// answer it. This resolves up to 500 products at once, by id and/or SKU: it
    /// reads families.label_attribute (falling back to the default_label_attribute
    /// setting, then to the conventional `name`) and looks the value up through
    /// the scoped attribute_values document — common, then locale_specific in
    /// the label_locales order, then the channel buckets.
    /// 
    /// It reports WHERE the name was found, which is the half that matters:
    /// `source: "sku"` means the catalog holds no name for this product and the
    /// SKU is standing in for one, so show it as a missing name rather than as a
    /// name. Writes nothing, and answers only what it found.
    ///
    /// - Parameters:
    ///   - ids: [String] (optional)
    ///   - skus: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsLabels(
        ids: [String]? = nil,
        skus: [String]? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/labels"

        let apiParams: [String: Any?] = [
            "ids": ids,
            "skus": skus
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
    /// One relation from one product to another, of a declared type: this drill's
    /// accessories, this bundle's parts, this article's cross-sells. `quantity` is
    /// the number in "this bundle contains 4 casters" and is meaningful only when
    /// the association type carries `is_quantified`. This relational surface is
    /// the one this app serves; the `products.quantified_associations` column is
    /// an importer's blob that no route here reads or writes.
    /// 
    /// Every column of `product_associations` is an exact-match query parameter,
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
    ///   - productId: String (optional)
    ///   - associationTypeId: String (optional)
    ///   - targetProductId: String (optional)
    ///   - quantity: Double (optional)
    ///   - position: Int (optional)
    ///   - createdAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsProductAssociationsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        productId: String? = nil,
        associationTypeId: String? = nil,
        targetProductId: String? = nil,
        quantity: Double? = nil,
        position: Int? = nil,
        createdAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/product_associations"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "product_id": productId,
            "association_type_id": associationTypeId,
            "target_product_id": targetProductId,
            "quantity": quantity,
            "position": position,
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
    /// Creates one product association and answers 201 with the stored row,
    /// including the id and the timestamps the database filled in — a client
    /// never sends an id, it reads one back and uses it in the path of every later
    /// call.
    /// 
    /// One relation from one product to another, of a declared type: this drill's
    /// accessories, this bundle's parts, this article's cross-sells. `quantity` is
    /// the number in "this bundle contains 4 casters" and is meaningful only when
    /// the association type carries `is_quantified`. This relational surface is
    /// the one this app serves; the `products.quantified_associations` column is
    /// an importer's blob that no route here reads or writes.
    /// 
    /// `product_id`, `association_type_id`, `target_product_id` are the only
    /// columns the database refuses the row without; everything else has a default
    /// or is nullable. A second row with the same `product_id`,
    /// `association_type_id`, `target_product_id` answers 409.
    ///
    /// - Parameters:
    ///   - associationTypeId: String
    ///   - productId: String
    ///   - targetProductId: String
    ///   - position: Int (optional)
    ///   - quantity: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsProductAssociationsCreate(
        associationTypeId: String,
        productId: String,
        targetProductId: String,
        position: Int? = nil,
        quantity: Double? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// Deletes one product association by id. It is a hard delete — the row is
    /// gone, and the answer is a confirmation rather than a result to branch on.
    /// 
    /// Nothing in this schema references it, so nothing else changes.
    /// 
    /// An id no product association of this tenant carries answers 404; there is
    /// no 409, because every foreign key pointing at this entity resolves itself
    /// on delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsProductAssociationsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/product_associations/{id}"
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
    /// Reads one product association by its id — the whole row, every column, as
    /// it is stored.
    /// 
    /// One relation from one product to another, of a declared type: this drill's
    /// accessories, this bundle's parts, this article's cross-sells. `quantity` is
    /// the number in "this bundle contains 4 casters" and is meaningful only when
    /// the association type carries `is_quantified`. This relational surface is
    /// the one this app serves; the `products.quantified_associations` column is
    /// an importer's blob that no route here reads or writes.
    /// 
    /// An id no product association of this tenant carries answers 404, and so
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
    open func productsProductAssociationsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/product_associations/{id}"
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
    /// Updates one product association by id. A partial patch: the body names only
    /// the columns to change and every column it leaves out keeps its current
    /// value, so there is no read-modify-write and no way to blank a field by
    /// forgetting it.
    /// 
    /// One relation from one product to another, of a declared type: this drill's
    /// accessories, this bundle's parts, this article's cross-sells. `quantity` is
    /// the number in "this bundle contains 4 casters" and is meaningful only when
    /// the association type carries `is_quantified`. This relational surface is
    /// the one this app serves; the `products.quantified_associations` column is
    /// an importer's blob that no route here reads or writes.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `product_id`, `association_type_id`, `target_product_id` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - associationTypeId: String (optional)
    ///   - position: Int (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - targetProductId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsProductAssociationsUpdate(
        id: String,
        associationTypeId: String? = nil,
        position: Int? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        targetProductId: String? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// The index of the enums this app ENFORCES — `product-kinds`,
    /// `membership-sources`, `rule-matches`, `asset-sources` — served by the app
    /// that owns the CHECK constraint each one is parsed out of, so a UI never has
    /// to keep its own copy of a status map and watch it drift. Names and titles
    /// only: fetch one by name for its values, badge tones and descriptions.
    /// 
    /// The set is a fixed property of this app rather than tenant data, so it is
    /// the same list for every tenant. `attributes.type` is deliberately absent:
    /// it carries no CHECK, because the whole point of an attribute-driven PIM is
    /// that the type list is data an integrator extends.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsVocabulariesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/products/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// One vocabulary with every value it admits, each with a title, a description
    /// and the badge tone a UI should paint it in. The value set is parsed out of
    /// the CHECK constraint in schema.json, so what is served IS what is enforced.
    /// Labels are curated on top and can only add words and colour — a permitted
    /// value nobody labelled still appears, titled from its own key.
    ///
    /// - Parameters:
    ///   - name: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsVocabulariesGet(
        name: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/vocabularies/{name}"
            .replacingOccurrences(of: "{name}", with: name)

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
    /// Deletes one product by id. It is a hard delete — the row is gone, and the
    /// answer is a confirmation rather than a result to branch on.
    /// 
    /// It takes what hangs off it: product category memberships (`product_id`),
    /// product associations (`product_id` and `target_product_id`) are deleted
    /// with it. `products.parent_id` is set to null instead, so the rows that
    /// pointed at it survive the delete rather than going with it.
    /// 
    /// An id no product of this tenant carries answers 404; there is no 409,
    /// because every foreign key pointing at this entity resolves itself on delete
    /// rather than blocking one. `products.deleted_at` is a SOFT-delete marker
    /// that the grid and every category-rule evaluation honour, but no route in
    /// this app ever writes it — to soft-delete instead, `PUT /products/{id}`
    /// with a `deleted_at`.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/{id}"
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
    /// Reads one product by its id — the whole row, every column, as it is
    /// stored.
    /// 
    /// The catalog itself. A product row carries only what every product has —
    /// SKU, kind, family, enabled, tax class — and everything the tenant
    /// modelled lives in the `attribute_values` jsonb document, keyed by attribute
    /// CODE inside one of four scope buckets (common, per locale, per channel, per
    /// channel and locale). `label` is a generated column, maintained by the
    /// database so a grid of twenty thousand rows can sort and filter on a name
    /// with no join. `kind` says where the row sits in the variant hierarchy: a
    /// `model` carries what its variants share and is never sold itself.
    /// 
    /// An id no product of this tenant carries answers 404, and so does one
    /// belonging to another tenant: row-level security makes that row invisible
    /// rather than forbidden. A malformed id answers 400 before the route is
    /// reached. Nothing is resolved for you here — for the display name, the
    /// family code and the grid attributes already unpacked, use `GET
    /// /products/grid` or `POST /products/labels`.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/{id}"
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
    /// Updates one product by id. A partial patch: the body names only the columns
    /// to change and every column it leaves out keeps its current value, so there
    /// is no read-modify-write and no way to blank a field by forgetting it.
    /// 
    /// The catalog itself. A product row carries only what every product has —
    /// SKU, kind, family, enabled, tax class — and everything the tenant
    /// modelled lives in the `attribute_values` jsonb document, keyed by attribute
    /// CODE inside one of four scope buckets (common, per locale, per channel, per
    /// channel and locale). `label` is a generated column, maintained by the
    /// database so a grid of twenty thousand rows can sort and filter on a name
    /// with no join. `kind` says where the row sits in the variant hierarchy: a
    /// `model` carries what its variants share and is never sold itself.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `sku` answers 409. `label` is a generated column: naming it is dropped
    /// rather than refused, and `completeness` is written by the two metadata
    /// routes, not here.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - attributeValues: Any (optional)
    ///   - completeness: Any (optional)
    ///   - deletedAt: String (optional)
    ///   - enabled: Bool (optional)
    ///   - familyId: String (optional)
    ///   - familyVariantId: String (optional)
    ///   - kind: RevenexxEnums.ProductsKind (optional)
    ///   - parentId: String (optional)
    ///   - quantifiedAssociations: Any (optional)
    ///   - sku: String (optional)
    ///   - taxClass: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsUpdate(
        id: String,
        attributeValues: Any? = nil,
        completeness: Any? = nil,
        deletedAt: String? = nil,
        enabled: Bool? = nil,
        familyId: String? = nil,
        familyVariantId: String? = nil,
        kind: RevenexxEnums.ProductsKind? = nil,
        parentId: String? = nil,
        quantifiedAssociations: Any? = nil,
        sku: String? = nil,
        taxClass: String? = nil
    ) async throws -> RevenexxModels.Error {
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
    /// How much of what its family REQUIRES does this product actually carry —
    /// the number a merchandiser works down. products.completeness is jsonb that
    /// nothing had ever written. This computes it from family_attributes
    /// (is_required) against the product's own scoped attribute_values and stores
    /// the result. A product with no family answers 400 rather than an invented 0
    /// % — it has nothing to be measured against.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCompleteness(
        id: String,
        data: Any
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/{id}/completeness"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "data": data
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
    /// Names the family in the body — by `family_id` or by `family_code`,
    /// whichever the caller holds — and computes the product's completeness in
    /// the same call. The step every family-driven surface waits on: a product
    /// with no family has no required attributes, so its completeness cannot be
    /// computed and its family's label attribute never resolves. Assigning the
    /// family recomputes and STORES products.completeness immediately, so the
    /// metadata cannot go stale between the two operations.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - familyCode: String (optional)
    ///   - familyId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsFamilyAssign(
        id: String,
        familyCode: String? = nil,
        familyId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/{id}/family"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "family_code": familyCode,
            "family_id": familyId
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