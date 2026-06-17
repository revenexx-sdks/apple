import Foundation
import JSONCodable

/// MFAFactors
open class MfaFactors: Codable {

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case phone = "phone"
        case recoveryCode = "recoveryCode"
        case totp = "totp"
    }

    /// Can email be used for MFA challenge for this account.
    public let email: Bool
    /// Can phone (SMS) be used for MFA challenge for this account.
    public let phone: Bool
    /// Can recovery code be used for MFA challenge for this account.
    public let recoveryCode: Bool
    /// Can TOTP be used for MFA challenge for this account.
    public let totp: Bool

    init(
        email: Bool,
        phone: Bool,
        recoveryCode: Bool,
        totp: Bool
    ) {
        self.email = email
        self.phone = phone
        self.recoveryCode = recoveryCode
        self.totp = totp
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.email = try container.decode(Bool.self, forKey: .email)
        self.phone = try container.decode(Bool.self, forKey: .phone)
        self.recoveryCode = try container.decode(Bool.self, forKey: .recoveryCode)
        self.totp = try container.decode(Bool.self, forKey: .totp)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(recoveryCode, forKey: .recoveryCode)
        try container.encode(totp, forKey: .totp)
    }

    public func toMap() -> [String: Any] {
        return [
            "email": email as Any,
            "phone": phone as Any,
            "recoveryCode": recoveryCode as Any,
            "totp": totp as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MfaFactors {
        return MfaFactors(
            email: map["email"] as! Bool,
            phone: map["phone"] as! Bool,
            recoveryCode: map["recoveryCode"] as! Bool,
            totp: map["totp"] as! Bool
        )
    }
}
