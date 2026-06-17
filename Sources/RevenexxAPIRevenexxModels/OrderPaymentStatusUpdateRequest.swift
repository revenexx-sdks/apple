import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// 
open class OrderPaymentStatusUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case payment_id = "payment_id"
        case status = "status"
    }

    /// Reference into the payment system — merged into the order&#039;s payment snapshot.
    public let payment_id: String?
    /// The new payment dimension value.
    public let status: Revenexx API — revenexxEnums.OrderPaymentStatus

    init(
        payment_id: String?,
        status: Revenexx API — revenexxEnums.OrderPaymentStatus
    ) {
        self.payment_id = payment_id
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.payment_id = try container.decodeIfPresent(String.self, forKey: .payment_id)
        self.status = Revenexx API — revenexxEnums.OrderPaymentStatus(rawValue: try container.decode(String.self, forKey: .status))!
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(payment_id, forKey: .payment_id)
        try container.encode(status.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "payment_id": payment_id as Any,
            "status": status.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderPaymentStatusUpdateRequest {
        return OrderPaymentStatusUpdateRequest(
            payment_id: map["payment_id"] as? String,
            status: OrderPaymentStatus(rawValue: map["status"] as! String)!
        )
    }
}
