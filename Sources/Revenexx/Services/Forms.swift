import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Experience Studio Forms App — operator-built forms (contact request, price request, RMA, …) authored as FormKit schemas, plus a submissions inbox. Every submission is a row that emits form.submitted onto the tenant event bus for automations (Integration Studio workflows, email). The form definition is a FormKit schema rendered verbatim by the storefront (cover), so a form built in the Cockpit drops straight into a storefront page.
open class Forms: Service {

    ///
    /// The catalogue of forms this tenant has authored, a page at a time. A row is
    /// the whole form — `definition`, `settings`, `status`, `slug` — so a list
    /// read is not a summary view that has to be followed by a read per row.
    /// 
    /// Every column of a form except the three jsonb ones is an exact-match
    /// filter, and they combine: `?slug=contact&status=live&limit=1` is how the
    /// storefront resolves the form for a page, and it is why a page never needs
    /// the form's id. The jsonb columns are the deliberate exception — a
    /// comparison against `definition`, `settings` or `metadata` can only be
    /// equality against the WHOLE document, which matches only for a caller who
    /// already holds it, so there is no searching inside a form's fields from
    /// here. (Sending one anyway is not a silent failure: `?definition={}` is
    /// honoured as that whole-document equality, and `?definition=x` is refused
    /// with 400 `invalid_value` naming the parameter.) A query key that is not a
    /// filterable column is dropped rather than refused, and the `filter` echo in
    /// the answer is what tells you which of the two happened: an empty echo
    /// beside a query string that carried a filter means the filter was
    /// misspelled.
    /// 
    /// Paging is `limit`/`offset` with a single-column `order`. The default page
    /// is 50 and 200 is the ceiling — a larger `limit` is clamped rather than
    /// refused, and `page.limit` reports what was applied — while `page.total`
    /// is the figure to show a merchant and `page.hasMore` answers whether another
    /// page follows instead of leaving it to be inferred from a short one.
    /// `order=created_at.desc` is the newest-first reading an editor wants.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - name: String (optional)
    ///   - slug: String (optional)
    ///   - status: RevenexxEnums.FormStatus (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsList(
        id: String? = nil,
        name: String? = nil,
        slug: String? = nil,
        status: RevenexxEnums.FormStatus? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms"

