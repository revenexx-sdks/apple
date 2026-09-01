import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class OrderPaymentStatusUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case payment_id = "payment_id"
        case status = "status"
    }

    /// The reference into the payment system. MERGED into the order's payment snapshot under 'payment_id' — the rest of the snapshot is left alone — and carried in the order.payment_status.changed event. Omitted leaves the snapshot untouched.
    public let payment_id: String?
    /// The new value of the payment dimension. Whether the order is PAID, and the dimension this app does not decide: it is fed from outside through POST /orders/{id}/payment-status (the payments app or an ERP), and only seeded at place-time from payment.status. Orthogonal to the lifecycle — a completed order can still be open, and a paid one can still be pending.
    public let status: RevenexxEnums.OrderPaymentStatus

    init(
        payment_id: String?,
        status: RevenexxEnums.OrderPaymentStatus
    ) {
        self.payment_id = payment_id
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.payment_id = try container.decodeIfPresent(String.self, forKey: .payment_id)
        self.status = RevenexxEnums.OrderPaymentStatus(rawValue: try container.decode(String.self, forKey: .status))!
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
