import Foundation
import JSONCodable

/// 
open class PaymentTransitionRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case reason = "reason"
    }

    /// The operator's own words for why. Kept on the payment (`metadata.cancel_reason` / `metadata.refund_reason`) AND handed to the provider's own cancellation or refund reason field, so it is readable in the PSP's dashboard too. Trimmed and cut at 500 characters.
    public let reason: String?

    init(
        reason: String?
    ) {
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentTransitionRequest {
        return PaymentTransitionRequest(
            reason: map["reason"] as? String
        )
    }
}
