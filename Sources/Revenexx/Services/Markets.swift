import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Commerce Studio Markets App — the market/region backbone of the Revenue Cloud. A market is a distinct business context within a tenant (a country, a region, a B2C storefront segment) with its own base currency, locales (language + country), traded currencies and tax classes (standard, reduced, …). Markets provides the 'market' scope dimension to the Entity Scoping Engine, so every other commerce app (products, orders, customers, …) can slice its data per market. Storefronts resolve their full market context (currency, locales, currencies, tax classes) in one call.
open class Markets: Service {

    ///
    /// Every column is an exact-match filter and they combine with AND
    /// (?code=northwind); each one is declared as a query parameter above. A
    /// `?column=value` this entity does not have is DROPPED rather than refused
    /// — the call answers 200 with the unfiltered list — and `filter` echoes
    /// what was actually applied, which is the only way to tell that apart from a
    /// filter that matched nothing.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - code: String (optional)
    ///   - name: String (optional)
    ///   - labels: String (optional)
    ///   - currency: String (optional)
    ///   - status: RevenexxEnums.MarketsListStatus (optional)
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsList(
        id: String? = nil,
        code: String? = nil,
        name: String? = nil,
        labels: String? = nil,
        currency: String? = nil,
        status: RevenexxEnums.MarketsListStatus? = nil,
        isDefault: Bool? = nil,
        position: Int? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets"

        let apiParams: [String: Any?] = [
            "id": id,
            "code": code,
            "name": name,
            "labels": labels,
            "currency": currency,
            "status": status,
            "is_default": isDefault,
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
    /// A market needs a 'code' and a 'name' — currency defaults to EUR, status
    /// to active. To get a market that can actually trade, clone an existing one
    /// instead: POST /markets/{id}/clone.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - name: String
    ///   - currency: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - status: RevenexxEnums.MarketStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsCreate(
        code: String,
        name: String,
        currency: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        status: RevenexxEnums.MarketStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets"

        let apiParams: [String: Any?] = [
            "code": code,
            "currency": currency,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "status": status
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
    /// How this tenant keys its translations, resolved for a surface that stands
    /// in no market at all. The Cockpit edits a tenant BASELINE when no market is
    /// selected, and a baseline value has to be readable by every market — so
    /// the locale set answered here is the UNION of every market's locales, each
    /// one already resolved to the key it is written under, not one market's list
    /// and not a pair of setting names to re-implement. Each entry names the
    /// markets that asked for that locale: an editor listing six inputs without
    /// saying who needs them invites translations nobody will ever read.
    /// Write/read keys follow the same two settings as the per-market answer, so a
    /// baseline and a market value can never be keyed differently.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.TenantLocalePolicy
    ///
    open func marketsLocalePolicy(
    ) async throws -> RevenexxModels.TenantLocalePolicy {
        let apiPath: String = "/v1/markets/locale-policy"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.TenantLocalePolicy = { response in
            return RevenexxModels.TenantLocalePolicy.from(map: response as! [String: Any])
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
    /// Every closed value set this app owns, listed by name with its title and its
    /// description but WITHOUT its values — enough to build a menu of them, and
    /// a name to fetch one by when a select box actually needs the values. Static
    /// per app version; nothing about a tenant changes it. It reads no table and
    /// takes no parameter, so 200 is the only answer it has beyond the gateway's
    /// own.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.MarketsVocabularyIndex
    ///
    open func marketsVocabularies(
    ) async throws -> RevenexxModels.MarketsVocabularyIndex {
        let apiPath: String = "/v1/markets/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.MarketsVocabularyIndex = { response in
            return RevenexxModels.MarketsVocabularyIndex.from(map: response as! [String: Any])
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
    /// One value set in full: every value the column may hold, in the order it may
    /// hold them, with the copy and the badge tone a client renders each one as.
    /// The values are not kept in a list beside the database, they are parsed out
    /// of the CHECK constraint in this app's own schema.json — so the set served
    /// here IS the set enforced on a write, and a select box built from it cannot
    /// offer a value the write would then refuse. A name outside the declared enum
    /// is a 404 rather than an empty list — an empty vocabulary and an unknown
    /// one mean different things to a select box.
    ///
    /// - Parameters:
    ///   - name: RevenexxEnums.MarketsVocabularyName
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsVocabulary(
        name: RevenexxEnums.MarketsVocabularyName
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/vocabularies/{name}"
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

    ///
    /// Deleting a market takes its locales, currencies and tax classes with it:
    /// all three carry an ON DELETE CASCADE onto markets.id, so this is never
    /// refused for having children.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{id}"
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
    /// Resolved by uuid only — unlike /readiness, /clone, /backfill and
    /// /make-default, a market CODE here is a 400 rather than a lookup.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{id}"
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
    /// Partial: omitted fields keep their value.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - currency: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - status: RevenexxEnums.MarketStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsUpdate(
        id: String,
        code: String? = nil,
        currency: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        status: RevenexxEnums.MarketStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "currency": currency,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "status": status
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
    /// Repairs the market in the path out of a source market that is already
    /// right. The two are compared by CODE, collection by collection, and only the
    /// codes this market does not already carry are added — so a locale, a
    /// currency or a tax class it already holds is left exactly as the merchant
    /// left it, rate included, and is never overwritten. Both the path id and
    /// `source` are resolved by uuid OR by market code. Idempotent: running it
    /// twice adds nothing the second time.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - source: String
    ///   - currencies: Bool (optional)
    ///   - locales: Bool (optional)
    ///   - taxClasses: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsBackfill(
        id: String,
        source: String,
        currencies: Bool? = nil,
        locales: Bool? = nil,
        taxClasses: Bool? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{id}/backfill"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "currencies": currencies,
            "locales": locales,
            "source": source,
            "tax_classes": taxClasses
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
    /// Creates a NEW market out of an existing one, taking its locales, its traded
    /// currencies and its tax classes with it in a single call. That is the
    /// difference between this and POST /markets: a plain create leaves a row that
    /// cannot serve anybody, while what comes back here is a market with a
    /// language to render in, a currency to price in and a rate to tax with. The
    /// path id is the SOURCE market, resolved by uuid OR by market code.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String
    ///   - copyCurrencies: Bool (optional)
    ///   - copyLocales: Bool (optional)
    ///   - copyTaxClasses: Bool (optional)
    ///   - currency: String (optional)
    ///   - name: String (optional)
    ///   - status: RevenexxEnums.MarketStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsClone(
        id: String,
        code: String,
        copyCurrencies: Bool? = nil,
        copyLocales: Bool? = nil,
        copyTaxClasses: Bool? = nil,
        currency: String? = nil,
        name: String? = nil,
        status: RevenexxEnums.MarketStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{id}/clone"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "copy_currencies": copyCurrencies,
            "copy_locales": copyLocales,
            "copy_tax_classes": copyTaxClasses,
            "currency": currency,
            "name": name,
            "status": status
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
    /// The storefront bootstrap: everything a frontend needs to render one market,
    /// resolved server-side so no client re-derives it — the market row, its
    /// locales, the currencies it trades in and its tax classes; WHICH locale to
    /// actually render in and where that answer came from; which key to read and
    /// write a translation under; whether the prices it will be handed are gross
    /// or net; and whether any of it is trustworthy. One call rather than five,
    /// and — more to the point — one place the resolution rules live, instead
    /// of a slightly different copy of them in every storefront. This one resolves
    /// the market by id only: unlike /readiness, /clone and /backfill, a market
    /// CODE here is a 400, not a lookup.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsContext(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{id}/context"
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
    /// A tenant has ONE default market: it is what every call naming none falls
    /// back to. Moving the flag from a client was promote-then-demote, two PATCHes
    /// that leave two defaults when the second does not land and none when the
    /// first does. This is the one call instead — it promotes the market in the
    /// path and demotes whoever held the flag in the same operation, writing once
    /// per row that was actually wrong and not touching the rest. Accepts an id or
    /// a market CODE. Answers the market plus the codes it demoted; repeating the
    /// call writes nothing.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsMakeDefault(
        id: String,
        data: Any
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{id}/make-default"
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
    /// Whether this market can actually trade, and if not, what is missing. Every
    /// check runs on every call and comes back with its own severity, so the
    /// answer is a diagnosis rather than a yes or a no: a market with no currency
    /// registered has nothing to price in and a market with no tax class has
    /// nothing to tax with, and both of those fail BLOCKING, which is what turns
    /// `ready` false. A check that is merely degraded — no locale of its own,
    /// while the tenant declares a fallback_locale that covers for it — fails as
    /// a warning and leaves the market serviceable. Resolves the market by uuid OR
    /// by market code.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsReadiness(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{id}/readiness"
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
    /// Every column is an exact-match filter and they combine with AND
    /// (?code=EUR); each one is declared as a query parameter above. A
    /// `?column=value` this entity does not have is DROPPED rather than refused
    /// — the call answers 200 with the unfiltered list — and `filter` echoes
    /// what was actually applied, which is the only way to tell that apart from a
    /// filter that matched nothing. `market_id` is not among them: the owning
    /// market comes from the path and overwrites anything the query says. An
    /// unknown but well-formed market lists empty rather than 404 — the parent
    /// is filtered on, not verified.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String (optional)
    ///   - code: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    ///   - createdAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsCurrenciesList(
        marketId: String,
        id: String? = nil,
        code: String? = nil,
        isDefault: Bool? = nil,
        position: Int? = nil,
        createdAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/currencies"
            .replacingOccurrences(of: "{market_id}", with: marketId)

        let apiParams: [String: Any?] = [
            "id": id,
            "code": code,
            "is_default": isDefault,
            "position": position,
            "created_at": createdAt,
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
    /// The owning market comes from the path and overrides anything in the body.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - code: String
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsCurrenciesCreate(
        marketId: String,
        code: String,
        isDefault: Bool? = nil,
        position: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/currencies"
            .replacingOccurrences(of: "{market_id}", with: marketId)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
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
    /// Scoped to the market in the path — a row belonging to another market is a
    /// 404 here, and is never deleted.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsCurrenciesDelete(
        marketId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/currencies/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
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
    /// Scoped strictly to the market in the path: a row belonging to another
    /// market is a 404 here, never a 200.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsCurrenciesGet(
        marketId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/currencies/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
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
    /// Partial: omitted fields keep their value.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    ///   - code: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsCurrenciesUpdate(
        marketId: String,
        id: String,
        code: String? = nil,
        isDefault: Bool? = nil,
        position: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/currencies/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
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
    /// Every column is an exact-match filter and they combine with AND
    /// (?code=de-DE); each one is declared as a query parameter above. A
    /// `?column=value` this entity does not have is DROPPED rather than refused
    /// — the call answers 200 with the unfiltered list — and `filter` echoes
    /// what was actually applied, which is the only way to tell that apart from a
    /// filter that matched nothing. `market_id` is not among them: the owning
    /// market comes from the path and overwrites anything the query says. An
    /// unknown but well-formed market lists empty rather than 404 — the parent
    /// is filtered on, not verified.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String (optional)
    ///   - code: String (optional)
    ///   - language: String (optional)
    ///   - country: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    ///   - createdAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsLocalesList(
        marketId: String,
        id: String? = nil,
        code: String? = nil,
        language: String? = nil,
        country: String? = nil,
        isDefault: Bool? = nil,
        position: Int? = nil,
        createdAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/locales"
            .replacingOccurrences(of: "{market_id}", with: marketId)

        let apiParams: [String: Any?] = [
            "id": id,
            "code": code,
            "language": language,
            "country": country,
            "is_default": isDefault,
            "position": position,
            "created_at": createdAt,
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
    /// The owning market comes from the path and overrides anything in the body.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - code: String
    ///   - country: String
    ///   - language: String
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsLocalesCreate(
        marketId: String,
        code: String,
        country: String,
        language: String,
        isDefault: Bool? = nil,
        position: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/locales"
            .replacingOccurrences(of: "{market_id}", with: marketId)

        let apiParams: [String: Any?] = [
            "code": code,
            "country": country,
            "is_default": isDefault,
            "language": language,
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
    /// Scoped to the market in the path — a row belonging to another market is a
    /// 404 here, and is never deleted.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsLocalesDelete(
        marketId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/locales/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
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
    /// Scoped strictly to the market in the path: a row belonging to another
    /// market is a 404 here, never a 200.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsLocalesGet(
        marketId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/locales/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
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
    /// Partial: omitted fields keep their value.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    ///   - code: String (optional)
    ///   - country: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - language: String (optional)
    ///   - position: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsLocalesUpdate(
        marketId: String,
        id: String,
        code: String? = nil,
        country: String? = nil,
        isDefault: Bool? = nil,
        language: String? = nil,
        position: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/locales/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "country": country,
            "is_default": isDefault,
            "language": language,
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
    /// Every column is an exact-match filter and they combine with AND
    /// (?code=standard); each one is declared as a query parameter above. A
    /// `?column=value` this entity does not have is DROPPED rather than refused
    /// — the call answers 200 with the unfiltered list — and `filter` echoes
    /// what was actually applied, which is the only way to tell that apart from a
    /// filter that matched nothing. `market_id` is not among them: the owning
    /// market comes from the path and overwrites anything the query says. An
    /// unknown but well-formed market lists empty rather than 404 — the parent
    /// is filtered on, not verified.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String (optional)
    ///   - code: String (optional)
    ///   - name: String (optional)
    ///   - labels: String (optional)
    ///   - rate: Double (optional)
    ///   - isDefault: Bool (optional)
    ///   - position: Int (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsTaxClassesList(
        marketId: String,
        id: String? = nil,
        code: String? = nil,
        name: String? = nil,
        labels: String? = nil,
        rate: Double? = nil,
        isDefault: Bool? = nil,
        position: Int? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes"
            .replacingOccurrences(of: "{market_id}", with: marketId)

        let apiParams: [String: Any?] = [
            "id": id,
            "code": code,
            "name": name,
            "labels": labels,
            "rate": rate,
            "is_default": isDefault,
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
    /// The owning market comes from the path and overrides anything in the body.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - code: String
    ///   - name: String
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - rate: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsTaxClassesCreate(
        marketId: String,
        code: String,
        name: String,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        rate: Double? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes"
            .replacingOccurrences(of: "{market_id}", with: marketId)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "rate": rate
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
    /// Refused with a 409 for as long as another app still points at this tax
    /// class by its code. A tax class is the source of record for a rate, and
    /// other apps name it by CODE with no foreign key behind it — a cross-app FK
    /// is what ADR-0055 forbids. So this asks the shipping app what still uses the
    /// code (shipping.tax-classes.usage) and answers 409 with the count and the
    /// first few names rather than leaving methods quoting a rate nobody defines.
    /// The check FAILS OPEN: a tenant without the shipping app, or an unreachable
    /// one, deletes as before, and the answer says which happened in
    /// 'usage_checked'. Matched on the code, which is shared across markets —
    /// the refusal message says so.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsTaxClassesDelete(
        marketId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
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
    /// Scoped strictly to the market in the path: a row belonging to another
    /// market is a 404 here, never a 200.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsTaxClassesGet(
        marketId: String,
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
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
    /// Partial: omitted fields keep their value.
    ///
    /// - Parameters:
    ///   - marketId: String
    ///   - id: String
    ///   - code: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - labels: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - rate: Double (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func marketsTaxClassesUpdate(
        marketId: String,
        id: String,
        code: String? = nil,
        isDefault: Bool? = nil,
        labels: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        rate: Double? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/markets/{market_id}/tax_classes/{id}"
            .replacingOccurrences(of: "{market_id}", with: marketId)
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "is_default": isDefault,
            "labels": labels,
            "name": name,
            "position": position,
            "rate": rate
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