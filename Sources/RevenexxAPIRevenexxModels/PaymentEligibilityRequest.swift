import Foundation
import JSONCodable

/// The buyer context — restriction dimensions are ANDed, entries within a dimension ORed, empty = unrestricted.
open class PaymentEligibilityRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case country = "country"
        case currency = "currency"
    }

    /// Order amount the fees are computed against (default 0).
    public let amount: Double?
    /// Buyer ISO country code — methods with country restrictions need it.
    public let country: String?
    /// ISO 4217 code (default EUR).
    public let currency: String?

    init(
        amount: Double?,
        country: String?,
        currency: String?
    ) {
        self.amount = amount
        self.country = country
        self.currency = currency
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(currency, forKey: .currency)
    }

    public func toMap() -> [String: Any] {
        return [
            "amount": amount as Any,
            "country": country as Any,
            "currency": currency as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentEligibilityRequest {
        return PaymentEligibilityRequest(
            amount: map["amount"] as? Double,
            country: map["country"] as? String,
            currency: map["currency"] as? String
        )
    }
}
