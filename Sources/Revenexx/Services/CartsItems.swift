import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The lines inside one cart, always addressed through the cart that owns them (`/carts/{cart_id}/items`) — a line is never reachable on its own, and an id from another cart answers 404 rather than the row. A line is a catalogue product, a configured product or a free position, and it carries its price twice: the working `unit_price` and the `snapshot` the buyer was shown. Adding the same article at the same price folds into the line that is already there instead of opening a second one; a configured line always stands alone. Every write here recomputes the owning cart's `item_count` and `subtotal`, so a cart can never disagree with its own lines.
open class CartsItems: Service {

    ///
    /// The array is still called 'items'; the response also carries 'page' and
    /// 'filter' like every other list, and an unknown cart_id answers 404 instead
    /// of an empty page. A cart with more lines than the page size is not silently
    /// truncated — 'page.hasMore' says so. Lines come back in position order
    /// unless 'order' says otherwise.
    ///
    /// - Parameters:
    ///   - cartId: String
    ///   - id: String (optional)
    ///   - type: RevenexxEnums.CartItemType (optional)
    ///   - productId: String (optional)
    ///   - sku: String (optional)
    ///   - name: String (optional)
    ///   - quantity: Double (optional)
    ///   - unit: String (optional)
    ///   - unitPrice: Double (optional)
    ///   - currency: String (optional)
    ///   - taxRate: Double (optional)
    ///   - lineTotal: Double (optional)
    ///   - position: Int (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsItemsList(
        cartId: String,
        id: String? = nil,
        type: RevenexxEnums.CartItemType? = nil,
        productId: String? = nil,
        sku: String? = nil,
        name: String? = nil,
        quantity: Double? = nil,
        unit: String? = nil,
        unitPrice: Double? = nil,
        currency: String? = nil,
        taxRate: Double? = nil,
        lineTotal: Double? = nil,
        position: Int? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{cart_id}/items"
            .replacingOccurrences(of: "{cart_id}", with: cartId)

