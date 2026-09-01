import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The category tree and how products get into it. The nodes themselves, the memberships that file a product into a node — hand-picked or materialized by a rule — and the rule engine that maintains the second kind: preview a selector before storing it, recompute one category, or recompute every category that carries rules. Read this group when the question is "which products are in this category, and how did they get there".
open class ProductsCategories: Service {

    ///
    /// One node of the category tree. `parent_id` is the structure this app
    /// navigates — null is a root — while `path` is kept only for importers
    /// that carry one and nothing here reads or writes it. A category is
    /// hand-picked or RULE-DRIVEN: a non-null `rules` selector makes every
    /// matching product a `product_categories` row with source `rule`, alongside
    /// the hand-picked ones, and `rules_computed_at` says when that last
    /// completed.
    /// 
    /// Every column of `categories` is an exact-match query parameter, `order`
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
    ///   - parentId: String (optional)
    ///   - path: String (optional)
    ///   - position: Int (optional)
    ///   - labels: String (optional)
    ///   - values: String (optional)
    ///   - rules: String (optional)
    ///   - ruleMatch: RevenexxEnums.RuleMatch (optional)
    ///   - rulesComputedAt: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsCategoriesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        code: String? = nil,
        parentId: String? = nil,
        path: String? = nil,
        position: Int? = nil,
        labels: String? = nil,
        values: String? = nil,
        rules: String? = nil,
        ruleMatch: RevenexxEnums.RuleMatch? = nil,
        rulesComputedAt: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/categories"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "code": code,
            "parent_id": parentId,
            "path": path,
            "position": position,
            "labels": labels,
            "values": values,
            "rules": rules,
            "rule_match": ruleMatch,
            "rules_computed_at": rulesComputedAt,
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
    /// Creates one category and answers 201 with the stored row, including the id
    /// and the timestamps the database filled in — a client never sends an id,
    /// it reads one back and uses it in the path of every later call.
    /// 
    /// One node of the category tree. `parent_id` is the structure this app
    /// navigates — null is a root — while `path` is kept only for importers
    /// that carry one and nothing here reads or writes it. A category is
    /// hand-picked or RULE-DRIVEN: a non-null `rules` selector makes every
    /// matching product a `product_categories` row with source `rule`, alongside
    /// the hand-picked ones, and `rules_computed_at` says when that last
    /// completed.
    /// 
    /// `code` is the only column the database refuses the row without; everything
    /// else has a default or is nullable. A second row with the same `code`
    /// answers 409.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - parentId: String (optional)
    ///   - path: String (optional)
    ///   - position: Int (optional)
    ///   - ruleMatch: RevenexxEnums.CategoriesRuleMatch (optional)
    ///   - rules: Any (optional)
    ///   - rulesComputedAt: String (optional)
    ///   - values: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCategoriesCreate(
        code: String,
        labels: Any? = nil,
        parentId: String? = nil,
        path: String? = nil,
        position: Int? = nil,
        ruleMatch: RevenexxEnums.CategoriesRuleMatch? = nil,
        rules: Any? = nil,
        rulesComputedAt: String? = nil,
        values: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/categories"

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "parent_id": parentId,
            "path": path,
            "position": position,
            "rule_match": ruleMatch,
            "rules": rules,
            "rules_computed_at": rulesComputedAt,
            "values": values
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
    /// What the nightly `recompute-category-rules` schedule calls, and the call to
    /// reach for after a bulk import has changed what the rules select. Same sync
    /// as the single-category recompute, applied to every category with non-null
    /// rules. The whole run shares ONE budget: a category the budget no longer
    /// reaches is reported as `skipped` and picked up by the next run, and a
    /// failing category is reported in its result entry instead of aborting the
    /// run.
    ///
    /// - Parameters:
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCategoriesRulesRecomputeAll(
        data: Any
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/categories/rules/recompute-all"

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
    /// Dry-runs a rule: how many products it selects, plus a sample of up to ten,
    /// and it WRITES NOTHING. Evaluates the rule in the request body against the
    /// live catalog WITHOUT touching product_categories — this powers the
    /// cockpit's "matches N products" preview while an operator edits a rule.
    /// Soft-deleted products are excluded. Counting is delegated to the database,
    /// never enumerated: a rule that compiles to a single query is answered by one
    /// exact-count request whatever its match set. A rule that needs several
    /// queries (rule_match "any", or a repeated column such as a range) is
    /// combined in the app and stops at `cap` ids — check `capped` before
    /// showing `count` as a total.
    ///
    /// - Parameters:
    ///   - categoryId: String
    ///   - conditions: [RevenexxModels.CategoryRuleCondition]
    ///   - ruleMatch: RevenexxEnums.CategoryRuleMatch (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCategoriesRulesPreview(
        categoryId: String,
        conditions: [RevenexxModels.CategoryRuleCondition],
        ruleMatch: RevenexxEnums.CategoryRuleMatch? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/categories/{category_id}/rules/preview"
            .replacingOccurrences(of: "{category_id}", with: categoryId)

        let apiParams: [String: Any?] = [
            "conditions": conditions,
            "rule_match": ruleMatch
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
    /// Syncs one category's rule-derived memberships to what its stored rule
    /// selects today. Evaluates categories.rules (NOT the request body), then
    /// inserts the newly matching products as source='rule' rows and deletes the
    /// rule rows that no longer match. Manual (source='manual') memberships are
    /// never inserted, deleted or shadowed. Stamps categories.rules_computed_at.
    /// 
    /// A large category does NOT finish in one call: the run stops when its
    /// wall-clock budget is spent and answers `done: false` with the `cursor` to
    /// send back, so drive it in a loop until `done` is true.
    ///
    /// - Parameters:
    ///   - categoryId: String
    ///   - cursor: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCategoriesRulesRecompute(
        categoryId: String,
        cursor: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/categories/{category_id}/rules/recompute"
            .replacingOccurrences(of: "{category_id}", with: categoryId)

        let apiParams: [String: Any?] = [
            "cursor": cursor
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
    /// Deletes one category by id. It is a hard delete — the row is gone, and
    /// the answer is a confirmation rather than a result to branch on.
    /// 
    /// It takes what hangs off it: product category memberships (`category_id`)
    /// are deleted with it. `categories.parent_id` is set to null instead, so the
    /// rows that pointed at it survive the delete rather than going with it.
    /// 
    /// An id no category of this tenant carries answers 404; there is no 409,
    /// because every foreign key pointing at this entity resolves itself on delete
    /// rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCategoriesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/categories/{id}"
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
    /// Reads one category by its id — the whole row, every column, as it is
    /// stored.
    /// 
    /// One node of the category tree. `parent_id` is the structure this app
    /// navigates — null is a root — while `path` is kept only for importers
    /// that carry one and nothing here reads or writes it. A category is
    /// hand-picked or RULE-DRIVEN: a non-null `rules` selector makes every
    /// matching product a `product_categories` row with source `rule`, alongside
    /// the hand-picked ones, and `rules_computed_at` says when that last
    /// completed.
    /// 
    /// An id no category of this tenant carries answers 404, and so does one
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
    open func productsCategoriesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/categories/{id}"
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
    /// Updates one category by id. A partial patch: the body names only the
    /// columns to change and every column it leaves out keeps its current value,
    /// so there is no read-modify-write and no way to blank a field by forgetting
    /// it.
    /// 
    /// One node of the category tree. `parent_id` is the structure this app
    /// navigates — null is a root — while `path` is kept only for importers
    /// that carry one and nothing here reads or writes it. A category is
    /// hand-picked or RULE-DRIVEN: a non-null `rules` selector makes every
    /// matching product a `product_categories` row with source `rule`, alongside
    /// the hand-picked ones, and `rules_computed_at` says when that last
    /// completed.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `code` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - parentId: String (optional)
    ///   - path: String (optional)
    ///   - position: Int (optional)
    ///   - ruleMatch: RevenexxEnums.CategoriesRuleMatch (optional)
    ///   - rules: Any (optional)
    ///   - rulesComputedAt: String (optional)
    ///   - values: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCategoriesUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        parentId: String? = nil,
        path: String? = nil,
        position: Int? = nil,
        ruleMatch: RevenexxEnums.CategoriesRuleMatch? = nil,
        rules: Any? = nil,
        rulesComputedAt: String? = nil,
        values: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/categories/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "parent_id": parentId,
            "path": path,
            "position": position,
            "rule_match": ruleMatch,
            "rules": rules,
            "rules_computed_at": rulesComputedAt,
            "values": values
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
    /// One membership: this product is filed in this category. `source` says how
    /// it got there — `manual` is hand-picked, `rule` was materialized by a
    /// category rule — and the two never touch each other: a recompute only ever
    /// inserts and deletes `rule` rows, so a hand-picked membership survives every
    /// pass. `POST /products/{id}/categories` is the friendlier way to create one,
    /// because it takes the product from the path and answers with the category
    /// code and the SKU.
    /// 
    /// Every column of `product_categories` is an exact-match query parameter,
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
    ///   - categoryId: String (optional)
    ///   - position: Int (optional)
    ///   - source: RevenexxEnums.Source (optional)
    ///   - createdAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func productsProductCategoriesList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        id: String? = nil,
        productId: String? = nil,
        categoryId: String? = nil,
        position: Int? = nil,
        source: RevenexxEnums.Source? = nil,
        createdAt: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/products/product_categories"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "id": id,
            "product_id": productId,
            "category_id": categoryId,
            "position": position,
            "source": source,
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
    /// Creates one product category membership and answers 201 with the stored
    /// row, including the id and the timestamps the database filled in — a
    /// client never sends an id, it reads one back and uses it in the path of
    /// every later call.
    /// 
    /// One membership: this product is filed in this category. `source` says how
    /// it got there — `manual` is hand-picked, `rule` was materialized by a
    /// category rule — and the two never touch each other: a recompute only ever
    /// inserts and deletes `rule` rows, so a hand-picked membership survives every
    /// pass. `POST /products/{id}/categories` is the friendlier way to create one,
    /// because it takes the product from the path and answers with the category
    /// code and the SKU.
    /// 
    /// `product_id` and `category_id` are the only columns the database refuses
    /// the row without; everything else has a default or is nullable. A second row
    /// with the same `product_id` and `category_id` answers 409.
    ///
    /// - Parameters:
    ///   - categoryId: String
    ///   - productId: String
    ///   - position: Int (optional)
    ///   - source: RevenexxEnums.ProductCategoriesSource (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsProductCategoriesCreate(
        categoryId: String,
        productId: String,
        position: Int? = nil,
        source: RevenexxEnums.ProductCategoriesSource? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/product_categories"

        let apiParams: [String: Any?] = [
            "category_id": categoryId,
            "position": position,
            "product_id": productId,
            "source": source
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
    /// Deletes one product category membership by id. It is a hard delete — the
    /// row is gone, and the answer is a confirmation rather than a result to
    /// branch on.
    /// 
    /// Nothing in this schema references it, so nothing else changes.
    /// 
    /// An id no product category membership of this tenant carries answers 404;
    /// there is no 409, because every foreign key pointing at this entity resolves
    /// itself on delete rather than blocking one.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsProductCategoriesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/product_categories/{id}"
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
    /// Reads one product category membership by its id — the whole row, every
    /// column, as it is stored.
    /// 
    /// One membership: this product is filed in this category. `source` says how
    /// it got there — `manual` is hand-picked, `rule` was materialized by a
    /// category rule — and the two never touch each other: a recompute only ever
    /// inserts and deletes `rule` rows, so a hand-picked membership survives every
    /// pass. `POST /products/{id}/categories` is the friendlier way to create one,
    /// because it takes the product from the path and answers with the category
    /// code and the SKU.
    /// 
    /// An id no product category membership of this tenant carries answers 404,
    /// and so does one belonging to another tenant: row-level security makes that
    /// row invisible rather than forbidden. A malformed id answers 400 before the
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
    open func productsProductCategoriesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/product_categories/{id}"
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
    /// Updates one product category membership by id. A partial patch: the body
    /// names only the columns to change and every column it leaves out keeps its
    /// current value, so there is no read-modify-write and no way to blank a field
    /// by forgetting it.
    /// 
    /// One membership: this product is filed in this category. `source` says how
    /// it got there — `manual` is hand-picked, `rule` was materialized by a
    /// category rule — and the two never touch each other: a recompute only ever
    /// inserts and deletes `rule` rows, so a hand-picked membership survives every
    /// pass. `POST /products/{id}/categories` is the friendlier way to create one,
    /// because it takes the product from the path and answers with the category
    /// code and the SKU.
    /// 
    /// A body that names nothing writable is refused with 400 rather than answered
    /// as a no-op, an id nobody carries answers 404, and a value that collides on
    /// `product_id` and `category_id` answers 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - categoryId: String (optional)
    ///   - position: Int (optional)
    ///   - productId: String (optional)
    ///   - source: RevenexxEnums.ProductCategoriesSource (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsProductCategoriesUpdate(
        id: String,
        categoryId: String? = nil,
        position: Int? = nil,
        productId: String? = nil,
        source: RevenexxEnums.ProductCategoriesSource? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/product_categories/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "category_id": categoryId,
            "position": position,
            "product_id": productId,
            "source": source
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
    /// Files one product into one category by hand, and the membership is always
    /// `source: 'manual'` — a rule recompute never deletes or shadows it.
    /// product_categories holds 28 758 rows and had no write surface that named
    /// the product it was filing. This takes the product from the route and the
    /// category from the body, which is what a bulk 'add the selected products to
    /// …' needs. The membership is always source='manual', so a rule recompute
    /// never deletes or shadows it.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - categoryId: String
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func productsCategoriesAssign(
        id: String,
        categoryId: String,
        position: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/products/{id}/categories"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "category_id": categoryId,
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


}