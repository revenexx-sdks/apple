import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class AuthRegisterResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case approval_required = "approval_required"
        case contact = "contact"
        case registration_status = "registration_status"
        case user_id = "user_id"
        case verification_sent = "verification_sent"
        case welcome_sent = "welcome_sent"
    }

    /// True when the tenant runs registration_mode='approval_required' — do NOT log the buyer in.
    public let approval_required: Bool?
    /// The stored customer record — this app is its system of record.
    public let contact: Contact?
    /// 'pending' means the login is disabled until a merchant approves.
    public let registration_status: RevenexxEnums.RegistrationStatus?
    /// The platform user that was created. Keep it: logout, /auth/me and the recovery confirm all take it.
    public let user_id: String?
    /// Whether an address confirmation went out. True only when the tenant's `email_verification` asks for one on registration, the registration is a finished account rather than an application, and `verification_url` was supplied.
    public let verification_sent: Bool?
    /// Whether the tenant's welcome mail went out. Best effort on purpose: the account exists either way, and a registration is not undone because a message service was unreachable. False for an APPLICATION, which is not an account yet and is announced by `registration.submitted` instead.
    public let welcome_sent: Bool?

    init(
        approval_required: Bool?,
        contact: Contact?,
        registration_status: RevenexxEnums.RegistrationStatus?,
        user_id: String?,
        verification_sent: Bool?,
        welcome_sent: Bool?
    ) {
        self.approval_required = approval_required
        self.contact = contact
        self.registration_status = registration_status
        self.user_id = user_id
        self.verification_sent = verification_sent
        self.welcome_sent = welcome_sent
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.approval_required = try container.decodeIfPresent(Bool.self, forKey: .approval_required)
        self.contact = try container.decodeIfPresent(Contact.self, forKey: .contact)
        if let registration_statusString = try container.decodeIfPresent(String.self, forKey: .registration_status) {
            self.registration_status = RevenexxEnums.RegistrationStatus(rawValue: registration_statusString)
        } else {
            self.registration_status = nil
        }
        self.user_id = try container.decodeIfPresent(String.self, forKey: .user_id)
        self.verification_sent = try container.decodeIfPresent(Bool.self, forKey: .verification_sent)
        self.welcome_sent = try container.decodeIfPresent(Bool.self, forKey: .welcome_sent)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(approval_required, forKey: .approval_required)
        try container.encodeIfPresent(contact, forKey: .contact)
        try container.encodeIfPresent(registration_status?.rawValue, forKey: .registration_status)
        try container.encodeIfPresent(user_id, forKey: .user_id)
        try container.encodeIfPresent(verification_sent, forKey: .verification_sent)
        try container.encodeIfPresent(welcome_sent, forKey: .welcome_sent)
    }

    public func toMap() -> [String: Any] {
        return [
            "approval_required": approval_required as Any,
            "contact": contact?.toMap() as Any,
            "registration_status": registration_status?.rawValue as Any,
            "user_id": user_id as Any,
            "verification_sent": verification_sent as Any,
            "welcome_sent": welcome_sent as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthRegisterResponse {
        return AuthRegisterResponse(
            approval_required: map["approval_required"] as? Bool,
            contact: Contact.from(map: map["contact"] as! [String: Any]),
            registration_status: map["registration_status"] as? String != nil ? RegistrationStatus(rawValue: map["registration_status"] as! String) : nil,
            user_id: map["user_id"] as? String,
            verification_sent: map["verification_sent"] as? Bool,
            welcome_sent: map["welcome_sent"] as? Bool
        )
    }
}
