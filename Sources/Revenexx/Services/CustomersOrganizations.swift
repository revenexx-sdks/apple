import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The buying COMPANIES and everything keyed to one: the company rows themselves, their postal addresses, and the revenue/order projection pulled from the orders app. An organization is the unit a contract, a credit limit, a price list and a payment term belong to — not a person, and not a household. Addresses live here because a B2B address is the company's (a contact may own a private one, and that row is reached the same way). The people inside a company are in Contacts, and the groups a company falls into are in Segments.
open class CustomersOrganizations: Service {

    ///
    /// A postal address used for billing or for shipping, owned by exactly one of
    /// the two parties: an organization (the company address everyone in it may
    /// use) or a contact (a private one only that person uses). Both owner columns
    /// are nullable and exactly one is set — sending both, or neither, is
    /// refused. Every address this tenant holds, filterable by owner
    /// (`organization_id`, `contact_id`), by `type` and by any other column. It is
    /// how the addresses tab of a company or a person is filled; the page is
    /// `limit`/`offset`/`order`.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - organizationId: String (optional)
    ///   - contactId: String (optional)
    ///   - type: String (optional)
    ///   - company: String (optional)
    ///   - name: String (optional)
    ///   - street: String (optional)
    ///   - street2: String (optional)
    ///   - zip: String (optional)
    ///   - city: String (optional)
    ///   - region: String (optional)
    ///   - country: String (optional)
    ///   - phone: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersAddressesList(
        id: String? = nil,
        organizationId: String? = nil,
        contactId: String? = nil,
        type: String? = nil,
        company: String? = nil,
        name: String? = nil,
        street: String? = nil,
        street2: String? = nil,
        zip: String? = nil,
        city: String? = nil,
        region: String? = nil,
        country: String? = nil,
        phone: String? = nil,
        isDefault: Bool? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/addresses"

