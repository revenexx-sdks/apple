import Foundation
import JSONCodable

/// User
open class User<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case accessedAt = "accessedAt"
        case email = "email"
        case emailVerification = "emailVerification"
        case hash = "hash"
        case hashOptions = "hashOptions"
        case labels = "labels"
        case mfa = "mfa"
        case name = "name"
        case password = "password"
        case passwordUpdate = "passwordUpdate"
        case phone = "phone"
        case phoneVerification = "phoneVerification"
        case prefs = "prefs"
        case registration = "registration"
        case status = "status"
        case targets = "targets"
    }

    /// User creation date in ISO 8601 format.
    public let createdAt: String
    /// User ID.
    public let id: String
    /// User update date in ISO 8601 format.
    public let updatedAt: String
    /// Most recent access date in ISO 8601 format. This attribute is only updated again after 24 hours.
    public let accessedAt: String
    /// User email address.
    public let email: String
    /// Email verification status.
    public let emailVerification: Bool
    /// Password hashing algorithm.
    public let hash: String?
    /// Password hashing algorithm configuration.
    public let hashOptions: [String: AnyCodable]?
    /// Labels for the user.
    public let labels: [String]
    /// Multi factor authentication status.
    public let mfa: Bool
    /// User name.
    public let name: String
    /// Hashed user password.
    public let password: String?
    /// Password update time in ISO 8601 format.
    public let passwordUpdate: String
    /// User phone number in E.164 format.
    public let phone: String
    /// Phone verification status.
    public let phoneVerification: Bool
    /// User preferences as a key-value object
    public let prefs: Preferences<T>
    /// User registration date in ISO 8601 format.
    public let registration: String
    /// User status. Pass `true` for enabled and `false` for disabled.
    public let status: Bool
    /// A user-owned message receiver. A single user may have multiple e.g. emails, phones, and a browser. Each target is registered with a single provider.
    public let targets: [Target]

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        accessedAt: String,
        email: String,
        emailVerification: Bool,
        hash: String?,
        hashOptions: [String: AnyCodable]?,
        labels: [String],
        mfa: Bool,
        name: String,
        password: String?,
        passwordUpdate: String,
        phone: String,
        phoneVerification: Bool,
        prefs: Preferences<T>,
        registration: String,
        status: Bool,
        targets: [Target]
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.accessedAt = accessedAt
        self.email = email
        self.emailVerification = emailVerification
        self.hash = hash
        self.hashOptions = hashOptions
        self.labels = labels
        self.mfa = mfa
        self.name = name
        self.password = password
        self.passwordUpdate = passwordUpdate
        self.phone = phone
        self.phoneVerification = phoneVerification
        self.prefs = prefs
        self.registration = registration
        self.status = status
        self.targets = targets
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.accessedAt = try container.decode(String.self, forKey: .accessedAt)
        self.email = try container.decode(String.self, forKey: .email)
        self.emailVerification = try container.decode(Bool.self, forKey: .emailVerification)
        self.hash = try container.decodeIfPresent(String.self, forKey: .hash)
        self.hashOptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .hashOptions)
        self.labels = try container.decode([String].self, forKey: .labels)
        self.mfa = try container.decode(Bool.self, forKey: .mfa)
        self.name = try container.decode(String.self, forKey: .name)
        self.password = try container.decodeIfPresent(String.self, forKey: .password)
        self.passwordUpdate = try container.decode(String.self, forKey: .passwordUpdate)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.phoneVerification = try container.decode(Bool.self, forKey: .phoneVerification)
        self.prefs = try container.decode(Preferences<T>.self, forKey: .prefs)
        self.registration = try container.decode(String.self, forKey: .registration)
        self.status = try container.decode(Bool.self, forKey: .status)
        self.targets = try container.decode([Target].self, forKey: .targets)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(accessedAt, forKey: .accessedAt)
        try container.encode(email, forKey: .email)
        try container.encode(emailVerification, forKey: .emailVerification)
        try container.encodeIfPresent(hash, forKey: .hash)
        try container.encodeIfPresent(hashOptions, forKey: .hashOptions)
        try container.encode(labels, forKey: .labels)
        try container.encode(mfa, forKey: .mfa)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(password, forKey: .password)
        try container.encode(passwordUpdate, forKey: .passwordUpdate)
        try container.encode(phone, forKey: .phone)
        try container.encode(phoneVerification, forKey: .phoneVerification)
        try container.encode(prefs, forKey: .prefs)
        try container.encode(registration, forKey: .registration)
        try container.encode(status, forKey: .status)
        try container.encode(targets, forKey: .targets)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "accessedAt": accessedAt as Any,
            "email": email as Any,
            "emailVerification": emailVerification as Any,
            "hash": hash as Any,
            "hashOptions": hashOptions as Any,
            "labels": labels as Any,
            "mfa": mfa as Any,
            "name": name as Any,
            "password": password as Any,
            "passwordUpdate": passwordUpdate as Any,
            "phone": phone as Any,
            "phoneVerification": phoneVerification as Any,
            "prefs": prefs.toMap() as Any,
            "registration": registration as Any,
            "status": status as Any,
            "targets": targets.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> User {
        return User(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            accessedAt: map["accessedAt"] as! String,
            email: map["email"] as! String,
            emailVerification: map["emailVerification"] as! Bool,
            hash: map["hash"] as? String,
            hashOptions: map["hashOptions"] as? [String: AnyCodable],
            labels: map["labels"] as! [String],
            mfa: map["mfa"] as! Bool,
            name: map["name"] as! String,
            password: map["password"] as? String,
            passwordUpdate: map["passwordUpdate"] as! String,
            phone: map["phone"] as! String,
            phoneVerification: map["phoneVerification"] as! Bool,
            prefs: Preferences.from(map: map["prefs"] as! [String: Any]),
            registration: map["registration"] as! String,
            status: map["status"] as! Bool,
            targets: (map["targets"] as! [[String: Any]]).map { Target.from(map: $0) }
        )
    }
}
