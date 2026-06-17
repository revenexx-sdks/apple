import Foundation
import JSONCodable

/// AlgoScryptModified
open class AlgoScryptModified: Codable {

    enum CodingKeys: String, CodingKey {
        case salt = "salt"
        case saltSeparator = "saltSeparator"
        case signerKey = "signerKey"
        case type = "type"
    }

    /// Salt used to compute hash.
    public let salt: String
    /// Separator used to compute hash.
    public let saltSeparator: String
    /// Key used to compute hash.
    public let signerKey: String
    /// Algo type.
    public let type: String

    init(
        salt: String,
        saltSeparator: String,
        signerKey: String,
        type: String
    ) {
        self.salt = salt
        self.saltSeparator = saltSeparator
        self.signerKey = signerKey
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.salt = try container.decode(String.self, forKey: .salt)
        self.saltSeparator = try container.decode(String.self, forKey: .saltSeparator)
        self.signerKey = try container.decode(String.self, forKey: .signerKey)
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(salt, forKey: .salt)
        try container.encode(saltSeparator, forKey: .saltSeparator)
        try container.encode(signerKey, forKey: .signerKey)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "salt": salt as Any,
            "saltSeparator": saltSeparator as Any,
            "signerKey": signerKey as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AlgoScryptModified {
        return AlgoScryptModified(
            salt: map["salt"] as! String,
            saltSeparator: map["saltSeparator"] as! String,
            signerKey: map["signerKey"] as! String,
            type: map["type"] as! String
        )
    }
}
