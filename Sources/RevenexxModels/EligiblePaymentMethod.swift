import Foundation
import JSONCodable
import RevenexxEnums

/// One method as a checkout should render it: identity, wording, and what it costs this buyer.
open class EligiblePaymentMethod: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case currency = "currency"
        case description = "description"
        case fee = "fee"
        case fee_type = "fee_type"
        case kind = "kind"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case provider = "provider"
    }

    /// The code to send back as `method_code` when the payment is created.
    public let code: String?
    /// The currency `fee` is in — the one the request asked with, echoed.
    public let currency: String?
    /// The merchant's line about this method, to show beside it at checkout.
    public let description: String?
    /// The surcharge this method costs THIS buyer, already computed against the requested amount — a fixed fee as it stands, a percentage resolved into an amount. Not a column: no CHECK bounds it, so none is declared.
    public let fee: Double?
    /// How `fee` was arrived at, for a checkout that wants to show "2 % surcharge" rather than the amount.
    public let fee_type: RevenexxEnums.PaymentFeeType?
    /// Whether choosing this method starts a PSP flow ('psp') or authorizes immediately ('self_managed').
    public let kind: RevenexxEnums.PaymentMethodKind?
    /// Buyer-facing names keyed by language tag, or null when the merchant configured none — then `name` is all there is.
    public let labels: [String: AnyCodable]?
    /// The operator-facing name. Prefer `labels` for anything a buyer reads.
    public let name: String?
    /// The merchant's sort order. The list is already sorted by it; it is carried so a client that re-sorts can put it back.
    public let position: Int?
    /// The PSP behind it, for a checkout that has to load a provider SDK before it can collect an instrument. null for self-managed methods.
    public let provider: String?

    init(
        code: String?,
        currency: String?,
        description: String?,
        fee: Double?,
        fee_type: RevenexxEnums.PaymentFeeType?,
        kind: RevenexxEnums.PaymentMethodKind?,
        labels: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        provider: String?
    ) {
        self.code = code
        self.currency = currency
        self.description = description
        self.fee = fee
        self.fee_type = fee_type
        self.kind = kind
        self.labels = labels
        self.name = name
        self.position = position
        self.provider = provider
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.fee = try container.decodeIfPresent(Double.self, forKey: .fee)
        if let fee_typeString = try container.decodeIfPresent(String.self, forKey: .fee_type) {
            self.fee_type = RevenexxEnums.PaymentFeeType(rawValue: fee_typeString)
        } else {
            self.fee_type = nil
        }
        if let kindString = try container.decodeIfPresent(String.self, forKey: .kind) {
            self.kind = RevenexxEnums.PaymentMethodKind(rawValue: kindString)
        } else {
            self.kind = nil
        }
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(fee, forKey: .fee)
        try container.encodeIfPresent(fee_type?.rawValue, forKey: .fee_type)
        try container.encodeIfPresent(kind?.rawValue, forKey: .kind)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(provider, forKey: .provider)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "currency": currency as Any,
            "description": description as Any,
            "fee": fee as Any,
            "fee_type": fee_type?.rawValue as Any,
            "kind": kind?.rawValue as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "provider": provider as Any
        ]
    }

    public static func from(map: [String: Any] ) -> EligiblePaymentMethod {
        return EligiblePaymentMethod(
            code: map["code"] as? String,
            currency: map["currency"] as? String,
            description: map["description"] as? String,
            fee: map["fee"] as? Double,
            fee_type: map["fee_type"] as? String != nil ? PaymentFeeType(rawValue: map["fee_type"] as! String) : nil,
            kind: map["kind"] as? String != nil ? PaymentMethodKind(rawValue: map["kind"] as! String) : nil,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            provider: map["provider"] as? String
        )
    }
}
