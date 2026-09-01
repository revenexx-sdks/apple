import Foundation
import JSONCodable

/// 
open class AuthRegisterRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case first_name = "first_name"
        case last_name = "last_name"
        case locale = "locale"
        case organization_id = "organization_id"
        case organization_name = "organization_name"
        case password = "password"
        case url = "url"
        case vat_id = "vat_id"
        case verification_url = "verification_url"
    }

    /// The buyer's address. It becomes the login AND the unique key of the contact, so a second registration with it is a 409 — including while the first one is still waiting for approval.
    public let email: String
    /// Given name. Optional: an ERP import often has only a mailbox.
    public let first_name: String?
    /// Family name. Optional for the same reason.
    public let last_name: String?
    /// The language this person is written to in — BCP 47, and one of the store's configured locales. Null falls back to the store default. One of the store's own locales, or the call is a 400.
    public let locale: String?
    /// JOIN an existing company — the invite shape. Neither b2b_registration_enabled nor b2c_registration_enabled applies to it.
    public let organization_id: String?
    /// FOUND a new company, with this contact as its admin. This is what makes the registration a B2B one; leaving it out registers a standalone buyer.
    public let organization_name: String?
    /// The password the buyer chooses. It is hashed by the identity service at this moment and never travels again: an approval later enables the account, it does not issue a new credential.
    public let password: String
    /// Where the welcome mail's button points — the buyer's first stop in this shop. Absent, the mail still goes out and simply carries no button. Ignored when the registration is an APPLICATION: there is no account to send anybody to yet.
    public let url: String?
    /// VAT identification number (USt-IdNr. in Germany) — the closest thing a B2B buyer has to a legal identity. Validated against the EU VIES service when the tenant's `organization_vat_id_required` setting is on, and stored verbatim otherwise, including for buyers outside the EU. Required when the tenant's `organization_vat_id_required` is on, and checked BEFORE the company is created so a bad one leaves no half-founded organization behind.
    public let vat_id: String?
    /// Where the address-confirmation link points, when the tenant's `email_verification` asks for one on registration. `userId`, `secret` and `expire` are appended, and `PUT /customers/auth/verification` takes the first two. Without it the registration still succeeds and `verification_sent` is false — this app cannot invent a storefront URL, and a link pointing nowhere is worse than none.
    public let verification_url: String?

    init(
        email: String,
        first_name: String?,
        last_name: String?,
        locale: String?,
        organization_id: String?,
        organization_name: String?,
        password: String,
        url: String?,
        vat_id: String?,
        verification_url: String?
    ) {
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.locale = locale
        self.organization_id = organization_id
        self.organization_name = organization_name
        self.password = password
        self.url = url
        self.vat_id = vat_id
        self.verification_url = verification_url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decode(String.self, forKey: .email)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.organization_name = try container.decodeIfPresent(String.self, forKey: .organization_name)
        self.password = try container.decode(String.self, forKey: .password)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.vat_id = try container.decodeIfPresent(String.self, forKey: .vat_id)
        self.verification_url = try container.decodeIfPresent(String.self, forKey: .verification_url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
        try container.encodeIfPresent(first_name, forKey: .first_name)
        try container.encodeIfPresent(last_name, forKey: .last_name)
        try container.encodeIfPresent(locale, forKey: .locale)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(organization_name, forKey: .organization_name)
        try container.encode(password, forKey: .password)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(vat_id, forKey: .vat_id)
        try container.encodeIfPresent(verification_url, forKey: .verification_url)
    }

    public func toMap() -> [String: Any] {
        return [
            "email": email as Any,
            "first_name": first_name as Any,
            "last_name": last_name as Any,
            "locale": locale as Any,
            "organization_id": organization_id as Any,
            "organization_name": organization_name as Any,
            "password": password as Any,
            "url": url as Any,
            "vat_id": vat_id as Any,
            "verification_url": verification_url as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AuthRegisterRequest {
        return AuthRegisterRequest(
            email: map["email"] as! String,
            first_name: map["first_name"] as? String,
            last_name: map["last_name"] as? String,
            locale: map["locale"] as? String,
            organization_id: map["organization_id"] as? String,
            organization_name: map["organization_name"] as? String,
            password: map["password"] as! String,
            url: map["url"] as? String,
            vat_id: map["vat_id"] as? String,
            verification_url: map["verification_url"] as? String
        )
    }
}
