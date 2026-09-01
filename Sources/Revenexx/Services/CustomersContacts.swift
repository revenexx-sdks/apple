import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The PEOPLE inside the buying companies, and everything that happens to one: the contact rows, the activity timeline (`contact_events` — a call, a visit, a note, plus this app's own registration decisions), the approve/reject calls that settle a pending registration, and the effective permissions a contact ends up holding. A contact is the unit that logs in — one platform user, one email, one role inside its organization — and a contact without an organization is a standalone buyer, not an error. Both routes that write a timeline entry are here, including the one addressed by an organization id, because every row is keyed by a contact.
open class CustomersContacts: Service {

    ///
    /// A contact event is one entry on a customer's timeline: an activity somebody
    /// logged (a call, a visit, a meeting, a note) or a registration decision this
    /// app recorded itself. Every entry is keyed by a CONTACT and stamped with the
    /// organization derived from that contact, so a company's history is one
    /// indexed read rather than a join. Append-only — there is no update and no
    /// delete, which is what makes it usable as evidence. The activity feed,
    /// filtered by whichever column the question needs: `contact_id` for one
    /// person, `organization_id` for a whole company, `kind` for one type of
    /// activity. `kind: "system"` is this app's own registration decision trail
    /// (`registration.submitted` / `.approved` / `.rejected`), and no caller may
    /// file one of those. Paged with `limit`/`offset`/`order`; newest first is
    /// `order=occurred_at.desc`.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - contactId: String (optional)
    ///   - organizationId: String (optional)
    ///   - kind: String (optional)
    ///   - name: String (optional)
    ///   - subject: String (optional)
    ///   - actor: String (optional)
    ///   - occurredAt: String (optional)
    ///   - createdAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersContactEventsList(
        id: String? = nil,
        contactId: String? = nil,
        organizationId: String? = nil,
        kind: String? = nil,
        name: String? = nil,
        subject: String? = nil,
        actor: String? = nil,
        occurredAt: String? = nil,
        createdAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/contact_events"

        let apiParams: [String: Any?] = [
            "id": id,
            "contact_id": contactId,
            "organization_id": organizationId,
            "kind": kind,
            "name": name,
            "subject": subject,
            "actor": actor,
            "occurred_at": occurredAt,
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
    /// A contact event is one entry on a customer's timeline: an activity somebody
    /// logged (a call, a visit, a meeting, a note) or a registration decision this
    /// app recorded itself. Every entry is keyed by a CONTACT and stamped with the
    /// organization derived from that contact, so a company's history is one
    /// indexed read rather than a join. Append-only — there is no update and no
    /// delete, which is what makes it usable as evidence. One timeline entry by
    /// id, as it was written. Entries are never edited, so what this answers is
    /// what was recorded at the time.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactEventsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contact_events/{id}"
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
    /// A contact is a PERSON, and the unit that logs in: one platform user, one
    /// email address, one role held inside its organization. A contact without an
    /// organization is a standalone buyer rather than an error, and two people at
    /// the same company are two contacts sharing an `organization_id`. The people
    /// list, and the read behind an approval queue: `registration_status=pending`
    /// is every application waiting for a decision. Every column is a filter —
    /// `external_user_id` in particular is how a storefront turns a platform auth
    /// id back into a customer — and the page is `limit`/`offset`/`order`.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - organizationId: String (optional)
    ///   - email: String (optional)
    ///   - firstName: String (optional)
    ///   - lastName: String (optional)
    ///   - phone: String (optional)
    ///   - jobTitle: String (optional)
    ///   - role: String (optional)
    ///   - status: RevenexxEnums.Status (optional)
    ///   - orderApprovalLimit: Double (optional)
    ///   - registrationStatus: RevenexxEnums.RegistrationStatus (optional)
    ///   - registrationDecidedAt: String (optional)
    ///   - registrationDecidedBy: String (optional)
    ///   - registrationReason: String (optional)
    ///   - locale: String (optional)
    ///   - isPrimary: Bool (optional)
    ///   - externalUserId: String (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersContactsList(
        id: String? = nil,
        organizationId: String? = nil,
        email: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        phone: String? = nil,
        jobTitle: String? = nil,
        role: String? = nil,
        status: RevenexxEnums.Status? = nil,
        orderApprovalLimit: Double? = nil,
        registrationStatus: RevenexxEnums.RegistrationStatus? = nil,
        registrationDecidedAt: String? = nil,
        registrationDecidedBy: String? = nil,
        registrationReason: String? = nil,
        locale: String? = nil,
        isPrimary: Bool? = nil,
        externalUserId: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/contacts"

        let apiParams: [String: Any?] = [
            "id": id,
            "organization_id": organizationId,
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "phone": phone,
            "job_title": jobTitle,
            "role": role,
            "status": status,
            "order_approval_limit": orderApprovalLimit,
            "registration_status": registrationStatus,
            "registration_decided_at": registrationDecidedAt,
            "registration_decided_by": registrationDecidedBy,
            "registration_reason": registrationReason,
            "locale": locale,
            "is_primary": isPrimary,
            "external_user_id": externalUserId,
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
    /// A contact is a PERSON, and the unit that logs in: one platform user, one
    /// email address, one role held inside its organization. A contact without an
    /// organization is a standalone buyer rather than an error, and two people at
    /// the same company are two contacts sharing an `organization_id`. Creates the
    /// person and their platform login together, so a contact that exists can
    /// always sign in. `role` names one of this tenant's own roles and decides
    /// what they may do; `registration_status` may only be set to `pending` or
    /// `approved` here, because a rejection has to carry a reason and that is the
    /// reject route's job. `email` is the only field a create cannot omit;
    /// everything else is optional or defaulted by the database. Two rows of this
    /// tenant may not share `email` or `external_user_id` (while external_user_id
    /// IS NOT NULL).
    ///
    /// - Parameters:
    ///   - email: String
    ///   - firstName: String (optional)
    ///   - isPrimary: Bool (optional)
    ///   - jobTitle: String (optional)
    ///   - lastName: String (optional)
    ///   - locale: String (optional)
    ///   - orderApprovalLimit: Double (optional)
    ///   - organizationId: String (optional)
    ///   - phone: String (optional)
    ///   - registrationStatus: RevenexxEnums.CustomersContactsCreateRegistrationStatus (optional)
    ///   - role: String (optional)
    ///   - status: RevenexxEnums.ContactStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactsCreate(
        email: String,
        firstName: String? = nil,
        isPrimary: Bool? = nil,
        jobTitle: String? = nil,
        lastName: String? = nil,
        locale: String? = nil,
        orderApprovalLimit: Double? = nil,
        organizationId: String? = nil,
        phone: String? = nil,
        registrationStatus: RevenexxEnums.CustomersContactsCreateRegistrationStatus? = nil,
        role: String? = nil,
        status: RevenexxEnums.ContactStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts"

        let apiParams: [String: Any?] = [
            "email": email,
            "first_name": firstName,
            "is_primary": isPrimary,
            "job_title": jobTitle,
            "last_name": lastName,
            "locale": locale,
            "order_approval_limit": orderApprovalLimit,
            "organization_id": organizationId,
            "phone": phone,
            "registration_status": registrationStatus,
            "role": role,
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
    /// This is how a call, a visit, a meeting, an email or a plain note reaches
    /// one person's timeline. It writes a contact_events row with kind != 'system'
    /// and emits contact_event.created, so an activity travels on the same bus as
    /// a registration decision and a timeline is one query rather than a union.
    /// organization_id is DERIVED from the contact, never taken from the body —
    /// an activity cannot be filed under a company the person does not belong to.
    ///
    /// - Parameters:
    ///   - contactId: String
    ///   - subject: String
    ///   - actor: String (optional)
    ///   - kind: RevenexxEnums.ContactActivityKind (optional)
    ///   - note: String (optional)
    ///   - occurredAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactsEventsCreate(
        contactId: String,
        subject: String,
        actor: String? = nil,
        kind: RevenexxEnums.ContactActivityKind? = nil,
        note: String? = nil,
        occurredAt: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts/{contact_id}/events"
            .replacingOccurrences(of: "{contact_id}", with: contactId)

        let apiParams: [String: Any?] = [
            "actor": actor,
            "kind": kind,
            "note": note,
            "occurred_at": occurredAt,
            "subject": subject
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
    /// Tell somebody they were added to a company. A deliberate act rather than a
    /// side effect of creating the contact: a merchant entering a colleague from a
    /// business card is not always ready to mail them, and "added" and "told" are
    /// different decisions. No secret travels — the platform team membership is
    /// confirmed as it is created, so there is nothing to accept; the message says
    /// "you are in, here is the way in". Unlike the auth mails, a failure here IS
    /// a failure: the identity service sends nothing for this occasion, so this is
    /// the only message the person gets.
    ///
    /// - Parameters:
    ///   - contactId: String
    ///   - url: String
    ///   - invitedBy: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactsInvite(
        contactId: String,
        url: String,
        invitedBy: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts/{contact_id}/invite"
            .replacingOccurrences(of: "{contact_id}", with: contactId)

        let apiParams: [String: Any?] = [
            "invited_by": invitedBy,
            "url": url
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
    /// Computed from contacts.role on every call — the grants are never
    /// persisted, so this always reflects the role the contact holds right now.
    ///
    /// - Parameters:
    ///   - contactId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactsPermissions(
        contactId: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts/{contact_id}/permissions"
            .replacingOccurrences(of: "{contact_id}", with: contactId)

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
    /// Only reachable for a contact whose registration_status is 'pending' or
    /// 'rejected' (approving a rejection reinstates it). Enables the platform user
    /// FIRST — the password the applicant chose at submit time works
    /// immediately, no new credential is issued — then sets
    /// registration_status='approved' and status='active', and un-blocks the
    /// organization this registration itself founded. Approving an
    /// already-approved registration is a no-op that emits nothing, so a retry is
    /// safe. Writes a contact_events row named 'registration.approved'.
    ///
    /// - Parameters:
    ///   - contactId: String
    ///   - decidedBy: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersRegistrationsApprove(
        contactId: String,
        decidedBy: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts/{contact_id}/registration/approve"
            .replacingOccurrences(of: "{contact_id}", with: contactId)

        let apiParams: [String: Any?] = [
            "decided_by": decidedBy
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
    /// Only reachable from 'pending'. Sets registration_status='rejected' and
    /// status='blocked', keeps the platform user in place but disabled — the
    /// email must not fall free for a silent second identity, and the merchant
    /// keeps the record. Delete the contact to remove both. 'reason' is mandatory
    /// and is stored on the contact plus carried in the event payload, so the
    /// applicant can be told why. Rejecting an already-rejected registration is a
    /// no-op. Writes a contact_events row named 'registration.rejected'.
    ///
    /// - Parameters:
    ///   - contactId: String
    ///   - reason: String
    ///   - decidedBy: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersRegistrationsReject(
        contactId: String,
        reason: String,
        decidedBy: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts/{contact_id}/registration/reject"
            .replacingOccurrences(of: "{contact_id}", with: contactId)

        let apiParams: [String: Any?] = [
            "decided_by": decidedBy,
            "reason": reason
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
    /// A contact is a PERSON, and the unit that logs in: one platform user, one
    /// email address, one role held inside its organization. A contact without an
    /// organization is a standalone buyer rather than an error, and two people at
    /// the same company are two contacts sharing an `organization_id`. Removes the
    /// person and their platform login, so they can no longer sign in anywhere.
    /// Their company keeps trading; use `status: "blocked"` instead when the
    /// intent is to stop one person without erasing what they did. Deleting one
    /// takes every `contact_events` and `addresses` row that points at it with it
    /// — the foreign keys decide, not this route.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactsDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts/{id}"
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
    /// A contact is a PERSON, and the unit that logs in: one platform user, one
    /// email address, one role held inside its organization. A contact without an
    /// organization is a standalone buyer rather than an error, and two people at
    /// the same company are two contacts sharing an `organization_id`. One person
    /// by id. What they are ALLOWED to do is not in here: permissions are derived
    /// from `role` at read time and answered by `GET
    /// /customers/contacts/{contact_id}/permissions`.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactsGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts/{id}"
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
    /// A contact is a PERSON, and the unit that logs in: one platform user, one
    /// email address, one role held inside its organization. A contact without an
    /// organization is a standalone buyer rather than an error, and two people at
    /// the same company are two contacts sharing an `organization_id`. A partial
    /// update — send only what changes. `external_user_id` and every
    /// `registration_*` column are ignored: the link to platform auth is
    /// mirror-managed, and registration state is only ever moved by the approve
    /// and reject routes, which record why. Two rows of this tenant may not share
    /// `email` or `external_user_id` (while external_user_id IS NOT NULL).
    ///
    /// - Parameters:
    ///   - id: String
    ///   - email: String (optional)
    ///   - firstName: String (optional)
    ///   - isPrimary: Bool (optional)
    ///   - jobTitle: String (optional)
    ///   - lastName: String (optional)
    ///   - locale: String (optional)
    ///   - orderApprovalLimit: Double (optional)
    ///   - organizationId: String (optional)
    ///   - phone: String (optional)
    ///   - registrationStatus: RevenexxEnums.CustomersContactsCreateRegistrationStatus (optional)
    ///   - role: String (optional)
    ///   - status: RevenexxEnums.ContactStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersContactsUpdate(
        id: String,
        email: String? = nil,
        firstName: String? = nil,
        isPrimary: Bool? = nil,
        jobTitle: String? = nil,
        lastName: String? = nil,
        locale: String? = nil,
        orderApprovalLimit: Double? = nil,
        organizationId: String? = nil,
        phone: String? = nil,
        registrationStatus: RevenexxEnums.CustomersContactsCreateRegistrationStatus? = nil,
        role: String? = nil,
        status: RevenexxEnums.ContactStatus? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/contacts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "email": email,
            "first_name": firstName,
            "is_primary": isPrimary,
            "job_title": jobTitle,
            "last_name": lastName,
            "locale": locale,
            "order_approval_limit": orderApprovalLimit,
            "organization_id": organizationId,
            "phone": phone,
            "registration_status": registrationStatus,
            "role": role,
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
    /// Same row as the contact route, reached from the organization. 'contact_id'
    /// is required and must belong to THIS organization — the picker offering
    /// the contacts is not filtered, so the membership check here is what stops a
    /// call with one company being filed under someone else's person.
    ///
    /// - Parameters:
    ///   - organizationId: String
    ///   - contactId: String
    ///   - subject: String
    ///   - actor: String (optional)
    ///   - kind: RevenexxEnums.ContactActivityKind (optional)
    ///   - note: String (optional)
    ///   - occurredAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersOrganizationsEventsCreate(
        organizationId: String,
        contactId: String,
        subject: String,
        actor: String? = nil,
        kind: RevenexxEnums.ContactActivityKind? = nil,
        note: String? = nil,
        occurredAt: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/organizations/{organization_id}/events"
            .replacingOccurrences(of: "{organization_id}", with: organizationId)

        let apiParams: [String: Any?] = [
            "actor": actor,
            "contact_id": contactId,
            "kind": kind,
            "note": note,
            "occurred_at": occurredAt,
            "subject": subject
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