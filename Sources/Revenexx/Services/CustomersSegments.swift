import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Named groups of ORGANIZATIONS — never of people — built by hand, by rule, or both at once, plus the memberships that record which of the two a company came in by. The rule language is the one product categories use, evaluated over organization columns and settings AND over order behaviour (revenue, order count, average order value, days since the last order) read from this app's own metrics projection, because the orders app may not be joined. Rules are materialized rather than live: preview one before storing it, then recompute one segment or every segment that carries rules.
open class CustomersSegments: Service {

    ///
    /// One organization inside one segment, plus the record of how it got there:
    /// `source: "manual"` for a company somebody put in, `source: "rule"` for one
    /// the rule engine matched. That distinction is what lets a recompute rewrite
    /// its own rows and leave every hand-picked one alone. The membership rows
    /// themselves — the answer to "which companies are in this segment"
    /// (`segment_id`) and to "which segments is this company in"
    /// (`organization_id`). Paged with `limit`/`offset`/`order`.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - segmentId: String (optional)
    ///   - organizationId: String (optional)
    ///   - source: RevenexxEnums.Source (optional)
    ///   - createdAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersSegmentMembersList(
        id: String? = nil,
        segmentId: String? = nil,
        organizationId: String? = nil,
        source: RevenexxEnums.Source? = nil,
        createdAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/segment_members"

