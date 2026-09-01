import Foundation
import JSONCodable

/// Every field is optional — the buyer, the organization and the positions all come from the list.
open class OrderListToOrderRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case customer_order_number = "customer_order_number"
    }

    /// ISO 4217 code. Omit to let the orders app apply the market default.
    public let currency: String?
    /// The BUYER's own order or purchase-order number, forwarded to the orders app verbatim. Free text and never generated here: it exists so the paperwork can carry the number the buyer's accounts payable will look for.
    public let customer_order_number: String?

    init(
        currency: String?,
        customer_order_number: String?
    ) {
        self.currency = currency
        self.customer_order_number = customer_order_number
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.customer_order_number = try container.decodeIfPresent(String.self, forKey: .customer_order_number)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(customer_order_number, forKey: .customer_order_number)
    }

    public func toMap() -> [String: Any] {
        return [
            "currency": currency as Any,
            "customer_order_number": customer_order_number as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListToOrderRequest {
        return OrderListToOrderRequest(
            currency: map["currency"] as? String,
            customer_order_number: map["customer_order_number"] as? String
        )
    }
}
