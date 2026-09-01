import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// WHAT is offered, what it costs, and the answer a checkout gets. A shipping method is the line a buyer picks: a pricing model ('fixed', 'free' or 'matrix'), the countries it may be offered into, a free-above threshold, and the carrier it ships with. A matrix method prices off its own rate tiers — a lookup table of `from_value` → price, nested under the method, deleted with it — which is why they are one group and not two: a method with pricing_type 'matrix' and no tiers quotes nothing at all. POST /shipping/rates is the read side of everything in here: it takes the buyer context and answers with the methods that apply and their computed prices, plus an `excluded` list naming the ones that did not and why. The delivery promise on that answer is inherited from the carrier and is described under that group.
open class ShippingMethods: Service {

    ///
    /// Filterable by exact column value — `?code=`, `?enabled=`,
    /// `?pricing_type=`, `?carrier_id=`, `?carrier=` and `?tax_class=` are applied
    /// as equalities and echoed back in `filter`. `?carrier_id=` and `?carrier=`
    /// are the two halves of one question: the first finds the methods holding a
    /// reference, the second the ones still resolving through the legacy code
    /// text. A query key that names no column of this entity is SILENTLY IGNORED
    /// — `?status=` on this route is the trap, since carriers have a status and
    /// methods do not: the page comes back unfiltered, 200, with an empty
    /// `filter`.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - code: String (optional)
    ///   - enabled: Bool (optional)
    ///   - pricingType: RevenexxEnums.PricingType (optional)
    ///   - carrierId: String (optional)
    ///   - carrier: String (optional)
    ///   - taxClass: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingMethodsList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        code: String? = nil,
        enabled: Bool? = nil,
        pricingType: RevenexxEnums.PricingType? = nil,
        carrierId: String? = nil,
        carrier: String? = nil,
        taxClass: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "code": code,
            "enabled": enabled,
            "pricing_type": pricingType,
            "carrier_id": carrierId,
            "carrier": carrier,
            "tax_class": taxClass
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
    /// A shipping method is the line a buyer picks in the checkout: a pricing
    /// model ('fixed', 'free' or 'matrix'), the countries it may be offered into,
    /// a free-above threshold, and the carrier it ships with. The method owns the
    /// PRICE; the delivery promise — tracking template, cut-off, handling and
    /// transit days — is inherited from the carrier wherever the method states
    /// none of its own. A create cannot omit `code` and `name`; every other column
    /// is optional or defaulted by the database. Two rows of this tenant may not
    /// share `code` — that is the 409. The new method is quoted by nobody until
    /// two further things are true: `enabled` defaults to FALSE, and a 'matrix'
    /// method has no tiers yet — until POST or PUT …/tiers gives it some it
    /// appears in `excluded` with 'matrix has no rate tiers configured' rather
    /// than in the rates. `carrier_id` and the legacy `carrier` code are both
    /// accepted and neither is verified against the carrier table here: an
    /// unmatched code is a plain carrier name on the rate, not an error.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - name: String
    ///   - carrier: String (optional)
    ///   - carrierId: String (optional)
    ///   - countries: [String] (optional)
    ///   - currency: String (optional)
    ///   - description: String (optional)
    ///   - enabled: Bool (optional)
    ///   - etaDaysMax: Int (optional)
    ///   - etaDaysMin: Int (optional)
    ///   - freeAbove: Double (optional)
    ///   - labels: Any (optional)
    ///   - matrixAttribute: String (optional)
    ///   - matrixBasis: RevenexxEnums.ShippingMethodMatrixBasis (optional)
    ///   - metadata: Any (optional)
    ///   - position: Int (optional)
    ///   - price: Double (optional)
    ///   - pricingType: RevenexxEnums.ShippingMethodPricingType (optional)
    ///   - quoteAbove: Double (optional)
    ///   - taxClass: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingMethodsCreate(
        code: String,
        name: String,
        carrier: String? = nil,
        carrierId: String? = nil,
        countries: [String]? = nil,
        currency: String? = nil,
        description: String? = nil,
        enabled: Bool? = nil,
        etaDaysMax: Int? = nil,
        etaDaysMin: Int? = nil,
        freeAbove: Double? = nil,
        labels: Any? = nil,
        matrixAttribute: String? = nil,
        matrixBasis: RevenexxEnums.ShippingMethodMatrixBasis? = nil,
        metadata: Any? = nil,
        position: Int? = nil,
        price: Double? = nil,
        pricingType: RevenexxEnums.ShippingMethodPricingType? = nil,
        quoteAbove: Double? = nil,
        taxClass: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods"

