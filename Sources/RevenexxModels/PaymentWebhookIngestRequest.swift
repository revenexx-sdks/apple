import Foundation
import JSONCodable

/// The dispatch envelope from webhooks.revenexx.com. Nothing is required and nothing is constrained — three keys are read, and the rest is carried along.
open class PaymentWebhookIngestRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case request = "request"
        case verified = "verified"
    }

    /// The dispatcher's delivery id. Echoed back as `delivery_id` so a delivery and what the ledger did can be correlated.
    public let id: String?
    /// The captured HTTP request as the PSP sent it.
    public let request: String?
    /// Whether the ingress verified the callback signature against the provider's `webhook_secret`. An explicit false is refused with 422: an endpoint may run in annotate mode, and the ledger stays sovereign over one that does.
    public let verified: String?

    init(
        id: String?,
        request: String?,
        verified: String?
    ) {
        self.id = id
        self.request = request
        self.verified = verified
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.request = try container.decodeIfPresent(String.self, forKey: .request)
        self.verified = try container.decodeIfPresent(String.self, forKey: .verified)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(request, forKey: .request)
        try container.encodeIfPresent(verified, forKey: .verified)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "request": request as Any,
            "verified": verified as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentWebhookIngestRequest {
        return PaymentWebhookIngestRequest(
            id: map["id"] as? String,
            request: map["request"] as? String,
            verified: map["verified"] as? String
        )
    }
}
