import Foundation
import JSONCodable

/// Locale
open class Locale: Codable {

    enum CodingKeys: String, CodingKey {
        case continent = "continent"
        case continentCode = "continentCode"
        case country = "country"
        case countryCode = "countryCode"
        case currency = "currency"
        case eu = "eu"
        case ip = "ip"
    }

    /// Continent name. This field support localization.
    public let continent: String
    /// Continent code. A two character continent code &quot;AF&quot; for Africa, &quot;AN&quot; for Antarctica, &quot;AS&quot; for Asia, &quot;EU&quot; for Europe, &quot;NA&quot; for North America, &quot;OC&quot; for Oceania, and &quot;SA&quot; for South America.
    public let continentCode: String
    /// Country name. This field support localization.
    public let country: String
    /// Country code in [ISO 3166-1](http://en.wikipedia.org/wiki/ISO_3166-1) two-character format
    public let countryCode: String
    /// Currency code in [ISO 4217-1](http://en.wikipedia.org/wiki/ISO_4217) three-character format
    public let currency: String
    /// True if country is part of the European Union.
    public let eu: Bool
    /// User IP address.
    public let ip: String

    init(
        continent: String,
        continentCode: String,
        country: String,
        countryCode: String,
        currency: String,
        eu: Bool,
        ip: String
    ) {
        self.continent = continent
        self.continentCode = continentCode
        self.country = country
        self.countryCode = countryCode
        self.currency = currency
        self.eu = eu
        self.ip = ip
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.continent = try container.decode(String.self, forKey: .continent)
        self.continentCode = try container.decode(String.self, forKey: .continentCode)
        self.country = try container.decode(String.self, forKey: .country)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.eu = try container.decode(Bool.self, forKey: .eu)
        self.ip = try container.decode(String.self, forKey: .ip)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(continent, forKey: .continent)
        try container.encode(continentCode, forKey: .continentCode)
        try container.encode(country, forKey: .country)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(currency, forKey: .currency)
        try container.encode(eu, forKey: .eu)
        try container.encode(ip, forKey: .ip)
    }

    public func toMap() -> [String: Any] {
        return [
            "continent": continent as Any,
            "continentCode": continentCode as Any,
            "country": country as Any,
            "countryCode": countryCode as Any,
            "currency": currency as Any,
            "eu": eu as Any,
            "ip": ip as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Locale {
        return Locale(
            continent: map["continent"] as! String,
            continentCode: map["continentCode"] as! String,
            country: map["country"] as! String,
            countryCode: map["countryCode"] as! String,
            currency: map["currency"] as! String,
            eu: map["eu"] as! Bool,
            ip: map["ip"] as! String
        )
    }
}
