import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The value sets a merchant owns, and the fixed ones they do not. Payment terms, address types, lifecycle stages and activity types were CHECK constraints until a wholesaler wanted net 45 and a pipeline step of their own — they are the tenant's ROWS now, so adding one is a call rather than a release of this app. Alongside them the vocabularies: the enums this app really does fix (status, registration status, membership source), published with the titles, descriptions and badge tones a client needs to render a value it has never seen. Plus the one call that seeds a fresh tenant with all four sets.
open class CustomersValueLists: Service {

    ///
    /// What an address is used for. Billing and shipping are what a checkout
    /// needs; a works entrance or a central accounts office is the tenant's own. A
    /// fresh install is seeded with billing, shipping, and the set seeds on first
    /// read too, so the page is never empty and `addresses.type` always has a
    /// value it may carry. The whole set comes back in one page in the tenant's
    /// own order — this route takes no limit/offset/order and no column filters,
    /// so `page` describes the full set and `filter` is always empty.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersAddressTypesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/address-types"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Extends this tenant's address types set with a value of their own — the
    /// whole reason these four stopped being CHECK constraints. What an address is
    /// used for. Billing and shipping are what a checkout needs; a works entrance
    /// or a central accounts office is the tenant's own. The code is lowercase and
    /// becomes what `addresses.type` stores; it cannot be changed afterwards,
    /// because every record carrying it would be orphaned.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - title: String
    ///   - description: String (optional)
    ///   - descriptions: Any (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - tone: RevenexxEnums.Tone (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersAddressTypesCreate(
        code: String,
        title: String,
        description: String? = nil,
        descriptions: Any? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        tone: RevenexxEnums.Tone? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/address-types"