        let apiParams: [String: Any?] = [
            "id": id,
            "type": type,
            "product_id": productId,
            "sku": sku,
            "name": name,
            "quantity": quantity,
            "unit": unit,
            "unit_price": unitPrice,
            "currency": currency,
            "tax_rate": taxRate,
            "line_total": lineTotal,
            "position": position,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "limit": limit,
            "offset": offset,
            "order": order
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
    /// Adds one line to an ACTIVE cart — the add-to-basket call. `name` or `sku`
    /// is required (a line sent with only a SKU takes the SKU as its name, so a
    /// line always has something to show) and `quantity` must be greater than
    /// zero; everything else defaults, including the currency, which falls back to
    /// the cart's. The one thing that surprises a caller: a plain product line
    /// with the same product/sku AND the same `unit_price` as a line already in
    /// the cart does not open a second row — its quantity is added to that line,
    /// and the 201 names a row that already existed. Price is part of that
    /// identity on purpose, so a changed price never averages into an old line. A
    /// configured or custom line always stands alone. The cart's `item_count` (the
    /// sum of QUANTITIES) and `subtotal` are recomputed before the answer, and
    /// `max_items_per_cart` / `max_quantity_per_line` are checked on the RESULT of
    /// the merge (422), so ten calls of one piece cannot walk past a limit one
    /// call of ten would hit.
    ///
    /// - Parameters:
    ///   - cartId: String
    ///   - configuration: Any (optional)
    ///   - currency: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - sku: String (optional)
    ///   - snapshot: Any (optional)
    ///   - taxRate: Double (optional)
    ///   - type: RevenexxEnums.CartItemType (optional)
    ///   - unit: String (optional)
    ///   - unitPrice: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsItemsCreate(
        cartId: String,
        configuration: Any? = nil,
        currency: String? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        sku: String? = nil,
        snapshot: Any? = nil,
        taxRate: Double? = nil,
        type: RevenexxEnums.CartItemType? = nil,
        unit: String? = nil,
        unitPrice: Double? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{cart_id}/items"
            .replacingOccurrences(of: "{cart_id}", with: cartId)

        let apiParams: [String: Any?] = [
            "configuration": configuration,
            "currency": currency,
            "metadata": metadata,
            "name": name,
            "position": position,
            "product_id": productId,
            "quantity": quantity,
            "sku": sku,
            "snapshot": snapshot,
            "tax_rate": taxRate,
            "type": type,
            "unit": unit,
            "unit_price": unitPrice
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
    /// Set semantics: the payload IS the cart. Every existing line is dropped and
    /// the payload is written in its place, so a line left out of the array is a
    /// line removed — this is the storefront sync, not a bulk add, and
    /// carts.items.create is what adds. Lines are numbered by their place in the
    /// array unless they carry their own `position`, and nothing merges: two
    /// identical lines in one payload stay two rows. The limits are checked
    /// against the payload BEFORE a single existing line is destroyed, so a sync
    /// refused with 422 leaves the cart exactly as it was. The cart must be
    /// active, and its totals are recomputed before the answer.
    ///
    /// - Parameters:
    ///   - cartId: String
    ///   - items: [RevenexxModels.CartItemCreateRequest<AnyCodable>]
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsItemsReplace(
        cartId: String,
        items: [RevenexxModels.CartItemCreateRequest<AnyCodable>]
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{cart_id}/items"
            .replacingOccurrences(of: "{cart_id}", with: cartId)

        let apiParams: [String: Any?] = [
            "items": items
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
    /// Removes one line from an ACTIVE cart and recomputes the owning cart's
    /// `item_count` and `subtotal` before answering. This is how a quantity
    /// reaches zero: `quantity` is constrained to be greater than zero, so "none
    /// of it" is a DELETE and never an update to 0. The cart in the path is part
    /// of the address — a line belonging to a different cart answers 404 and is
    /// left where it is. Deleting the last line leaves an empty cart, not a
    /// deleted one; the cart itself goes through carts.delete, which takes every
    /// line with it in one call.
    ///
    /// - Parameters:
    ///   - cartId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsItemsDelete(
        cartId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{cart_id}/items/{id}"
            .replacingOccurrences(of: "{cart_id}", with: cartId)
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
    /// One line, addressed through the cart that owns it. Both ids are checked,
    /// not just the line's: a line that exists but belongs to a different cart
    /// answers 404 rather than the row, so an id copied out of another cart never
    /// resolves here and a caller can trust that what came back is a line of the
    /// cart they asked about. The line carries both of its prices — the working
    /// `unit_price`, which a resync or a repricing job may have moved, and the
    /// `snapshot` the buyer was shown when the line was added — and its own
    /// `line_total`, which is always quantity × unit_price and never what a
    /// payload claimed. To read a whole cart's lines, list them: this route is for
    /// one known line.
    ///
    /// - Parameters:
    ///   - cartId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsItemsGet(
        cartId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{cart_id}/items/{id}"
            .replacingOccurrences(of: "{cart_id}", with: cartId)
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
    /// Changes one line of an ACTIVE cart — the quantity stepper on the cart
    /// page, and the route a repricing job writes through. The fields sent are
    /// merged onto the stored line and the whole line is validated again, so
    /// `quantity` must still be greater than zero and `type` still one of the
    /// three. `line_total` is not settable: it is recomputed as quantity ×
    /// unit_price, and the cart's `item_count` and `subtotal` follow before the
    /// answer. What it will NOT do is merge — only carts.items.create folds one
    /// line into another, so giving this line the same product and price as a
    /// sibling leaves two rows standing, and the next add joins whichever it
    /// matches. `max_quantity_per_line` is enforced on the result (422). A
    /// quantity of zero is not the way to remove a line; the delete is.
    ///
    /// - Parameters:
    ///   - cartId: String
    ///   - id: String
    ///   - configuration: Any (optional)
    ///   - currency: String (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - productId: String (optional)
    ///   - quantity: Double (optional)
    ///   - sku: String (optional)
    ///   - snapshot: Any (optional)
    ///   - taxRate: Double (optional)
    ///   - type: RevenexxEnums.CartItemType (optional)
    ///   - unit: String (optional)
    ///   - unitPrice: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsItemsUpdate(
        cartId: String,
        id: String,
        configuration: Any? = nil,
        currency: String? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        productId: String? = nil,
        quantity: Double? = nil,
        sku: String? = nil,
        snapshot: Any? = nil,
        taxRate: Double? = nil,
        type: RevenexxEnums.CartItemType? = nil,
        unit: String? = nil,
        unitPrice: Double? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{cart_id}/items/{id}"
            .replacingOccurrences(of: "{cart_id}", with: cartId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "configuration": configuration,
            "currency": currency,
            "metadata": metadata,
            "name": name,
            "position": position,
            "product_id": productId,
            "quantity": quantity,
            "sku": sku,
            "snapshot": snapshot,
            "tax_rate": taxRate,
            "type": type,
            "unit": unit,
            "unit_price": unitPrice
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