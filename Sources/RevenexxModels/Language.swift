import Foundation
import JSONCodable

/// Language
open class Language: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
        case nativeName = "nativeName"
    }

    /// Language two-character ISO 639-1 codes.
    public let code: String
    /// Language name.
    public let name: String
    /// Language native name.
    public let nativeName: String

    init(
        code: String,
        name: String,
        nativeName: String
    ) {
        self.code = code
        self.name = name
        self.nativeName = nativeName
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
        self.nativeName = try container.decode(String.self, forKey: .nativeName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encode(name, forKey: .name)
        try container.encode(nativeName, forKey: .nativeName)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "name": name as Any,
            "nativeName": nativeName as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Language {
        return Language(
            code: map["code"] as! String,
            name: map["name"] as! String,
            nativeName: map["nativeName"] as! String
        )
    }
}
