import Foundation
import JSONCodable
import RevenexxEnums

/// Creates the contact (system of record) and mirrors it as a platform user (status defaults to invited).
open class ContactCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case first_name = "first_name"
        case is_primary = "is_primary"
        case job_title = "job_title"
        case last_name = "last_name"
        case locale = "locale"
        case order_approval_limit = "order_approval_limit"
        case organization_id = "organization_id"
        case phone = "phone"
        case registration_status = "registration_status"
        case role = "role"
        case status = "status"
    }

    /// Login identity and the unique key of a person within the tenant. Changing it changes the platform login with it. Two people at the same company therefore need two addresses — a shared purchasing mailbox is one contact, not several.
    public let email: String
    /// Given name. Optional: an ERP import often has only a mailbox.
    public let first_name: String?
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
    /// The company this person belongs to. NULL is a legitimate state, not a defect: a standalone buyer with no company behind them. Deleting the organization sets this null and keeps the person. Membership is mirrored to the platform team.
    public let organization_id: String?
    /// Direct number of this person, as somebody typed it — free text, no format is enforced or normalized. E.164 is what an integration should send.
    public let phone: String?
    /// Where this person's own application stands: 'approved' (the default, and what an open store creates), 'pending' while a merchant has yet to decide, 'rejected' once they declined. Only the approve/reject routes move it; it is ignored on an ordinary update. On CREATE only, and only to file the contact as an application: 'pending' creates the platform user disabled and routes the contact through approve/reject. Ignored on update.
    public let registration_status: RevenexxEnums.ContactCreateRequestRegistrationStatus?
    /// The person's role INSIDE its organization, and the only thing permissions are derived from. One of the tenant's own roles (GET /customers/roles); a tenant that never edited the ledger has viewer, requester, buyer, approver, admin. Also the team role on the platform mirror. There is no global role — the same person in two companies is two contacts. A tenant that never edited the ledger has viewer, requester, buyer, approver, admin; a create without a role gets the one flagged as default, and a role the tenant does not keep is a 400.
    public let role: String?
    /// Whether this person may act: 'invited' has been created but has not accepted, 'active' works, 'blocked' cannot log in. A create through the API defaults to 'invited'; a self-registration in an open store lands 'active'. Default 'invited' on create.
    public let status: RevenexxEnums.ContactStatus?

    init(
        email: String,
        first_name: String?,
        is_primary: Bool?,
        job_title: String?,
        last_name: String?,
        locale: String?,
        order_approval_limit: Double?,
        organization_id: String?,
        phone: String?,
        registration_status: RevenexxEnums.ContactCreateRequestRegistrationStatus?,
        role: String?,
        status: RevenexxEnums.ContactStatus?
    ) {
        self.email = email
        self.first_name = first_name
        self.is_primary = is_primary
        self.job_title = job_title
        self.last_name = last_name
        self.locale = locale
        self.order_approval_limit = order_approval_limit
        self.organization_id = organization_id
        self.phone = phone
        self.registration_status = registration_status
        self.role = role
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decode(String.self, forKey: .email)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.is_primary = try container.decodeIfPresent(Bool.self, forKey: .is_primary)
        self.job_title = try container.decodeIfPresent(String.self, forKey: .job_title)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.order_approval_limit = try container.decodeIfPresent(Double.self, forKey: .order_approval_limit)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        if let registration_statusString = try container.decodeIfPresent(String.self, forKey: .registration_status) {
            self.registration_status = RevenexxEnums.ContactCreateRequestRegistrationStatus(rawValue: registration_statusString)
        } else {
            self.registration_status = nil
        }
        self.role = try container.decodeIfPresent(String.self, forKey: .role)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.ContactStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
        try container.encodeIfPresent(first_name, forKey: .first_name)
        try container.encodeIfPresent(is_primary, forKey: .is_primary)
        try container.encodeIfPresent(job_title, forKey: .job_title)
        try container.encodeIfPresent(last_name, forKey: .last_name)
        try container.encodeIfPresent(locale, forKey: .locale)
        try container.encodeIfPresent(order_approval_limit, forKey: .order_approval_limit)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(registration_status?.rawValue, forKey: .registration_status)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "email": email as Any,
            "first_name": first_name as Any,
            "is_primary": is_primary as Any,
            "job_title": job_title as Any,
            "last_name": last_name as Any,
            "locale": locale as Any,
            "order_approval_limit": order_approval_limit as Any,
            "organization_id": organization_id as Any,
            "phone": phone as Any,
            "registration_status": registration_status?.rawValue as Any,
            "role": role as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ContactCreateRequest {
        return ContactCreateRequest(
            email: map["email"] as! String,
            first_name: map["first_name"] as? String,
            is_primary: map["is_primary"] as? Bool,
            job_title: map["job_title"] as? String,
            last_name: map["last_name"] as? String,
            locale: map["locale"] as? String,
            order_approval_limit: map["order_approval_limit"] as? Double,
            organization_id: map["organization_id"] as? String,
            phone: map["phone"] as? String,
            registration_status: map["registration_status"] as? String != nil ? ContactCreateRequestRegistrationStatus(rawValue: map["registration_status"] as! String) : nil,
            role: map["role"] as? String,
            status: map["status"] as? String != nil ? ContactStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