        let apiParams: [String: Any?] = [
            "code": code,
            "description": description,
            "descriptions": descriptions,
            "is_default": isDefault,
            "labels": labels,
            "position": position,
            "title": title,
            "tone": tone
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
    /// Takes a value out of the address types set. There is no foreign key behind
    /// `addresses.type` — one added to a table that starts empty fails the
    /// migration of every existing tenant — so this route IS the integrity: it
    /// refuses while any record still carries the code, and it refuses to empty
    /// the set. Retiring a value that is in use is therefore a two-step job: move
    /// the records onto another value first, then remove it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersAddressTypesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/address-types/{id}"
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
    /// One value of the address types set, by its id — its code, its fallback
    /// title, the per-language `labels` an operator reads and the badge `tone` a
    /// client renders it with. What an address is used for. Billing and shipping
    /// are what a checkout needs; a works entrance or a central accounts office is
    /// the tenant's own. Reading one value is the rare path: `GET
    /// /customers/address-types` answers the whole set in a single page, which is
    /// what a select needs.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersAddressTypesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/address-types/{id}"
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
    /// Everything about a value except the value itself: its titles, its help
    /// text, its badge tone, its `position` in the select, and which one of the
    /// set is the default. The `code` is immutable, so no record carrying it is
    /// ever orphaned by an edit here — a merchant who retitles `shipping` to
    /// wording of their own changes what people READ and nothing about what
    /// `addresses.type` stores. Seeded values (`is_system`) are renameable like
    /// any other, and re-seeding leaves the rename alone.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - description: String (optional)
    ///   - descriptions: Any (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - title: String (optional)
    ///   - tone: RevenexxEnums.Tone (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersAddressTypesUpdate(
        id: String,
        description: String? = nil,
        descriptions: Any? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        title: String? = nil,
        tone: RevenexxEnums.Tone? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/address-types/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "description": description,
            "descriptions": descriptions,
            "is_default": isDefault,
            "labels": labels,
            "position": position,
            "title": title,
            "tone": tone
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
    /// What kind of entry lands on a customer timeline. 'system' is the app's own
    /// decision trail and a caller may not file one, whatever the set says. A
    /// fresh install is seeded with system, note, call, email, meeting, visit,
    /// task, and the set seeds on first read too, so the page is never empty and
    /// `contact_events.kind` always has a value it may carry. The whole set comes
    /// back in one page in the tenant's own order — this route takes no
    /// limit/offset/order and no column filters, so `page` describes the full set
    /// and `filter` is always empty.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersContactEventKindsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/contact-event-kinds"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Extends this tenant's activity types set with a value of their own — the
    /// whole reason these four stopped being CHECK constraints. What kind of entry
    /// lands on a customer timeline. 'system' is the app's own decision trail and
    /// a caller may not file one, whatever the set says. The code is lowercase and
    /// becomes what `contact_events.kind` stores; it cannot be changed afterwards,
    /// because every record carrying it would be orphaned.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - title: String
    ///   - description: String (optional)
    ///   - descriptions: Any (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - tone: RevenexxEnums.Tone (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactEventKindsCreate(
        code: String,
        title: String,
        description: String? = nil,
        descriptions: Any? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        tone: RevenexxEnums.Tone? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contact-event-kinds"

        let apiParams: [String: Any?] = [
            "code": code,
            "description": description,
            "descriptions": descriptions,
            "is_default": isDefault,
            "labels": labels,
            "position": position,
            "title": title,
            "tone": tone
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
    /// Takes a value out of the activity types set. There is no foreign key behind
    /// `contact_events.kind` — one added to a table that starts empty fails the
    /// migration of every existing tenant — so this route IS the integrity: it
    /// refuses while any record still carries the code, and it refuses to empty
    /// the set. Retiring a value that is in use is therefore a two-step job: move
    /// the records onto another value first, then remove it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactEventKindsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contact-event-kinds/{id}"
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
    /// One value of the activity types set, by its id — its code, its fallback
    /// title, the per-language `labels` an operator reads and the badge `tone` a
    /// client renders it with. What kind of entry lands on a customer timeline.
    /// 'system' is the app's own decision trail and a caller may not file one,
    /// whatever the set says. Reading one value is the rare path: `GET
    /// /customers/contact-event-kinds` answers the whole set in a single page,
    /// which is what a select needs.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactEventKindsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contact-event-kinds/{id}"
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
    /// Everything about a value except the value itself: its titles, its help
    /// text, its badge tone, its `position` in the select, and which one of the
    /// set is the default. The `code` is immutable, so no record carrying it is
    /// ever orphaned by an edit here — a merchant who retitles `call` to wording
    /// of their own changes what people READ and nothing about what
    /// `contact_events.kind` stores. Seeded values (`is_system`) are renameable
    /// like any other, and re-seeding leaves the rename alone.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - description: String (optional)
    ///   - descriptions: Any (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - title: String (optional)
    ///   - tone: RevenexxEnums.Tone (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactEventKindsUpdate(
        id: String,
        description: String? = nil,
        descriptions: Any? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        title: String? = nil,
        tone: RevenexxEnums.Tone? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contact-event-kinds/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "description": description,
            "descriptions": descriptions,
            "is_default": isDefault,
            "labels": labels,
            "position": position,
            "title": title,
            "tone": tone
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
    /// What the app.installed event runs. It fills all four of the value sets a
    /// tenant needs before anything else works — the payment terms, the address
    /// types, the lifecycle stages and the activity types — in one call.
    /// Idempotent by code: a set that already has its rows is left completely
    /// alone, so a re-delivered event and a merchant's renames both survive. A
    /// tenant installed before these tables existed is seeded lazily instead, by
    /// the first read that finds one empty.
    ///
    /// - Parameters:
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersDefaults(
        data: Any
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/defaults"

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
    /// Where a company stands in the sales pipeline — a separate axis from
    /// status, and one whose steps are a sales team's own. A fresh install is
    /// seeded with lead, prospect, customer, churned, and the set seeds on first
    /// read too, so the page is never empty and `organizations.lifecycle_stage`
    /// always has a value it may carry. The whole set comes back in one page in
    /// the tenant's own order — this route takes no limit/offset/order and no
    /// column filters, so `page` describes the full set and `filter` is always
    /// empty.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersLifecycleStagesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/lifecycle-stages"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Extends this tenant's lifecycle stages set with a value of their own —
    /// the whole reason these four stopped being CHECK constraints. Where a
    /// company stands in the sales pipeline — a separate axis from status, and
    /// one whose steps are a sales team's own. The code is lowercase and becomes
    /// what `organizations.lifecycle_stage` stores; it cannot be changed
    /// afterwards, because every record carrying it would be orphaned.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - title: String
    ///   - description: String (optional)
    ///   - descriptions: Any (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - tone: RevenexxEnums.Tone (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersLifecycleStagesCreate(
        code: String,
        title: String,
        description: String? = nil,
        descriptions: Any? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        tone: RevenexxEnums.Tone? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/lifecycle-stages"

        let apiParams: [String: Any?] = [
            "code": code,
            "description": description,
            "descriptions": descriptions,
            "is_default": isDefault,
            "labels": labels,
            "position": position,
            "title": title,
            "tone": tone
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
    /// Takes a value out of the lifecycle stages set. There is no foreign key
    /// behind `organizations.lifecycle_stage` — one added to a table that starts
    /// empty fails the migration of every existing tenant — so this route IS the
    /// integrity: it refuses while any record still carries the code, and it
    /// refuses to empty the set. Retiring a value that is in use is therefore a
    /// two-step job: move the records onto another value first, then remove it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersLifecycleStagesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/lifecycle-stages/{id}"
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
    /// One value of the lifecycle stages set, by its id — its code, its fallback
    /// title, the per-language `labels` an operator reads and the badge `tone` a
    /// client renders it with. Where a company stands in the sales pipeline — a
    /// separate axis from status, and one whose steps are a sales team's own.
    /// Reading one value is the rare path: `GET /customers/lifecycle-stages`
    /// answers the whole set in a single page, which is what a select needs.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersLifecycleStagesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/lifecycle-stages/{id}"
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
    /// Everything about a value except the value itself: its titles, its help
    /// text, its badge tone, its `position` in the select, and which one of the
    /// set is the default. The `code` is immutable, so no record carrying it is
    /// ever orphaned by an edit here — a merchant who retitles `customer` to
    /// wording of their own changes what people READ and nothing about what
    /// `organizations.lifecycle_stage` stores. Seeded values (`is_system`) are
    /// renameable like any other, and re-seeding leaves the rename alone.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - description: String (optional)
    ///   - descriptions: Any (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - title: String (optional)
    ///   - tone: RevenexxEnums.Tone (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersLifecycleStagesUpdate(
        id: String,
        description: String? = nil,
        descriptions: Any? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        title: String? = nil,
        tone: RevenexxEnums.Tone? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/lifecycle-stages/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "description": description,
            "descriptions": descriptions,
            "is_default": isDefault,
            "labels": labels,
            "position": position,
            "title": title,
            "tone": tone
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
    /// When a company has to pay. A wholesaler who agrees net 45 with one customer
    /// used to need a release of this app to say so. A fresh install is seeded
    /// with prepayment, direct_debit, net_7, net_14, net_30, net_60, net_90, and
    /// the set seeds on first read too, so the page is never empty and
    /// `organizations.payment_terms` always has a value it may carry. The whole
    /// set comes back in one page in the tenant's own order — this route takes
    /// no limit/offset/order and no column filters, so `page` describes the full
    /// set and `filter` is always empty.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersPaymentTermsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/payment-terms"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Extends this tenant's payment terms set with a value of their own — the
    /// whole reason these four stopped being CHECK constraints. When a company has
    /// to pay. A wholesaler who agrees net 45 with one customer used to need a
    /// release of this app to say so. The code is lowercase and becomes what
    /// `organizations.payment_terms` stores; it cannot be changed afterwards,
    /// because every record carrying it would be orphaned.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - title: String
    ///   - description: String (optional)
    ///   - descriptions: Any (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - tone: RevenexxEnums.Tone (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersPaymentTermsCreate(
        code: String,
        title: String,
        description: String? = nil,
        descriptions: Any? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        tone: RevenexxEnums.Tone? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/payment-terms"

        let apiParams: [String: Any?] = [
            "code": code,
            "description": description,
            "descriptions": descriptions,
            "is_default": isDefault,
            "labels": labels,
            "position": position,
            "title": title,
            "tone": tone
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
    /// Takes a value out of the payment terms set. There is no foreign key behind
    /// `organizations.payment_terms` — one added to a table that starts empty
    /// fails the migration of every existing tenant — so this route IS the
    /// integrity: it refuses while any record still carries the code, and it
    /// refuses to empty the set. Retiring a value that is in use is therefore a
    /// two-step job: move the records onto another value first, then remove it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersPaymentTermsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/payment-terms/{id}"
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
    /// One value of the payment terms set, by its id — its code, its fallback
    /// title, the per-language `labels` an operator reads and the badge `tone` a
    /// client renders it with. When a company has to pay. A wholesaler who agrees
    /// net 45 with one customer used to need a release of this app to say so.
    /// Reading one value is the rare path: `GET /customers/payment-terms` answers
    /// the whole set in a single page, which is what a select needs.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersPaymentTermsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/payment-terms/{id}"
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
    /// Everything about a value except the value itself: its titles, its help
    /// text, its badge tone, its `position` in the select, and which one of the
    /// set is the default. The `code` is immutable, so no record carrying it is
    /// ever orphaned by an edit here — a merchant who retitles `net_30` to
    /// wording of their own changes what people READ and nothing about what
    /// `organizations.payment_terms` stores. Seeded values (`is_system`) are
    /// renameable like any other, and re-seeding leaves the rename alone.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - description: String (optional)
    ///   - descriptions: Any (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - title: String (optional)
    ///   - tone: RevenexxEnums.Tone (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersPaymentTermsUpdate(
        id: String,
        description: String? = nil,
        descriptions: Any? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        title: String? = nil,
        tone: RevenexxEnums.Tone? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/payment-terms/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "description": description,
            "descriptions": descriptions,
            "is_default": isDefault,
            "labels": labels,
            "position": position,
            "title": title,
            "tone": tone
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
    /// Discovery for the vocabulary routes: every enum this app publishes, each as
    /// a name, a title and a description. The VALUES are deliberately left out —
    /// this is the call that says which vocabularies exist, and the detail route
    /// is the one that answers what is in them. Names: address-types,
    /// contact-event-kinds, contact-statuses, lifecycle-stages, locales,
    /// organization-statuses, payment-terms, registration-statuses, roles,
    /// rule-matches, segment-sources. Fetch one with GET
    /// /customers/vocabularies/{name}; a client holding the qualified pair
    /// 'customers.<name>' builds that URL from the pair alone.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.VocabularyIndex
    ///
    open func customersVocabulariesList(
    ) async throws -> RevenexxModels.VocabularyIndex {
        let apiPath: String = "/v1/customers/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.VocabularyIndex = { response in
            return RevenexxModels.VocabularyIndex.from(map: response as! [String: Any])
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
    /// One vocabulary in full: every permitted value, each with its title, its
    /// description and the badge tone a client renders it with — enough to build
    /// a select without a second call. Two kinds of set, and 'source' says which
    /// one answered. 'schema' — the values are read out of the column's CHECK
    /// constraint, so the served set IS the enforced set and the two cannot drift;
    /// a value added to the constraint appears here even before anyone labels it,
    /// titled from its own key. 'table' — the values are the TENANT's own rows
    /// (payment terms, address types, lifecycle stages, activity types, roles), so
    /// they carry labels/descriptions per locale, is_system and is_default, and a
    /// merchant may add to them without a release of this app. 'tenant'/'defaults'
    /// are the two answers for a set the merchant configures but may not extend.
    /// Either way 'closed' is true: the set is exhaustive at this moment, so a
    /// value outside it is stale data rather than a missing label. Values come
    /// back in the order a select should offer them — lifecycle order for a
    /// status, the merchant's own position for a table. Names: address-types,
    /// contact-event-kinds, contact-statuses, lifecycle-stages, locales,
    /// organization-statuses, payment-terms, registration-statuses, roles,
    /// rule-matches, segment-sources.
    ///
    /// - Parameters:
    ///   - name: RevenexxEnums.CustomersVocabulariesGetName
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersVocabulariesGet(
        name: RevenexxEnums.CustomersVocabulariesGetName
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/vocabularies/{name}"
            .replacingOccurrences(of: "{name}", with: name.rawValue)

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


}