        let apiParams: [String: Any?] = [
            "carrier": carrier,
            "carrier_id": carrierId,
            "code": code,
            "countries": countries,
            "currency": currency,
            "description": description,
            "enabled": enabled,
            "eta_days_max": etaDaysMax,
            "eta_days_min": etaDaysMin,
            "free_above": freeAbove,
            "labels": labels,
            "matrix_attribute": matrixAttribute,
            "matrix_basis": matrixBasis,
            "metadata": metadata,
            "name": name,
            "position": position,
            "price": price,
            "pricing_type": pricingType,
            "quote_above": quoteAbove,
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
    /// Runs the carrier seed first, then creates any missing method: the three
    /// lines a shop is expected to offer — standard, express and pickup. The app
    /// runs this itself on `app.installed`, so a fresh install already has them;
    /// calling it by hand afterwards is how a tenant that deleted one gets it
    /// back, and calling it twice costs nothing, because it reconciles rather than
    /// seeds. The seeded methods deliberately name no carrier: which carrier
    /// carries the standard method is a contract, not a default, and a method that
    /// says 'dhl' resolves to the seeded DHL row anyway.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func shippingMethodsDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/methods/defaults"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Deleting one takes every `shipping_rate_tiers` row that points at it with
    /// it — the foreign keys decide that, not this route. So the whole rate
    /// matrix goes with the method, which is also why this never answers a
    /// conflict and why there is no way to recover the table afterwards — for a
    /// method a checkout may still be holding in a session, `enabled: false` is
    /// the safer edit.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingMethodsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{id}"
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
    /// A shipping method is the line a buyer picks in the checkout: a pricing
    /// model ('fixed', 'free' or 'matrix'), the countries it may be offered into,
    /// a free-above threshold, and the carrier it ships with. The method owns the
    /// PRICE; the delivery promise — tracking template, cut-off, handling and
    /// transit days — is inherited from the carrier wherever the method states
    /// none of its own. This is the CONFIGURATION of one, by row id — not what a
    /// buyer would be charged. A matrix method's prices are not in here at all:
    /// they are its rate tiers, GET /shipping/methods/{method_id}/tiers, and the
    /// price for a given basket is POST /shipping/rates, which is the only place
    /// free-above thresholds, country restrictions, the carrier's reach and tax
    /// are applied. A checkout that reads `price` off this row prices a matrix
    /// method at 0.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingMethodsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{id}"
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
    /// A shipping method is the line a buyer picks in the checkout: a pricing
    /// model ('fixed', 'free' or 'matrix'), the countries it may be offered into,
    /// a free-above threshold, and the carrier it ships with. The method owns the
    /// PRICE; the delivery promise — tracking template, cut-off, handling and
    /// transit days — is inherited from the carrier wherever the method states
    /// none of its own. A partial update — send only what changes, whether that
    /// is taking the method in or out of the checkout, its pricing, the countries
    /// it is restricted to or the delivery estimate it states of its own; a
    /// payload carrying no column at all is refused rather than answering a row it
    /// did not touch. Flipping `enabled` is what puts the method in front of a
    /// buyer or takes it away, and a disabled method is reported in the rate
    /// answer's `excluded` rather than hidden. Changing `pricing_type` away from
    /// 'matrix' does NOT delete the tier table — it stops being read, and
    /// changing back reinstates the old prices, so a method switched to 'fixed'
    /// and back quotes what it quoted before. Two rows of this tenant may not
    /// share `code` — that is the 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - carrier: String (optional)
    ///   - carrierId: String (optional)
    ///   - code: String (optional)
    ///   - countries: [String] (optional)
    ///   - currency: String (optional)
    ///   - description: String (optional)
    ///   - enabled: Bool (optional)
    ///   - etaDaysMax: Int (optional)
    ///   - etaDaysMin: Int (optional)
    ///   - freeAbove: Double (optional)
    ///   - labels: Any (optional)
    ///   - matrixAttribute: String (optional)
    ///   - matrixBasis: RevenexxEnums.ShippingMethodMatrixBasis (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - price: Double (optional)
    ///   - pricingType: RevenexxEnums.ShippingMethodPricingType (optional)
    ///   - quoteAbove: Double (optional)
    ///   - taxClass: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingMethodsUpdate(
        id: String,
        carrier: String? = nil,
        carrierId: String? = nil,
        code: String? = nil,
        countries: [String]? = nil,
        currency: String? = nil,
        description: String? = nil,
        enabled: Bool? = nil,
        etaDaysMax: Int? = nil,
        etaDaysMin: Int? = nil,
        freeAbove: Double? = nil,
        labels: Any? = nil,
        matrixAttribute: String? = nil,
        matrixBasis: RevenexxEnums.ShippingMethodMatrixBasis? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        price: Double? = nil,
        pricingType: RevenexxEnums.ShippingMethodPricingType? = nil,
        quoteAbove: Double? = nil,
        taxClass: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "carrier": carrier,
            "carrier_id": carrierId,
            "code": code,
            "countries": countries,
            "currency": currency,
            "description": description,
            "enabled": enabled,
            "eta_days_max": etaDaysMax,
            "eta_days_min": etaDaysMin,
            "free_above": freeAbove,
            "labels": labels,
            "matrix_attribute": matrixAttribute,
            "matrix_basis": matrixBasis,
            "metadata": metadata,
            "name": name,
            "position": position,
            "price": price,
            "pricing_type": pricingType,
            "quote_above": quoteAbove,
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
    /// The rate matrix of one method — every `from_value` threshold with the
    /// price charged at or above it — lowest threshold first. Filterable by
    /// `?from_value=` — the unique index is (tenant_id, method_id, from_value),
    /// so that addresses one row of the matrix by the threshold it prices rather
    /// than by an id a bulk replace has already discarded. The applied filters are
    /// echoed in `filter`, which always carries the `method_id` taken from the
    /// path.
    ///
    /// - Parameters:
    ///   - methodId: String
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - fromValue: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingTiersList(
        methodId: String,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        fromValue: Double? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers"
            .replacingOccurrences(of: "{method_id}", with: methodId)

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "from_value": fromValue
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
    /// A rate tier is one row of a matrix method's price table: a `from_value`
    /// threshold and the price charged at or above it. The bound is INCLUSIVE and
    /// the winning tier is the one with the highest `from_value` at or below the
    /// measured value, so a measure of exactly 10 is priced by the tier at 10.
    /// What the number measures is the method's `matrix_basis` — kilograms in
    /// the market's own weight unit, items, money in the method's currency, or a
    /// named attribute — and the last tier has no upper bound. This adds ONE row
    /// to the table of the method in the path, leaving the rest alone — the edit
    /// for a merchant who has added a heavier bracket. To lay a whole table down
    /// at once use PUT …/tiers (set semantics) or POST …/tiers/ladder (evenly
    /// stepped), and note that both of those DISCARD the ids of the rows they
    /// replace. Two rows of this tenant may not share the combination of
    /// `method_id` + `from_value` — that is the 409. `method_id` is taken from
    /// the path on every write, so a body naming a different method is ignored
    /// rather than obeyed.
    ///
    /// - Parameters:
    ///   - methodId: String
    ///   - fromValue: Double (optional)
    ///   - position: Int (optional)
    ///   - price: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingTiersCreate(
        methodId: String,
        fromValue: Double? = nil,
        position: Int? = nil,
        price: Double? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers"
            .replacingOccurrences(of: "{method_id}", with: methodId)

        let apiParams: [String: Any?] = [
            "from_value": fromValue,
            "position": position,
            "price": price
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
    /// The write behind a table editor: a merchant edits the whole matrix on
    /// screen and saves it in one call, rather than diffing it into a row added
    /// here and a row deleted there. Set semantics, and it replaces EVERY tier the
    /// method had: the tiers this method has afterwards are exactly the ones
    /// handed in, positions derived from the array order. An empty `tiers` array
    /// clears the table — and a matrix method with no tiers quotes nothing, with
    /// a reason.
    ///
    /// - Parameters:
    ///   - methodId: String
    ///   - tiers: [RevenexxModels.ShippingRateTierReplaceItem]
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingTiersReplace(
        methodId: String,
        tiers: [RevenexxModels.ShippingRateTierReplaceItem]
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers"
            .replacingOccurrences(of: "{method_id}", with: methodId)

        let apiParams: [String: Any?] = [
            "tiers": tiers
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
    /// The tier table a merchant describes in words — "0 to 30 kg, every 5 kg,
    /// €4.90 plus €2 a step" — without typing every row. Replaces the
    /// method's tiers by default (set replace=false to append).
    ///
    /// - Parameters:
    ///   - methodId: String
    ///   - basePrice: Double
    ///   - step: Double
    ///   - toValue: Double
    ///   - fromValue: Double (optional)
    ///   - replace: Bool (optional)
    ///   - stepPrice: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingTiersLadder(
        methodId: String,
        basePrice: Double,
        step: Double,
        toValue: Double,
        fromValue: Double? = nil,
        replace: Bool? = nil,
        stepPrice: Double? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers/ladder"
            .replacingOccurrences(of: "{method_id}", with: methodId)

        let apiParams: [String: Any?] = [
            "base_price": basePrice,
            "from_value": fromValue,
            "replace": replace,
            "step": step,
            "step_price": stepPrice,
            "to_value": toValue
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
    /// A rate tier is one row of a matrix method's price table: a `from_value`
    /// threshold and the price charged at or above it. The bound is INCLUSIVE and
    /// the winning tier is the one with the highest `from_value` at or below the
    /// measured value, so a measure of exactly 10 is priced by the tier at 10.
    /// What the number measures is the method's `matrix_basis` — kilograms in
    /// the market's own weight unit, items, money in the method's currency, or a
    /// named attribute — and the last tier has no upper bound. Removing a tier
    /// in the MIDDLE of a table is harmless — the measures it used to cover fall
    /// to the highest remaining threshold below them. Removing the LOWEST one is
    /// not: a measure under the new lowest threshold matches no tier at all, and
    /// the method is then left out of POST /shipping/rates with 'no tier covers
    /// measure …' instead of being quoted at 0, so an entire band of baskets
    /// silently stops being offered this method. Deleting the last tier takes the
    /// method out of the checkout altogether. Rebuilding the table wholesale is
    /// PUT …/tiers or POST …/tiers/ladder; deleting the method deletes its
    /// tiers on its own.
    ///
    /// - Parameters:
    ///   - methodId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingTiersDelete(
        methodId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers/{id}"
            .replacingOccurrences(of: "{method_id}", with: methodId)
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
    /// A rate tier is one row of a matrix method's price table: a `from_value`
    /// threshold and the price charged at or above it. The bound is INCLUSIVE and
    /// the winning tier is the one with the highest `from_value` at or below the
    /// measured value, so a measure of exactly 10 is priced by the tier at 10.
    /// What the number measures is the method's `matrix_basis` — kilograms in
    /// the market's own weight unit, items, money in the method's currency, or a
    /// named attribute — and the last tier has no upper bound. This reads one
    /// row of that table by id, under the method that owns it; a tier id belonging
    /// to another method is a 404 rather than somebody else's price. A tier id is
    /// not durable: PUT …/tiers and POST …/tiers/ladder replace the table by
    /// deleting and recreating it, so an id read before either of them names
    /// nothing afterwards. Where a caller wants a stable handle, address the row
    /// by what it MEANS — GET …/tiers?from_value=… — since (method_id,
    /// from_value) is unique.
    ///
    /// - Parameters:
    ///   - methodId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingTiersGet(
        methodId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers/{id}"
            .replacingOccurrences(of: "{method_id}", with: methodId)
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
    /// A tier id is not stable across a bulk edit: `PUT …/tiers` and `POST
    /// …/tiers/ladder` replace the table by deleting and recreating it, so an id
    /// read before either of them is gone afterwards.
    ///
    /// - Parameters:
    ///   - methodId: String
    ///   - id: String
    ///   - fromValue: Double (optional)
    ///   - position: Int (optional)
    ///   - price: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingTiersUpdate(
        methodId: String,
        id: String,
        fromValue: Double? = nil,
        position: Int? = nil,
        price: Double? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/methods/{method_id}/tiers/{id}"
            .replacingOccurrences(of: "{method_id}", with: methodId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "from_value": fromValue,
            "position": position,
            "price": price
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
    /// The question a checkout asks, and the only route that answers a PRICE. Hand
    /// in the buyer context — the destination country, the order value, and
    /// whatever the matrix methods measure: a weight, a quantity or a named
    /// product attribute — and this comes back with the methods that may be
    /// offered and what each of them costs, free-above thresholds, country
    /// restrictions, the carrier's delivery promise and tax already applied. A
    /// method that does not apply is never an error: it moves to `excluded` with a
    /// reason. So is a tax rate that cannot be resolved — `tax.resolved: false`
    /// means the rates are UNKNOWN, not untaxed.
    ///
    /// - Parameters:
    ///   - at: String (optional)
    ///   - attributes: Any (optional)
    ///   - country: String (optional)
    ///   - currency: String (optional)
    ///   - marketId: String (optional)
    ///   - orderValue: Double (optional)
    ///   - orderValueGross: Double (optional)
    ///   - orderValueNet: Double (optional)
    ///   - quantity: Double (optional)
    ///   - weight: Double (optional)
    ///   - weightUnit: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingRates(
        at: String? = nil,
        attributes: Any? = nil,
        country: String? = nil,
        currency: String? = nil,
        marketId: String? = nil,
        orderValue: Double? = nil,
        orderValueGross: Double? = nil,
        orderValueNet: Double? = nil,
        quantity: Double? = nil,
        weight: Double? = nil,
        weightUnit: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/rates"

        let apiParams: [String: Any?] = [
            "at": at,
            "attributes": attributes,
            "country": country,
            "currency": currency,
            "market_id": marketId,
            "order_value": orderValue,
            "order_value_gross": orderValueGross,
            "order_value_net": orderValueNet,
            "quantity": quantity,
            "weight": weight,
            "weight_unit": weightUnit
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
    /// markets.tax_classes is the source of record for the rate and this app
    /// points at it by CODE from two places: a method's own tax_class and the
    /// tenant's shipping_tax_class fallback. Neither is a foreign key and neither
    /// could be — a cross-app FK is what ADR-0055 forbids — so integrity is a
    /// question one app asks the other, and this is the answering half. It is
    /// asked before a destructive edit: markets calls it when an operator tries to
    /// delete a tax class, and a count above zero is what stops the delete rather
    /// than leaving these methods pointing at a code nobody serves. Matched as a
    /// CODE, not a row: a tax class is unique per market, so 'reduced' may exist
    /// in several and a method naming it does not say which one it meant. Reports
    /// at most 500 methods and names the first 20. Every code answers, used or not
    /// — a code nobody points at is `in_use: false`, never a 404.
    ///
    /// - Parameters:
    ///   - code: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ShippingTaxClassUsage
    ///
    open func shippingTaxClassesUsage(
        code: String
    ) async throws -> RevenexxModels.ShippingTaxClassUsage {
        let apiPath: String = "/v1/shipping/tax-classes/{code}/usage"
            .replacingOccurrences(of: "{code}", with: code)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ShippingTaxClassUsage = { response in
            return RevenexxModels.ShippingTaxClassUsage.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}