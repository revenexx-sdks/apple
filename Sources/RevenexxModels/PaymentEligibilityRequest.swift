import Foundation
import JSONCodable

/// The buyer context — restriction dimensions are ANDed, entries within a dimension ORed, empty = unrestricted.
open class PaymentEligibilityRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case country = "country"
        case currency = "currency"
    }

    /// The order amount the order-value bounds are checked against and the percentage fees are computed from. Defaults to 0, which excludes every method carrying a minimum. Nothing is written, so the ledger's own amount bound does not apply here.
    public let amount: Double?
    /// The buyer's ISO 3166-1 alpha-2 country code. A method restricted to countries is excluded without it — an unknown buyer sees only the unrestricted methods, which is the safe default and not a bug.
    public let country: String?
    /// ISO 4217 code the amount is in, echoed onto every computed fee. Defaults to EUR. This app does no conversion: the fee comes back in the currency it was asked with.
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