        let apiParams: [String: Any?] = [
            "id": id,
            "organization_id": organizationId,
            "contact_id": contactId,
            "type": type,
            "company": company,
            "name": name,
            "street": street,
            "street2": street2,
            "zip": zip,
            "city": city,
            "region": region,
            "country": country,
            "phone": phone,
            "is_default": isDefault,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "limit": limit,
            "offset": offset,
            "order": order
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// A postal address used for billing or for shipping, owned by exactly one of
    /// the two parties: an organization (the company address everyone in it may
    /// use) or a contact (a private one only that person uses). Both owner columns
    /// are nullable and exactly one is set — sending both, or neither, is
    /// refused. `type` names one of this tenant's own address types — billing
    /// and shipping are seeded, and a merchant may add a works entrance or a
    /// central accounts office without a release of this app. `is_default` picks
    /// the one a checkout should preselect for that owner and that type. A create
    /// cannot omit `street`, `zip`, `city` and `country`; everything else is
    /// optional or defaulted by the database.
    ///
    /// - Parameters:
    ///   - city: String
    ///   - country: String
    ///   - street: String
    ///   - zip: String
    ///   - company: String (optional)
    ///   - contactId: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - name: String (optional)
    ///   - organizationId: String (optional)
    ///   - phone: String (optional)
    ///   - region: String (optional)
    ///   - street2: String (optional)
    ///   - type: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersAddressesCreate(
        city: String,
        country: String,
        street: String,
        zip: String,
        company: String? = nil,
        contactId: String? = nil,
        isDefault: Bool? = nil,
        name: String? = nil,
        organizationId: String? = nil,
        phone: String? = nil,
        region: String? = nil,
        street2: String? = nil,
        type: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/addresses"

        let apiParams: [String: Any?] = [
            "city": city,
            "company": company,
            "contact_id": contactId,
            "country": country,
            "is_default": isDefault,
            "name": name,
            "organization_id": organizationId,
            "phone": phone,
            "region": region,
            "street": street,
            "street2": street2,
            "type": type,
            "zip": zip
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
    /// A postal address used for billing or for shipping, owned by exactly one of
    /// the two parties: an organization (the company address everyone in it may
    /// use) or a contact (a private one only that person uses). Both owner columns
    /// are nullable and exactly one is set — sending both, or neither, is
    /// refused. Removes the address. Orders already placed keep the address they
    /// were placed with; nothing in this app reaches back. Nothing else in this
    /// app points at it, so nothing else goes with it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersAddressesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/addresses/{id}"
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
    /// A postal address used for billing or for shipping, owned by exactly one of
    /// the two parties: an organization (the company address everyone in it may
    /// use) or a contact (a private one only that person uses). Both owner columns
    /// are nullable and exactly one is set — sending both, or neither, is
    /// refused. One address by id, whichever of the two owners it hangs off.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersAddressesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/addresses/{id}"
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
    /// A postal address used for billing or for shipping, owned by exactly one of
    /// the two parties: an organization (the company address everyone in it may
    /// use) or a contact (a private one only that person uses). Both owner columns
    /// are nullable and exactly one is set — sending both, or neither, is
    /// refused. A partial update — send only what changes. An empty body is
    /// refused rather than answered as a no-op, so a client that built the wrong
    /// patch finds out.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - city: String (optional)
    ///   - company: String (optional)
    ///   - contactId: String (optional)
    ///   - country: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - name: String (optional)
    ///   - organizationId: String (optional)
    ///   - phone: String (optional)
    ///   - region: String (optional)
    ///   - street: String (optional)
    ///   - street2: String (optional)
    ///   - type: String (optional)
    ///   - zip: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersAddressesUpdate(
        id: String,
        city: String? = nil,
        company: String? = nil,
        contactId: String? = nil,
        country: String? = nil,
        isDefault: Bool? = nil,
        name: String? = nil,
        organizationId: String? = nil,
        phone: String? = nil,
        region: String? = nil,
        street: String? = nil,
        street2: String? = nil,
        type: String? = nil,
        zip: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/addresses/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "city": city,
            "company": company,
            "contact_id": contactId,
            "country": country,
            "is_default": isDefault,
            "name": name,
            "organization_id": organizationId,
            "phone": phone,
            "region": region,
            "street": street,
            "street2": street2,
            "type": type,
            "zip": zip
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
    /// What an organization has BOUGHT, materialized into this app from the orders
    /// app: lifetime revenue, revenue over the last 30/90/365 days, order count,
    /// average order value, and the first and last order dates. Revenue lives in
    /// orders and may not be joined (ADR-0055: no cross-app foreign key, grant or
    /// view), so it is pulled on a schedule and stored here — one row per
    /// organization, all-zero for a company that never ordered, so that a "never
    /// bought anything" rule has something to match. The customer-value list: sort
    /// by `revenue_365d` for the best customers, filter `last_order_at` for the
    /// dormant ones. Every row carries `computed_at`, and a row is only as current
    /// as the last refresh — `GET /customers/organization_metrics/freshness`
    /// says how stale the set is before a number is shown to anybody.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - organizationId: String (optional)
    ///   - orderCount: Int (optional)
    ///   - orderCount30d: Int (optional)
    ///   - orderCount90d: Int (optional)
    ///   - orderCount365d: Int (optional)
    ///   - revenueTotal: Double (optional)
    ///   - revenue30d: Double (optional)
    ///   - revenue90d: Double (optional)
    ///   - revenue365d: Double (optional)
    ///   - avgOrderValue: Double (optional)
    ///   - avgOrderValue365d: Double (optional)
    ///   - firstOrderAt: String (optional)
    ///   - lastOrderAt: String (optional)
    ///   - currency: String (optional)
    ///   - currencyMixed: Bool (optional)
    ///   - ordersAsOf: String (optional)
    ///   - computedAt: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersOrganizationMetricsList(
        id: String? = nil,
        organizationId: String? = nil,
        orderCount: Int? = nil,
        orderCount30d: Int? = nil,
        orderCount90d: Int? = nil,
        orderCount365d: Int? = nil,
        revenueTotal: Double? = nil,
        revenue30d: Double? = nil,
        revenue90d: Double? = nil,
        revenue365d: Double? = nil,
        avgOrderValue: Double? = nil,
        avgOrderValue365d: Double? = nil,
        firstOrderAt: String? = nil,
        lastOrderAt: String? = nil,
        currency: String? = nil,
        currencyMixed: Bool? = nil,
        ordersAsOf: String? = nil,
        computedAt: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/organization_metrics"

        let apiParams: [String: Any?] = [
            "id": id,
            "organization_id": organizationId,
            "order_count": orderCount,
            "order_count_30d": orderCount30d,
            "order_count_90d": orderCount90d,
            "order_count_365d": orderCount365d,
            "revenue_total": revenueTotal,
            "revenue_30d": revenue30d,
            "revenue_90d": revenue90d,
            "revenue_365d": revenue365d,
            "avg_order_value": avgOrderValue,
            "avg_order_value_365d": avgOrderValue365d,
            "first_order_at": firstOrderAt,
            "last_order_at": lastOrderAt,
            "currency": currency,
            "currency_mixed": currencyMixed,
            "orders_as_of": ordersAsOf,
            "computed_at": computedAt,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "limit": limit,
            "offset": offset,
            "order": order
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// The projection is materialized, so it is only as true as its last refresh.
    /// This is that fact as one answer: the OLDEST computed_at in the table (the
    /// floor, not an average), the anchor those numbers were measured from, and
    /// how many organizations are not covered at all yet.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.OrganizationMetricsFreshness
    ///
    open func customersOrganizationMetricsFreshness(
    ) async throws -> RevenexxModels.OrganizationMetricsFreshness {
        let apiPath: String = "/v1/customers/organization_metrics/freshness"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.OrganizationMetricsFreshness = { response in
            return RevenexxModels.OrganizationMetricsFreshness.from(map: response as! [String: Any])
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
    /// Revenue lives in the orders app and cannot be joined (ADR-0055: no
    /// cross-app FK, grant or view), so it is PULLED: this route walks
    /// organizations in id order, asks orders.reports.customer-rollup about a
    /// batch of them at a time and materializes the answer into
    /// organization_metrics — one row per organization, all-zero for those that
    /// never ordered, so that 'never bought' rules match something. Rows are only
    /// rewritten when a value actually changed, so a routine refresh costs almost
    /// no writes. Bounded by a wall-clock budget below the gateway's upstream
    /// timeout: while 'done' is false, POST again with the returned 'cursor' AND
    /// 'as_of' (pinning as_of is what stops the rolling windows sliding during a
    /// multi-call refresh). 'organization_ids' refreshes exactly those
    /// organizations in a single call — the targeted path after a customer
    /// ordered.
    ///
    /// - Parameters:
    ///   - asOf: String (optional)
    ///   - cursor: String (optional)
    ///   - organizationIds: [String] (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersOrganizationMetricsRefresh(
        asOf: String? = nil,
        cursor: String? = nil,
        organizationIds: [String]? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/organization_metrics/refresh"

        let apiParams: [String: Any?] = [
            "as_of": asOf,
            "cursor": cursor,
            "organization_ids": organizationIds
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
    /// What an organization has BOUGHT, materialized into this app from the orders
    /// app: lifetime revenue, revenue over the last 30/90/365 days, order count,
    /// average order value, and the first and last order dates. Revenue lives in
    /// orders and may not be joined (ADR-0055: no cross-app foreign key, grant or
    /// view), so it is pulled on a schedule and stored here — one row per
    /// organization, all-zero for a company that never ordered, so that a "never
    /// bought anything" rule has something to match. One company's numbers by the
    /// metrics row id. All zeroes mean the company has never ordered, not that the
    /// projection is missing — a missing row means the refresh has not reached
    /// that company yet.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersOrganizationMetricsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/organization_metrics/{id}"
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
    /// An organization is a buying COMPANY — the unit a contract, a credit
    /// limit, a price list and a payment term belong to, and the unit an order is
    /// placed on behalf of. It is not a household and not a person: the people are
    /// `contacts`, and a company with no contacts yet is a perfectly normal row.
    /// Every organization is mirrored into platform auth as a team, so a name
    /// written here is the name storefront authentication shows. The company list
    /// a sales or service desk works from, and the read a segment rule is written
    /// against. Every column of the table is a filter and the page is
    /// `limit`/`offset`/`order` — including the two that are constantly
    /// confused: `status` is ACCESS (active or blocked) and `lifecycle_stage` is
    /// the sales PIPELINE, so filtering the wrong one answers with the wrong
    /// companies rather than with an error.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - name: String (optional)
    ///   - vatId: String (optional)
    ///   - branche: String (optional)
    ///   - customerNumber: String (optional)
    ///   - status: RevenexxEnums.CustomersOrganizationsListStatus (optional)
    ///   - lifecycleStage: String (optional)
    ///   - paymentTerms: String (optional)
    ///   - creditLimit: Double (optional)
    ///   - priceList: String (optional)
    ///   - deliveryBlock: Bool (optional)
    ///   - externalTeamId: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersOrganizationsList(
        id: String? = nil,
        name: String? = nil,
        vatId: String? = nil,
        branche: String? = nil,
        customerNumber: String? = nil,
        status: RevenexxEnums.CustomersOrganizationsListStatus? = nil,
        lifecycleStage: String? = nil,
        paymentTerms: String? = nil,
        creditLimit: Double? = nil,
        priceList: String? = nil,
        deliveryBlock: Bool? = nil,
        externalTeamId: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/organizations"

        let apiParams: [String: Any?] = [
            "id": id,
            "name": name,
            "vat_id": vatId,
            "branche": branche,
            "customer_number": customerNumber,
            "status": status,
            "lifecycle_stage": lifecycleStage,
            "payment_terms": paymentTerms,
            "credit_limit": creditLimit,
            "price_list": priceList,
            "delivery_block": deliveryBlock,
            "external_team_id": externalTeamId,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "limit": limit,
            "offset": offset,
            "order": order
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// An organization is a buying COMPANY — the unit a contract, a credit
    /// limit, a price list and a payment term belong to, and the unit an order is
    /// placed on behalf of. It is not a household and not a person: the people are
    /// `contacts`, and a company with no contacts yet is a perfectly normal row.
    /// Every organization is mirrored into platform auth as a team, so a name
    /// written here is the name storefront authentication shows. Registers a
    /// company as a customer. It is mirrored into platform auth as a team in the
    /// same call, so a failure of the identity service fails the create rather
    /// than leaving half a company behind. `payment_terms` and `lifecycle_stage`
    /// name values from this tenant's own sets, and a newly founded company
    /// inherits the tenant's `default_payment_terms` / `default_credit_limit`
    /// where the merchant set them. `name` is the only field a create cannot omit;
    /// everything else is optional or defaulted by the database. Two rows of this
    /// tenant may not share `customer_number` (while customer_number IS NOT NULL)
    /// or `external_team_id` (while external_team_id IS NOT NULL).
    ///
    /// - Parameters:
    ///   - name: String
    ///   - branche: String (optional)
    ///   - creditLimit: Double (optional)
    ///   - customerNumber: String (optional)
    ///   - deliveryBlock: Bool (optional)
    ///   - lifecycleStage: String (optional)
    ///   - paymentTerms: String (optional)
    ///   - priceList: String (optional)
    ///   - settings: Any (optional)
    ///   - status: RevenexxEnums.OrganizationStatus (optional)
    ///   - vatId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersOrganizationsCreate(
        name: String,
        branche: String? = nil,
        creditLimit: Double? = nil,
        customerNumber: String? = nil,
        deliveryBlock: Bool? = nil,
        lifecycleStage: String? = nil,
        paymentTerms: String? = nil,
        priceList: String? = nil,
        settings: Any? = nil,
        status: RevenexxEnums.OrganizationStatus? = nil,
        vatId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/organizations"

        let apiParams: [String: Any?] = [
            "branche": branche,
            "credit_limit": creditLimit,
            "customer_number": customerNumber,
            "delivery_block": deliveryBlock,
            "lifecycle_stage": lifecycleStage,
            "name": name,
            "payment_terms": paymentTerms,
            "price_list": priceList,
            "settings": settings,
            "status": status,
            "vat_id": vatId
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
    /// An organization is a buying COMPANY — the unit a contract, a credit
    /// limit, a price list and a payment term belong to, and the unit an order is
    /// placed on behalf of. It is not a household and not a person: the people are
    /// `contacts`, and a company with no contacts yet is a perfectly normal row.
    /// Every organization is mirrored into platform auth as a team, so a name
    /// written here is the name storefront authentication shows. Removes the
    /// company and its mirrored team. Its people are NOT deleted: they become
    /// standalone buyers who can still sign in and still order, which is the
    /// behaviour a merchant winding down a subsidiary wants. Deleting one takes
    /// every `contact_events`, `addresses`, `organization_metrics` and
    /// `segment_members` row that points at it with it and clears
    /// `contacts.organization_id` rather than deleting those rows — the foreign
    /// keys decide, not this route.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersOrganizationsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/organizations/{id}"
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
    /// An organization is a buying COMPANY — the unit a contract, a credit
    /// limit, a price list and a payment term belong to, and the unit an order is
    /// placed on behalf of. It is not a household and not a person: the people are
    /// `contacts`, and a company with no contacts yet is a perfectly normal row.
    /// Every organization is mirrored into platform auth as a team, so a name
    /// written here is the name storefront authentication shows. One company by
    /// id, with its commercial terms as stored. What it has BOUGHT is not in here
    /// — that is the `organization_metrics` row for the same id, refreshed on
    /// its own schedule.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersOrganizationsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/organizations/{id}"
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
    /// An organization is a buying COMPANY — the unit a contract, a credit
    /// limit, a price list and a payment term belong to, and the unit an order is
    /// placed on behalf of. It is not a household and not a person: the people are
    /// `contacts`, and a company with no contacts yet is a perfectly normal row.
    /// Every organization is mirrored into platform auth as a team, so a name
    /// written here is the name storefront authentication shows. A partial update
    /// — send only what changes. `external_team_id` is mirror-managed and
    /// ignored if sent. Blocking a company here is what stops it trading; moving
    /// it through the pipeline is `lifecycle_stage`, and the two are independent.
    /// Two rows of this tenant may not share `customer_number` (while
    /// customer_number IS NOT NULL) or `external_team_id` (while external_team_id
    /// IS NOT NULL).
    ///
    /// - Parameters:
    ///   - id: String
    ///   - branche: String (optional)
    ///   - creditLimit: Double (optional)
    ///   - customerNumber: String (optional)
    ///   - deliveryBlock: Bool (optional)
    ///   - lifecycleStage: String (optional)
    ///   - name: String (optional)
    ///   - paymentTerms: String (optional)
    ///   - priceList: String (optional)
    ///   - settings: Any (optional)
    ///   - status: RevenexxEnums.OrganizationStatus (optional)
    ///   - vatId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersOrganizationsUpdate(
        id: String,
        branche: String? = nil,
        creditLimit: Double? = nil,
        customerNumber: String? = nil,
        deliveryBlock: Bool? = nil,
        lifecycleStage: String? = nil,
        name: String? = nil,
        paymentTerms: String? = nil,
        priceList: String? = nil,
        settings: Any? = nil,
        status: RevenexxEnums.OrganizationStatus? = nil,
        vatId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/organizations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "branche": branche,
            "credit_limit": creditLimit,
            "customer_number": customerNumber,
            "delivery_block": deliveryBlock,
            "lifecycle_stage": lifecycleStage,
            "name": name,
            "payment_terms": paymentTerms,
            "price_list": priceList,
            "settings": settings,
            "status": status,
            "vat_id": vatId
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