        let apiParams: [String: Any?] = [
            "id": id,
            "name": name,
            "slug": slug,
            "status": status,
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
    /// A form is born a `draft` and stays off the storefront until somebody moves
    /// it to `live`, so creating one is safe: the cover BFF resolves live forms
    /// only, and nothing renders until the status says it may. `definition` may be
    /// omitted entirely — the row is then the empty shell the Form Builder fills
    /// in.
    /// 
    /// `slug` is the one field that is not free. It is unique per tenant and it is
    /// what a storefront resolves a form by, so a create that reuses one is a 409
    /// rather than a second form answering to the same page — and the collision
    /// is often with a form the caller has never opened. `name` is operator-facing
    /// only and may be anything.
    /// 
    /// An unbounded definition is a storefront page nobody can load, so the tenant
    /// sets a ceiling on how many named inputs one form may declare. Only nodes
    /// carrying a non-empty `name` count against it: a form with twenty paragraphs
    /// of legal text and three inputs is a three-field form. A definition over the
    /// ceiling is a 422 and not a 400 — the payload is well formed and would
    /// have been accepted under a higher limit — and the body names both the
    /// count and the limit.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - slug: String
    ///   - definition: [Any] (optional)
    ///   - metadata: Any (optional)
    ///   - settings: Any (optional)
    ///   - status: RevenexxEnums.FormStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsCreate(
        name: String,
        slug: String,
        definition: [Any]? = nil,
        metadata: Any? = nil,
        settings: Any? = nil,
        status: RevenexxEnums.FormStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms"

        let apiParams: [String: Any?] = [
            "definition": definition,
            "metadata": metadata,
            "name": name,
            "settings": settings,
            "slug": slug,
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
    /// Every tenant starts with one sample form so the Form Builder is never empty
    /// and there is a live render and submit target from the first minute — the
    /// `contact` slug the read examples throughout this document resolve against.
    /// 
    /// Normally nobody calls it. The same seeding runs on `app.installed`, so a
    /// tenant that has had the app for more than a moment already has the sample;
    /// this route is the manual re-run, for a tenant installed before the sample
    /// existed or one that removed it and wants it back.
    /// 
    /// It is idempotent, and keyed on the SLUG rather than on content: a slug that
    /// is already taken is left exactly as it stands, so a sample form the
    /// merchant has since rewritten is never overwritten and a second call creates
    /// nothing at all. The answer says which of the two happened, slug by slug —
    /// `created` names what this call wrote, `existing` what was already there —
    /// and on a settled tenant `created` is empty.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.FormDefaultsResult
    ///
    open func formsDefaults(
    ) async throws -> RevenexxModels.FormDefaultsResult {
        let apiPath: String = "/v1/forms/defaults"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.FormDefaultsResult = { response in
            return RevenexxModels.FormDefaultsResult.from(map: response as! [String: Any])
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
    /// The inbox: every submission this tenant has received, a page at a time. A
    /// row is the whole submission, `data` included, so the list is the inbox and
    /// the detail view at once — nothing has to be fetched per row to show what
    /// somebody wrote. Treat all of it as END-USER data.
    /// 
    /// Every column except the two jsonb ones is an exact-match filter and they
    /// combine, so `?form_slug=contact&status=new&order=created_at.desc` is the
    /// unread inbox of one form, newest first. Two of those filters ask the same
    /// question differently: `form_id` is the reliable one and survives a rename
    /// of the form, while `form_slug` is the denormalised copy and needs neither a
    /// join nor a prior lookup. What was SUBMITTED is not searchable here —
    /// `data` is jsonb, and the only comparison available on it is equality
    /// against the whole document, which matches only for a caller who already
    /// holds the entire submission (`?data=x`, not being a JSON document at all,
    /// is refused with 400 `invalid_value`) — so an inbox search belongs on top
    /// of the rows this returns.
    /// 
    /// Paging is `limit`/`offset` with a single-column `order`: the default page
    /// is 50, 200 is the ceiling, and a larger `limit` is clamped rather than
    /// refused. `page.total` is the count to put in front of a merchant while
    /// `page.returned` is only what fitted on this page, and `page.hasMore` says
    /// whether to ask for another.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - formId: String (optional)
    ///   - formSlug: String (optional)
    ///   - source: String (optional)
    ///   - status: RevenexxEnums.FormSubmissionStatus (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsSubmissionsList(
        id: String? = nil,
        formId: String? = nil,
        formSlug: String? = nil,
        source: String? = nil,
        status: RevenexxEnums.FormSubmissionStatus? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/submissions"

        let apiParams: [String: Any?] = [
            "id": id,
            "form_id": formId,
            "form_slug": formSlug,
            "source": source,
            "status": status,
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
    /// The storefront's path, and the moment a lead enters the platform. A stored
    /// submission emits `form.submitted` onto the tenant event bus with the row
    /// itself as the payload — that is the event an Integration Studio workflow
    /// or a notification email listens to, and it is the only event this app
    /// raises about a submission. A call that is refused therefore leaves no trace
    /// anywhere: no row, and no automation that ever hears about it.
    /// 
    /// It is also the only moment anything is known about a submission, so the
    /// tenant's policy is applied here. If honeypot_field names a decoy and the
    /// submission filled it in, the field is stripped — it is a trap, not an
    /// answer the visitor gave, so it never reaches `data` — and spam_handling
    /// (flag | reject) decides between storing the row as 'spam' and refusing
    /// outright with 422.
    /// 
    /// The notification recipient is resolved once, here: the form's own
    /// notify_email, else the tenant's, stamped into metadata.notify_email with
    /// metadata.notify_source naming which of the two won. It is resolved at
    /// insert rather than at delivery because the row IS the event payload — a
    /// workflow reads the address off the event instead of re-resolving a form's
    /// settings that may since have changed.
    ///
    /// - Parameters:
    ///   - data: Any
    ///   - formId: String
    ///   - formSlug: String (optional)
    ///   - metadata: Any (optional)
    ///   - source: String (optional)
    ///   - status: RevenexxEnums.FormSubmissionStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsSubmissionsCreate(
        data: Any,
        formId: String,
        formSlug: String? = nil,
        metadata: Any? = nil,
        source: String? = nil,
        status: RevenexxEnums.FormSubmissionStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/submissions"

        let apiParams: [String: Any?] = [
            "data": data,
            "form_id": formId,
            "form_slug": formSlug,
            "metadata": metadata,
            "source": source,
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
    /// The retention sweep. It deletes submissions the tenant has stopped
    /// promising to keep — everything older than `submission_retention_days` —
    /// and it is the one route in this app that reads that promise at all.
    /// 
    /// Nothing runs on a timer — an app that quietly deletes a merchant's leads
    /// on a schedule nobody watched is the failure mode worth avoiding. This is
    /// the only thing that acts on submission_retention_days, it previews unless
    /// dry_run is explicitly false, and it deletes at most 500 rows per call
    /// (`remaining` says whether to call again).
    /// 
    /// The sweep is TENANT-WIDE and cannot be narrowed to a market. A submission
    /// carries no market: there is no such column, and the platform's scope
    /// register is written by a best-effort trigger that only fires when the
    /// writer sent `X-Revenexx-Market` — which the storefront omits whenever the
    /// visitor has selected no market, and the Cockpit never sends. So an
    /// unassigned row means "nobody recorded it" at least as often as it means
    /// "global", and attributing it either way would risk deleting one market's
    /// leads on another market's schedule.
    /// 
    /// `submission_retention_days` is per market, because a retention period is a
    /// legal answer and the law is territorial. The floor this sweep applies is
    /// therefore the STRICTEST one in the tenant — the longest value configured
    /// anywhere, baseline or market — and not the one the calling market sees.
    /// `retention_days` reports it and `retention_market` names whose it was. The
    /// consequence worth knowing: one market cannot prune on a shorter schedule
    /// than another market promised, because the one sweep would take both
    /// markets' rows.
    /// 
    /// The floor is established, never assumed. If the tenant's markets cannot be
    /// listed, or a settings read falls back to its declared defaults (which for
    /// retention is 0 — no floor at all), the answer is 503 and nothing is
    /// deleted.
    ///
    /// - Parameters:
    ///   - dryRun: Bool (optional)
    ///   - formSlug: String (optional)
    ///   - olderThanDays: Int (optional)
    ///   - status: RevenexxEnums.FormsSubmissionsPruneStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsSubmissionsPrune(
        dryRun: Bool? = nil,
        formSlug: String? = nil,
        olderThanDays: Int? = nil,
        status: RevenexxEnums.FormsSubmissionsPruneStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/submissions/prune"

        let apiParams: [String: Any?] = [
            "dry_run": dryRun,
            "form_slug": formSlug,
            "older_than_days": olderThanDays,
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
    /// Removes one submission permanently. There is no soft delete anywhere in
    /// this app — no `deleted_at`, no trash, no undo — so the row and the
    /// end-user data in it are gone when this answers.
    /// 
    /// Nothing is emitted when they go. This app publishes `form.submitted` on
    /// insert and has no delete event, so an automation that already acted on the
    /// submission is never told it was withdrawn; if that matters, the withdrawal
    /// has to be carried by whatever raised it.
    /// 
    /// Nothing else is touched: the form keeps its `definition` and its other
    /// submissions. Reach for this for the one-off — an erasure request, a test
    /// row, a duplicate. For the many, use `POST /v1/forms/submissions/prune`,
    /// which previews before it acts and cannot go below the tenant's
    /// `submission_retention_days`; that floor does NOT apply here, so this route
    /// deletes a submission the retention policy would still be keeping. And if
    /// the point is to get a lead out of the inbox rather than out of the
    /// database, PUT its `status` to `archived` instead.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsSubmissionsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/submissions/{id}"
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
    /// One received submission, whole — the detail view behind a row of `GET
    /// /v1/forms/submissions`.
    /// 
    /// `data` is the substance: what the visitor actually typed, keyed by the
    /// `name` of each node in the form's `definition`. Around it are `source` (the
    /// page that carried the form), the inbox `status`, and the `metadata` this
    /// app stamped at insert — `notify_email` and `notify_source`, the recipient
    /// the `form.submitted` event carried, so a workflow and a human reading the
    /// inbox see the same answer.
    /// 
    /// Treat what comes back as END-USER data: a name, an address, an enquiry,
    /// whatever the operator asked for. This is also the call the retention
    /// preview points at — `POST /v1/forms/submissions/prune` deliberately
    /// samples only id, form and date, so this route is where you look to see what
    /// a sweep would actually take.
    /// 
    /// What you read here is what was sent: under the shipped `submission_edit`
    /// policy a PUT may move `status` and `metadata` and nothing else, so the
    /// submitted values, the form and the arrival time are the record rather than
    /// a draft.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsSubmissionsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/submissions/{id}"
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
    /// Triage, not correction. What this route is FOR is moving the inbox `status`
    /// — 'new' to 'read' as somebody opens the lead, 'archived' once it is dealt
    /// with, 'spam' for what the honeypot did not catch — and stamping whatever
    /// an integration keeps in `metadata`.
    /// 
    /// A received submission is a record of what somebody sent, so under
    /// submission_edit = 'status_only' (the default) those two are the only
    /// columns that may move. A patch that would alter the submitted data, its
    /// form or its timestamp is refused with 403, and the message names the
    /// columns it refused. A patch that merely echoes the stored value back is not
    /// a change and passes, so a client that PUTs the whole row still works.
    /// 
    /// `updated_at` moves with the triage, which makes it evidence about the
    /// handling and never about the submitted values. And if the point is to get a
    /// lead out of the inbox rather than out of the database, this is the route
    /// for it: set `status` to `archived` here instead of reaching for the delete,
    /// which is permanent and has no undo.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - data: Any (optional)
    ///   - formId: String (optional)
    ///   - formSlug: String (optional)
    ///   - metadata: Any (optional)
    ///   - source: String (optional)
    ///   - status: RevenexxEnums.FormSubmissionStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsSubmissionsUpdate(
        id: String,
        data: Any? = nil,
        formId: String? = nil,
        formSlug: String? = nil,
        metadata: Any? = nil,
        source: String? = nil,
        status: RevenexxEnums.FormSubmissionStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/submissions/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "data": data,
            "form_id": formId,
            "form_slug": formSlug,
            "metadata": metadata,
            "source": source,
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
    /// The enums this app publishes, so a client can discover them instead of
    /// holding a copy. Names: form-statuses, submission-statuses.
    /// 
    /// An entry carries the three things a menu needs — the `name` a URL is
    /// built from, the human `title`, and a `description` of what the set decides
    /// — and deliberately NOT the values. Enough to build a menu, not enough to
    /// fill a select: `GET /forms/vocabularies/{name}` is the call for that, and a
    /// client holding the qualified pair 'forms.<name>' builds that URL from the
    /// pair alone, which is what makes reading this index worth more than
    /// hard-coding two names.
    /// 
    /// Both `title` and `description` come back either as a plain string or as a
    /// locale map keyed by language tag; read the tag you want and fall back to
    /// `en`.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.FormsVocabularyIndex
    ///
    open func formsVocabulariesList(
    ) async throws -> RevenexxModels.FormsVocabularyIndex {
        let apiPath: String = "/v1/forms/vocabularies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.FormsVocabularyIndex = { response in
            return RevenexxModels.FormsVocabularyIndex.from(map: response as! [String: Any])
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
    /// One vocabulary WITH its values: every value the column permits, each
    /// carrying the `key` the database stores, the `title` and `description` a
    /// human reads, a semantic badge `tone`, and a `final` flag for the values
    /// that end the lifecycle. This is the call that fills a select or renders a
    /// status badge. Names: form-statuses, submission-statuses.
    /// 
    /// The values are read out of the column's CHECK constraint, so the served set
    /// IS the enforced set and the two cannot drift — a value added to the
    /// constraint appears here even before anyone labels it, titled from its own
    /// key and falling back to `default_tone` for its badge. That is the whole
    /// reason to come here rather than hard-code three statuses in a UI.
    /// 
    /// Values come back in constraint order, which is lifecycle order, and
    /// therefore the order a select should offer them in. `closed` says the set is
    /// exhaustive: there is no value outside it this API will accept. `title` and
    /// `description` are each either a plain string or a locale map keyed by
    /// language tag — read the tag you want and fall back to `en` — and a
    /// value nobody has translated is a bare string rather than an error.
    ///
    /// - Parameters:
    ///   - name: RevenexxEnums.FormsVocabulariesGetName
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsVocabulariesGet(
        name: RevenexxEnums.FormsVocabulariesGetName
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/vocabularies/{name}"
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
    /// Deleting a form deletes every submission it ever received.
    /// 
    /// `submissions.form_id` is ON DELETE CASCADE — the one foreign key on this
    /// app's tables — so the inbox goes with the form, in the database,
    /// permanently. Nothing is archived on the way out, no event is emitted for
    /// the submissions that vanish, and there is no soft delete in this app to
    /// recover them from. A submission is an end user's data, which is why this is
    /// the first sentence rather than a footnote.
    /// 
    /// That is what the tenant setting form_delete_policy (block | archive |
    /// cascade, default 'block') stands in front of: REFUSE with 409 and the
    /// count, ARCHIVE the form and keep everything, or CASCADE on purpose. A form
    /// with no submissions always deletes, under every policy.
    /// 
    /// That setting is the one in this app with ONE value for the whole tenant.
    /// The other six are per-market, because what they decide is market-local;
    /// this one is not, so `X-Revenexx-Market` does not change the answer this
    /// route gives. A market that could set 'cascade' for itself would be deleting
    /// leads that belong to markets which had said 'block'.
    /// 
    /// Both the 409 body and the 200 body carry `submissions`, the number of rows
    /// at stake. It counts the form's WHOLE inbox — every market, not the share
    /// belonging to the one a request names — because that is what the cascade
    /// takes. It is the only figure a merchant has to judge this by, so read it
    /// before allowing the cascade, and `GET /v1/forms/submissions?form_id=…` is
    /// how to see what they are first.
    /// 
    /// The policy is a guard on THIS route, not a database constraint: the cascade
    /// is what the database does on its own, and a client that removes the row by
    /// some other path gets it with nothing in front of it.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/{id}"
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
    /// The whole form: `definition` — the flat FormKit node array the storefront
    /// renders verbatim — plus `settings`, `status` and `slug`.
    /// 
    /// This is the route for an id you are already holding: a submission's
    /// `form_id`, a row the Cockpit list handed you. A storefront resolving a PAGE
    /// does not come here, because it has a slug and not an id — `GET
    /// /v1/forms?slug=contact&status=live&limit=1` is the call that answers that,
    /// and the `status` filter is what keeps a half-built form off a live page.
    /// There is no filtering on this route at all: a `draft` form comes back
    /// exactly like a published one, so a caller that must not render a draft has
    /// to check `status` itself.
    /// 
    /// Nothing is folded in on the way out. The `definition` is returned in the
    /// language it was authored in — the per-form `i18n` overlay is applied by
    /// the storefront BFF, not by this API — and the submissions the form has
    /// collected are neither included nor counted here. The inbox for one form is
    /// `GET /v1/forms/submissions?form_id=…`, and it is worth asking for before
    /// a delete: see `DELETE /v1/forms/{id}`.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/{id}"
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
    /// A partial update over everything a create may set — `definition`,
    /// `settings`, `status`, `name`, `slug`, `metadata` — where an omitted field
    /// keeps the value it has. It is the write behind the Form Builder's save, and
    /// equally behind the one-field change that publishes a form by moving
    /// `status` from `draft` to `live`. `updated_at` is stamped on every call, so
    /// it is the column an editor sorts by.
    /// 
    /// The same field ceiling applies as on the create, or a form would simply
    /// grow past it later: the tenant's `max_form_fields` is counted over the
    /// nodes of the NEW `definition` that carry a non-empty `name`, and a
    /// definition above it is refused with 422 rather than stored truncated.
    /// 
    /// Moving `slug` is the edit to think about twice. It is unique per tenant, so
    /// a rename onto a slug another form holds is a 409 — but it is the rename
    /// that SUCCEEDS that changes behaviour, because the slug is how a storefront
    /// page resolves this form: change it and the page naming the old one resolves
    /// nothing. The submissions already collected are unaffected either way; each
    /// keeps the slug it arrived under in its own `form_slug`, which is exactly
    /// what that copy is for.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - definition: [Any] (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - settings: Any (optional)
    ///   - slug: String (optional)
    ///   - status: RevenexxEnums.FormStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func formsUpdate(
        id: String,
        definition: [Any]? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        settings: Any? = nil,
        slug: String? = nil,
        status: RevenexxEnums.FormStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/forms/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "definition": definition,
            "metadata": metadata,
            "name": name,
            "settings": settings,
            "slug": slug,
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


}