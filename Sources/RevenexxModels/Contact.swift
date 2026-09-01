import Foundation
import JSONCodable
import RevenexxEnums

/// A PERSON, and the unit that logs in: one platform user, one email, one role inside its organization. A contact without an organization is a standalone buyer, not an error.
open class Contact: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case email = "email"
        case external_user_id = "external_user_id"
        case first_name = "first_name"
        case id = "id"
        case is_primary = "is_primary"
        case job_title = "job_title"
        case last_name = "last_name"
        case locale = "locale"
        case order_approval_limit = "order_approval_limit"
        case organization_id = "organization_id"
        case phone = "phone"
        case registration_decided_at = "registration_decided_at"
        case registration_decided_by = "registration_decided_by"
        case registration_reason = "registration_reason"
        case registration_status = "registration_status"
        case role = "role"
        case status = "status"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// When this person record was created in this app.
    public let created_at: String?
    /// Login identity and the unique key of a person within the tenant. Changing it changes the platform login with it. Two people at the same company therefore need two addresses — a shared purchasing mailbox is one contact, not several.
    public let email: String?
    /// Id of the platform USER this contact is mirrored as — the account that actually holds the password and the sessions. Written by the mirror and ignored on every write a caller sends.
    public let external_user_id: String?
    /// Given name. Optional: an ERP import often has only a mailbox.
    public let first_name: String?
    /// Primary key of the person record. What the timeline, the permission routes and the principal resolution all name.
    public let id: String?
    /// The main contact of its organization — who a merchant calls first. At most one per company is the intent; the tenant's `primary_contact_required` setting decides whether the last one may be demoted or deleted.
    public let is_primary: Bool?
    /// What this person does at the company — free text on purpose, because it is a title and not a grant. The permission ladder is `role`; overloading a job title with authority silently un-grants everyone the day the ledger is enforced.
    public let job_title: String?
    /// Family name. Optional for the same reason.
    public let last_name: String?
    /// The language this person is written to in — BCP 47, and one of the store's configured locales. Null falls back to the store default.
    public let locale: String?
    /// Amount ceiling for this person, in the market's currency: with the `orders.approve` permission it is the most they may sign off. Null means no ceiling. An amount, never a grant — the grant comes from the role.
    public let order_approval_limit: Double?
    /// The company this person belongs to. NULL is a legitimate state, not a defect: a standalone buyer with no company behind them. Deleting the organization sets this null and keeps the person.
    public let organization_id: String?
    /// Direct number of this person, as somebody typed it — free text, no format is enforced or normalized. E.164 is what an integration should send.
    public let phone: String?
    /// When a merchant approved or rejected the application. Null while nobody has decided.
    public let registration_decided_at: String?
    /// Who decided — free text as the deciding client supplied it (an operator id or an email address), not a resolvable user reference.
    public let registration_decided_by: String?
    /// Why the application was declined. Always recorded here; whether the APPLICANT is ever told it is the tenant's `registration_reason_disclosed` setting, because that is a legal decision and not a template one.
    public let registration_reason: String?
    /// Where this person's own application stands: 'approved' (the default, and what an open store creates), 'pending' while a merchant has yet to decide, 'rejected' once they declined. Only the approve/reject routes move it; it is ignored on an ordinary update.
    public let registration_status: RevenexxEnums.ContactRegistrationStatus?
    /// The person's role INSIDE its organization, and the only thing permissions are derived from. One of the tenant's own roles (GET /customers/roles); a tenant that never edited the ledger has viewer, requester, buyer, approver, admin. Also the team role on the platform mirror. There is no global role — the same person in two companies is two contacts.
    public let role: String?
    /// Whether this person may act: 'invited' has been created but has not accepted, 'active' works, 'blocked' cannot log in. A create through the API defaults to 'invited'; a self-registration in an open store lands 'active'.
    public let status: RevenexxEnums.ContactStatus?
    /// The tenant this row belongs to — the store slug, not an id. Set by the platform from the authenticated context, never by a caller; a write that carries it is ignored, and no request can read another tenant's rows by sending a different one.
    public let tenant_id: String?
    /// When any column of this row last changed.
    public let updated_at: String?

    init(
        created_at: String?,
        email: String?,
        external_user_id: String?,
        first_name: String?,
        id: String?,
        is_primary: Bool?,
        job_title: String?,
        last_name: String?,
        locale: String?,
        order_approval_limit: Double?,
        organization_id: String?,
        phone: String?,
        registration_decided_at: String?,
        registration_decided_by: String?,
        registration_reason: String?,
        registration_status: RevenexxEnums.ContactRegistrationStatus?,
        role: String?,
        status: RevenexxEnums.ContactStatus?,
        tenant_id: String?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.email = email
        self.external_user_id = external_user_id
        self.first_name = first_name
        self.id = id
        self.is_primary = is_primary
        self.job_title = job_title
        self.last_name = last_name
        self.locale = locale
        self.order_approval_limit = order_approval_limit
        self.organization_id = organization_id
        self.phone = phone
        self.registration_decided_at = registration_decided_at
        self.registration_decided_by = registration_decided_by
        self.registration_reason = registration_reason
        self.registration_status = registration_status
        self.role = role
        self.status = status
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.external_user_id = try container.decodeIfPresent(String.self, forKey: .external_user_id)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_primary = try container.decodeIfPresent(Bool.self, forKey: .is_primary)
        self.job_title = try container.decodeIfPresent(String.self, forKey: .job_title)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.order_approval_limit = try container.decodeIfPresent(Double.self, forKey: .order_approval_limit)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.registration_decided_at = try container.decodeIfPresent(String.self, forKey: .registration_decided_at)
        self.registration_decided_by = try container.decodeIfPresent(String.self, forKey: .registration_decided_by)
        self.registration_reason = try container.decodeIfPresent(String.self, forKey: .registration_reason)
        if let registration_statusString = try container.decodeIfPresent(String.self, forKey: .registration_status) {
            self.registration_status = RevenexxEnums.ContactRegistrationStatus(rawValue: registration_statusString)
        } else {
            self.registration_status = nil
        }
        self.role = try container.decodeIfPresent(String.self, forKey: .role)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.ContactStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(external_user_id, forKey: .external_user_id)
        try container.encodeIfPresent(first_name, forKey: .first_name)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_primary, forKey: .is_primary)
        try container.encodeIfPresent(job_title, forKey: .job_title)
        try container.encodeIfPresent(last_name, forKey: .last_name)
        try container.encodeIfPresent(locale, forKey: .locale)
        try container.encodeIfPresent(order_approval_limit, forKey: .order_approval_limit)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(registration_decided_at, forKey: .registration_decided_at)
        try container.encodeIfPresent(registration_decided_by, forKey: .registration_decided_by)
        try container.encodeIfPresent(registration_reason, forKey: .registration_reason)
        try container.encodeIfPresent(registration_status?.rawValue, forKey: .registration_status)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "email": email as Any,
            "external_user_id": external_user_id as Any,
            "first_name": first_name as Any,
            "id": id as Any,
            "is_primary": is_primary as Any,
            "job_title": job_title as Any,
            "last_name": last_name as Any,
            "locale": locale as Any,
            "order_approval_limit": order_approval_limit as Any,
            "organization_id": organization_id as Any,
            "phone": phone as Any,
            "registration_decided_at": registration_decided_at as Any,
            "registration_decided_by": registration_decided_by as Any,
            "registration_reason": registration_reason as Any,
            "registration_status": registration_status?.rawValue as Any,
            "role": role as Any,
            "status": status?.rawValue as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Contact {
        return Contact(
            created_at: map["created_at"] as? String,
            email: map["email"] as? String,
            external_user_id: map["external_user_id"] as? String,
            first_name: map["first_name"] as? String,
            id: map["id"] as? String,
            is_primary: map["is_primary"] as? Bool,
            job_title: map["job_title"] as? String,
            last_name: map["last_name"] as? String,
            locale: map["locale"] as? String,
            order_approval_limit: map["order_approval_limit"] as? Double,
            organization_id: map["organization_id"] as? String,
            phone: map["phone"] as? String,
            registration_decided_at: map["registration_decided_at"] as? String,
            registration_decided_by: map["registration_decided_by"] as? String,
            registration_reason: map["registration_reason"] as? String,
            registration_status: map["registration_status"] as? String != nil ? ContactRegistrationStatus(rawValue: map["registration_status"] as! String) : nil,
            role: map["role"] as? String,
            status: map["status"] as? String != nil ? ContactStatus(rawValue: map["status"] as! String) : nil,
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
