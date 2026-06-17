import Foundation
import JSONCodable

/// Continent
open class Continent: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
    }

    /// Continent two letter code.
    public let code: String
    /// Continent name.
    public let name: String

    init(
        code: String,
        name: String
    ) {
        self.code = code
        self.name = name
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encode(name, forKey: .name)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "name": name as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Continent {
        return Continent(
            code: map["code"] as! String,
            name: map["name"] as! String
        )
    }
}
