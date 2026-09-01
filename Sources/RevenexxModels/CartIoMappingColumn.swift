import Foundation
import JSONCodable

/// 
open class CartIoMappingColumn: Codable {

    enum CodingKeys: String, CodingKey {
        case from = "from"
        case to = "to"
    }

    /// The cart or line field, spelled as this app spells it — one of the canonical column names.
    public let from: String
    /// What that field is called on the outside: the CSV header, or the JSON key of the system on the other end.
    public let to: String

    init(
        from: String,
        to: String
    ) {
        self.from = from
        self.to = to
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.from = try container.decode(String.self, forKey: .from)
        self.to = try container.decode(String.self, forKey: .to)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
    }

    public func toMap() -> [String: Any] {
        return [
            "from": from as Any,
            "to": to as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartIoMappingColumn {
        return CartIoMappingColumn(
            from: map["from"] as! String,
            to: map["to"] as! String
        )
    }
}
