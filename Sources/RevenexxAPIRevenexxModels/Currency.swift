import Foundation
import JSONCodable

/// Currency
open class Currency: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case decimalDigits = "decimalDigits"
        case name = "name"
        case namePlural = "namePlural"
        case rounding = "rounding"
        case symbol = "symbol"
        case symbolNative = "symbolNative"
    }

    /// Currency code in [ISO 4217-1](http://en.wikipedia.org/wiki/ISO_4217) three-character format.
    public let code: String
    /// Number of decimal digits.
    public let decimalDigits: Int
    /// Currency name.
    public let name: String
    /// Currency plural name
    public let namePlural: String
    /// Currency digit rounding.
    public let rounding: Double
    /// Currency symbol.
    public let symbol: String
    /// Currency native symbol.
    public let symbolNative: String

    init(
        code: String,
        decimalDigits: Int,
        name: String,
        namePlural: String,
        rounding: Double,
        symbol: String,
        symbolNative: String
    ) {
        self.code = code
        self.decimalDigits = decimalDigits
        self.name = name
        self.namePlural = namePlural
        self.rounding = rounding
        self.symbol = symbol
        self.symbolNative = symbolNative
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.decimalDigits = try container.decode(Int.self, forKey: .decimalDigits)
        self.name = try container.decode(String.self, forKey: .name)
        self.namePlural = try container.decode(String.self, forKey: .namePlural)
        self.rounding = try container.decode(Double.self, forKey: .rounding)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.symbolNative = try container.decode(String.self, forKey: .symbolNative)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encode(decimalDigits, forKey: .decimalDigits)
        try container.encode(name, forKey: .name)
        try container.encode(namePlural, forKey: .namePlural)
        try container.encode(rounding, forKey: .rounding)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(symbolNative, forKey: .symbolNative)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "decimalDigits": decimalDigits as Any,
            "name": name as Any,
            "namePlural": namePlural as Any,
            "rounding": rounding as Any,
            "symbol": symbol as Any,
            "symbolNative": symbolNative as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Currency {
        return Currency(
            code: map["code"] as! String,
            decimalDigits: map["decimalDigits"] as! Int,
            name: map["name"] as! String,
            namePlural: map["namePlural"] as! String,
            rounding: map["rounding"] as! Double,
            symbol: map["symbol"] as! String,
            symbolNative: map["symbolNative"] as! String
        )
    }
}