        let apiParams: [String: Any?] = [
            "id": id,
            "segment_id": segmentId,
            "organization_id": organizationId,
            "source": source,
            "created_at": createdAt,
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
    /// One organization inside one segment, plus the record of how it got there:
    /// `source: "manual"` for a company somebody put in, `source: "rule"` for one
    /// the rule engine matched. That distinction is what lets a recompute rewrite
    /// its own rows and leave every hand-picked one alone. Adds a company to a
    /// segment BY HAND. The row is `source: "manual"`, which is what protects it:
    /// a rule recompute rewrites the rule-derived rows of that segment and never
    /// touches this one. A create cannot omit `segment_id` and `organization_id`;
    /// everything else is optional or defaulted by the database. Two rows of this
    /// tenant may not share the combination of `segment_id` + `organization_id`.
    ///
    /// - Parameters:
    ///   - organizationId: String
    ///   - segmentId: String
    ///   - source: RevenexxEnums.SegmentMemberSource (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentMembersCreate(
        organizationId: String,
        segmentId: String,
        source: RevenexxEnums.SegmentMemberSource? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segment_members"

        let apiParams: [String: Any?] = [
            "organization_id": organizationId,
            "segment_id": segmentId,
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
    /// One organization inside one segment, plus the record of how it got there:
    /// `source: "manual"` for a company somebody put in, `source: "rule"` for one
    /// the rule engine matched. That distinction is what lets a recompute rewrite
    /// its own rows and leave every hand-picked one alone. Takes the company out
    /// of the segment. If the segment carries rules and the company still matches
    /// them, the next recompute puts it back; remove it from the rule, not from
    /// the list. Nothing else in this app points at it, so nothing else goes with
    /// it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentMembersDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segment_members/{id}"
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
    /// One organization inside one segment, plus the record of how it got there:
    /// `source: "manual"` for a company somebody put in, `source: "rule"` for one
    /// the rule engine matched. That distinction is what lets a recompute rewrite
    /// its own rows and leave every hand-picked one alone. One membership row by
    /// id, with the `source` that says how it came about.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentMembersGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segment_members/{id}"
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
    /// One organization inside one segment, plus the record of how it got there:
    /// `source: "manual"` for a company somebody put in, `source: "rule"` for one
    /// the rule engine matched. That distinction is what lets a recompute rewrite
    /// its own rows and leave every hand-picked one alone. A partial update. In
    /// practice there is little to change — a membership is a pair of ids — so
    /// this exists for the `source` correction rather than as the normal path. Two
    /// rows of this tenant may not share the combination of `segment_id` +
    /// `organization_id`.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - organizationId: String (optional)
    ///   - segmentId: String (optional)
    ///   - source: RevenexxEnums.SegmentMemberSource (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentMembersUpdate(
        id: String,
        organizationId: String? = nil,
        segmentId: String? = nil,
        source: RevenexxEnums.SegmentMemberSource? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segment_members/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "organization_id": organizationId,
            "segment_id": segmentId,
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
    /// A segment is a named group of ORGANIZATIONS — never of people — built
    /// by hand, by rule, or both at once. It is what a price list, a campaign or a
    /// shipping option is pointed at when the answer is "these customers, not
    /// those". Every segment this tenant keeps, with its stored rules. Any column
    /// filters and the page is `limit`/`offset`/`order`. Which companies are
    /// actually IN one is `segment_members`, because the rule half is materialized
    /// rather than evaluated on read.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - code: String (optional)
    ///   - position: Int (optional)
    ///   - ruleMatch: RevenexxEnums.RuleMatch (optional)
    ///   - rulesComputedAt: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersSegmentsList(
        id: String? = nil,
        code: String? = nil,
        position: Int? = nil,
        ruleMatch: RevenexxEnums.RuleMatch? = nil,
        rulesComputedAt: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/segments"

        let apiParams: [String: Any?] = [
            "id": id,
            "code": code,
            "position": position,
            "rule_match": ruleMatch,
            "rules_computed_at": rulesComputedAt,
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
    /// A segment is a named group of ORGANIZATIONS — never of people — built
    /// by hand, by rule, or both at once. It is what a price list, a campaign or a
    /// shipping option is pointed at when the answer is "these customers, not
    /// those". Creates the group. Rules are optional: leave them out for a
    /// hand-picked list, or store a rule document and let the recompute keep the
    /// membership up to date. The `code` is what other apps point at, so pick it
    /// deliberately. `code` is the only field a create cannot omit; everything
    /// else is optional or defaulted by the database. Two rows of this tenant may
    /// not share `code`.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - ruleMatch: RevenexxEnums.SegmentRuleMatch (optional)
    ///   - rules: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentsCreate(
        code: String,
        labels: Any? = nil,
        position: Int? = nil,
        ruleMatch: RevenexxEnums.SegmentRuleMatch? = nil,
        rules: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segments"

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "position": position,
            "rule_match": ruleMatch,
            "rules": rules
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
    /// Same sync as the single-segment recompute, applied to every segment with
    /// non-null rules. A failing segment is reported in its result entry instead
    /// of aborting the run. The run shares one budget: a segment that does not fit
    /// reports done:false (or skipped:true) and keeps rules_computed_at null, so
    /// the next call resumes it from its own data. Repeat until the top-level done
    /// is true.
    ///
    /// - Parameters:
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentsRulesRecomputeAll(
        data: Any
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segments/rules/recompute-all"

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
    /// A segment is a named group of ORGANIZATIONS — never of people — built
    /// by hand, by rule, or both at once. It is what a price list, a campaign or a
    /// shipping option is pointed at when the answer is "these customers, not
    /// those". Removes the segment. Anything in another app that points at its
    /// `code` — a price list, a campaign — is left pointing at nothing,
    /// because no app may hold a foreign key into another (ADR-0055). Deleting one
    /// takes every `segment_members` row that points at it with it — the foreign
    /// keys decide, not this route.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segments/{id}"
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
    /// A segment is a named group of ORGANIZATIONS — never of people — built
    /// by hand, by rule, or both at once. It is what a price list, a campaign or a
    /// shipping option is pointed at when the answer is "these customers, not
    /// those". One segment by id, including the rule document it carries. A
    /// segment with no rules is hand-picked and completely valid.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segments/{id}"
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
    /// A segment is a named group of ORGANIZATIONS — never of people — built
    /// by hand, by rule, or both at once. It is what a price list, a campaign or a
    /// shipping option is pointed at when the answer is "these customers, not
    /// those". A partial update — send only what changes. Editing the rules does
    /// NOT re-evaluate them: that is `POST
    /// /customers/segments/{segment_id}/rules/recompute`, so a half-typed rule
    /// never silently empties a live segment. Two rows of this tenant may not
    /// share `code`.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - labels: Any (optional)
    ///   - position: Int (optional)
    ///   - ruleMatch: RevenexxEnums.SegmentRuleMatch (optional)
    ///   - rules: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentsUpdate(
        id: String,
        code: String? = nil,
        labels: Any? = nil,
        position: Int? = nil,
        ruleMatch: RevenexxEnums.SegmentRuleMatch? = nil,
        rules: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segments/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "labels": labels,
            "position": position,
            "rule_match": ruleMatch,
            "rules": rules
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
    /// A dry run: it answers how many organizations the rule would select, with a
    /// handful of them by name, and writes nothing at all. Evaluates the rule
    /// document in the REQUEST BODY (not the stored segments.rules), so the
    /// cockpit can preview an unsaved rule. Costs a single count query for the
    /// common single-query rule; 'any' rules and rules repeating a column are
    /// combined in the app and capped at 5000 ids, in which case 'capped' is true
    /// and 'count' is a LOWER bound. Membership is never touched.
    ///
    /// - Parameters:
    ///   - segmentId: String
    ///   - conditions: [RevenexxModels.SegmentRuleCondition]
    ///   - ruleMatch: RevenexxEnums.RuleMatch (optional)
    ///   - target: RevenexxEnums.Target (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentsRulesPreview(
        segmentId: String,
        conditions: [RevenexxModels.SegmentRuleCondition],
        ruleMatch: RevenexxEnums.RuleMatch? = nil,
        target: RevenexxEnums.Target? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segments/{segment_id}/rules/preview"
            .replacingOccurrences(of: "{segment_id}", with: segmentId)

        let apiParams: [String: Any?] = [
            "conditions": conditions,
            "rule_match": ruleMatch,
            "target": target
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
    /// Evaluates segments.rules (NOT the request body), then inserts the newly
    /// matching organizations as source='rule' rows and deletes the rule rows that
    /// no longer match. Manual (source='manual') memberships are never inserted,
    /// deleted or shadowed. Bounded by a wall-clock budget below the gateway's
    /// upstream timeout: when 'done' is false, POST again with the returned
    /// 'cursor' until it is true. added/removed/processed count THIS call only.
    /// Omitting 'cursor' resumes an unfinished pass and starts a fresh one after a
    /// completed pass; an explicit null always restarts.
    /// segments.rules_computed_at is stamped only when the pass completes.
    ///
    /// - Parameters:
    ///   - segmentId: String
    ///   - cursor: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersSegmentsRulesRecompute(
        segmentId: String,
        cursor: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/segments/{segment_id}/rules/recompute"
            .replacingOccurrences(of: "{segment_id}", with: segmentId)

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


}