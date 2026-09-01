import Foundation
import JSONCodable
import RevenexxEnums

/// The order aggregate: every column of the order plus its items, shipments (with their booked positions), returns and cancellations.
open class OrderDetail: Codable {

    enum CodingKeys: String, CodingKey {
        case acknowledged_at = "acknowledged_at"
        case billing_address = "billing_address"
        case buyer = "buyer"
        case cancellations = "cancellations"
        case cancelled_at = "cancelled_at"
        case cart_id = "cart_id"
        case channel_id = "channel_id"
        case completed_at = "completed_at"
        case contact_id = "contact_id"
        case created_at = "created_at"
        case currency = "currency"
        case customer_order_number = "customer_order_number"
        case external_ref = "external_ref"
        case fulfillment_status = "fulfillment_status"
        case grand_total = "grand_total"
        case hold_reason = "hold_reason"
        case id = "id"
        case item_count = "item_count"
        case items = "items"
        case metadata = "metadata"
        case number = "number"
        case on_hold = "on_hold"
        case organization_id = "organization_id"
        case payment = "payment"
        case payment_status = "payment_status"
        case placed_at = "placed_at"
        case returns = "returns"
        case shipments = "shipments"
        case shipping = "shipping"
        case shipping_address = "shipping_address"
        case shipping_total = "shipping_total"
        case status = "status"
        case subtotal = "subtotal"
        case tax_total = "tax_total"
        case updated_at = "updated_at"
        case user_data = "user_data"
    }

    /// When the fulfilling system took the order over. Written once. While it is null the order can still be modified here; afterwards modification goes through that system, unless the tenant sets allow_modification_after_acknowledge.
    public let acknowledged_at: String?
    /// The invoice address, FROZEN at place-time. Changing the customer's address afterwards does not change what this order was billed to.
    public let billing_address: [String: AnyCodable]?
    /// The ordering party as it was at place-time, FROZEN: a copy, not a reference, so the order still reads correctly after the customer record is renamed, merged or deleted. The caller decides what goes in; this app stores it and reads nothing out of it.
    public let buyer: [String: AnyCodable]?
    /// What was taken off the order, oldest first — one record per cancel call, whether it emptied the order or removed named quantities. The order-level `cancelled_at` says when it ended; these say what happened.
    public let cancellations: [OrderCancellation]?
    /// When the order was cancelled, whether by a full cancel or by the last open quantity being cancelled position by position. Null otherwise.
    public let cancelled_at: String?
    /// The cart this order was placed from, when a storefront handed one over. A reference across an app boundary (the carts app), not a foreign key — nothing here checks that it resolves. Null for an order an integration or an operator created.
    public let cart_id: String?
    /// The sales channel the order arrived through — webshop, app, phone desk, EDI. Null when the caller named none.
    public let channel_id: String?
    /// When the order was closed — by a full shipment, by payment or by hand, depending on the tenant's auto_complete_on. Null until then.
    public let completed_at: String?
    /// The PERSON who ordered — a contact in the customers app. Resolved from the acting principal whenever the caller carries one, and a body value that disagrees is refused rather than silently overridden. Null for a guest checkout.
    public let contact_id: String?
    /// When the order row was written. For a placed order this is placed_at; for a requested one it is when the request was submitted.
    public let created_at: String?
    /// ISO 4217 code of EVERY amount on this order. Frozen at place-time from the market's default_currency unless the caller named one. Nothing on this order is ever converted, and the approval threshold is read in this currency — which is why the threshold is a per-market setting.
    public let currency: String?
    /// The BUYER's own reference — their purchase-order number. Free text, not unique, never generated here: it exists so the paperwork can carry the number the buyer's accounts payable will look for. One of the few fields PUT /orders/{id} may still change.
    public let customer_order_number: String?
    /// The FULFILLING system's reference for this order, typically the ERP order number. Written once by POST /orders/{id}/acknowledge and null until an integration acknowledged it.
    public let external_ref: String?
    /// Whether the order has SHIPPED, and the one dimension nobody writes: it is DERIVED after every quantity change from the positions' own bookkeeping. 'fulfilled' means shipped >= ordered − cancelled across all positions, 'partial' means something went out. Sending it has no effect; ship, cancel or return something and it moves.
    public let fulfillment_status: RevenexxEnums.OrderFulfillmentStatus?
    /// What the buyer owes: subtotal + shipping_total + tax_total, COMPUTED by this app and NEVER taken from the caller — trusting a supplied total is how inconsistent orders happened. This is the number the approval threshold is compared against and the number the revenue rollup sums.
    public let grand_total: Double?
    /// Why the order is held, in the words the shipping guard quotes back. Null when it is not held — releasing a hold clears it.
    public let hold_reason: String?
    /// Primary key of the order, and the id every other route takes. Not the order number.
    public let id: String?
    /// The summed ORDERED quantity over all positions, rounded to a whole number — a headline figure for a list, computed once at place-time. It is deliberately not reduced when something is cancelled or returned; the positions carry that arithmetic.
    public let item_count: Int?
    /// The positions of the order, in position order. Everything a caller does to this order names one of these by its `id`.
    public let items: [OrderItem]?
    /// Free-form data belonging to the INTEGRATION side — an ERP's own bookkeeping about this order. Stored and returned untouched; nothing here reads it.
    public let metadata: [String: AnyCodable]?
    /// The order number a human quotes — drawn from the tenant's order range at place-time, unique per tenant and never reused. It is NOT the id: every route addresses an order by uuid, and GET /orders?number=… is how a number becomes one.
    public let number: String?
    /// A business stop, ORTHOGONAL to status: a held order keeps its lifecycle state and is refused at the guards. How far the hold reaches is the tenant's call (on_hold_blocks: shipping only, shipping and cancellation, or nothing at all).
    public let on_hold: Bool?
    /// The COMPANY the order is booked on — an organization in the customers app, and the B2B half of who ordered. This is what orders.reports.customer-rollup aggregates by and what makes an order visible to a buyer's colleagues. Null on a private or guest order, which the rollup counts separately because it cannot attribute it.
    public let organization_id: String?
    /// The payment arrangement as it was chosen, FROZEN. This app reads exactly two keys and stores the rest untouched: 'status' seeds payment_status at place-time when it names one of the permitted values (anything else is ignored and the order starts 'open'), and 'payment_id' is merged in by POST /orders/{id}/payment-status. The method itself, its provider fields and any redirect state belong to the payments app.
    public let payment: [String: AnyCodable]?
    /// Whether the order is PAID, and the dimension this app does not decide: it is fed from outside through POST /orders/{id}/payment-status (the payments app or an ERP), and only seeded at place-time from payment.status. Orthogonal to the lifecycle — a completed order can still be open, and a paid one can still be pending.
    public let payment_status: RevenexxEnums.OrderPaymentStatus?
    /// When the order was PLACED. Null while it is pending approval: an order awaiting sign-off exists but was never placed, and that is exactly the difference this field records.
    public let placed_at: String?
    /// What is coming back or has come back, oldest first, in every state including rejected. A return is registered against the SHIPPED quantities, so this list is empty on an order that never shipped.
    public let returns: [OrderReturn]?
    /// What has gone out, oldest first — each shipment with the position quantities it booked. Empty until something ships; a partial order carries several.
    public let shipments: [OrderShipment]?
    /// The shipping arrangement as it was chosen, FROZEN. Two keys are READ at place-time and feed the totals: 'price' becomes shipping_total (the shipping_total field is only the fallback when this is absent) and 'tax_rate' is what shipping is taxed at, because shipping is a Nebenleistung and is taxed too. Everything else — the carrier product, the delivery window, the pickup point — is stored untouched and belongs to the shipping app.
    public let shipping: [String: AnyCodable]?
    /// The delivery address, FROZEN at place-time — what goes on the label of every shipment of this order. Null on an order that is never delivered (a service, a digital item, a collection).
    public let shipping_address: [String: AnyCodable]?
    /// NET shipping cost, taken from shipping.price or, when the snapshot carries no price, from the request's shipping_total. In `currency`.
    public let shipping_total: Double?
    /// Where the order stands in its LIFECYCLE, and one of three independent status dimensions. 'pending' = created but not placed, an order waiting for approval; 'placed' = accepted, nothing shipped; 'in_fulfillment' = part of it has gone out, or all of it has and the tenant does not close on shipment; 'completed' and 'cancelled' end it. Moved by the action routes only — it is not writable through PUT /orders/{id}.
    public let status: RevenexxEnums.OrderStatus?
    /// NET total of the positions (the sum of their line_total), COMPUTED here at place-time. In `currency`, four decimal places. A caller cannot set it.
    public let subtotal: Double?
    /// All tax on this order: the positions' tax_amount plus the tax on shipping (shipping_total × shipping.tax_rate). COMPUTED here — a caller cannot set it.
    public let tax_total: Double?
    /// When any column of the order last changed — every status move, every re-derived fulfillment, every modification.
    public let updated_at: String?
    /// Free-form data belonging to the ORDERING side — carried through from the storefront or the cart and handed back untouched. One of the few fields PUT /orders/{id} may still change.
    public let user_data: [String: AnyCodable]?

    init(
        acknowledged_at: String?,
        billing_address: [String: AnyCodable]?,
        buyer: [String: AnyCodable]?,
        cancellations: [OrderCancellation]?,
        cancelled_at: String?,
        cart_id: String?,
        channel_id: String?,
        completed_at: String?,
        contact_id: String?,
        created_at: String?,
        currency: String?,
        customer_order_number: String?,
        external_ref: String?,
        fulfillment_status: RevenexxEnums.OrderFulfillmentStatus?,
        grand_total: Double?,
        hold_reason: String?,
        id: String?,
        item_count: Int?,
        items: [OrderItem]?,
        metadata: [String: AnyCodable]?,
        number: String?,
        on_hold: Bool?,
        organization_id: String?,
        payment: [String: AnyCodable]?,
        payment_status: RevenexxEnums.OrderPaymentStatus?,
        placed_at: String?,
        returns: [OrderReturn]?,
        shipments: [OrderShipment]?,
        shipping: [String: AnyCodable]?,
        shipping_address: [String: AnyCodable]?,
        shipping_total: Double?,
        status: RevenexxEnums.OrderStatus?,
        subtotal: Double?,
        tax_total: Double?,
        updated_at: String?,
        user_data: [String: AnyCodable]?
    ) {
        self.acknowledged_at = acknowledged_at
        self.billing_address = billing_address
        self.buyer = buyer
        self.cancellations = cancellations
        self.cancelled_at = cancelled_at
        self.cart_id = cart_id
        self.channel_id = channel_id
        self.completed_at = completed_at
        self.contact_id = contact_id
        self.created_at = created_at
        self.currency = currency
        self.customer_order_number = customer_order_number
        self.external_ref = external_ref
        self.fulfillment_status = fulfillment_status
        self.grand_total = grand_total
        self.hold_reason = hold_reason
        self.id = id
        self.item_count = item_count
        self.items = items
        self.metadata = metadata
        self.number = number
        self.on_hold = on_hold
        self.organization_id = organization_id
        self.payment = payment
        self.payment_status = payment_status
        self.placed_at = placed_at
        self.returns = returns
        self.shipments = shipments
        self.shipping = shipping
        self.shipping_address = shipping_address
        self.shipping_total = shipping_total
        self.status = status
        self.subtotal = subtotal
        self.tax_total = tax_total
        self.updated_at = updated_at
        self.user_data = user_data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.acknowledged_at = try container.decodeIfPresent(String.self, forKey: .acknowledged_at)
        self.billing_address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .billing_address)
        self.buyer = try container.decodeIfPresent([String: AnyCodable].self, forKey: .buyer)
        self.cancellations = try container.decodeIfPresent([OrderCancellation].self, forKey: .cancellations)
        self.cancelled_at = try container.decodeIfPresent(String.self, forKey: .cancelled_at)
        self.cart_id = try container.decodeIfPresent(String.self, forKey: .cart_id)
        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.completed_at = try container.decodeIfPresent(String.self, forKey: .completed_at)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.customer_order_number = try container.decodeIfPresent(String.self, forKey: .customer_order_number)
        self.external_ref = try container.decodeIfPresent(String.self, forKey: .external_ref)
        if let fulfillment_statusString = try container.decodeIfPresent(String.self, forKey: .fulfillment_status) {
            self.fulfillment_status = RevenexxEnums.OrderFulfillmentStatus(rawValue: fulfillment_statusString)
        } else {
            self.fulfillment_status = nil
        }
        self.grand_total = try container.decodeIfPresent(Double.self, forKey: .grand_total)
        self.hold_reason = try container.decodeIfPresent(String.self, forKey: .hold_reason)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.item_count = try container.decodeIfPresent(Int.self, forKey: .item_count)
        self.items = try container.decodeIfPresent([OrderItem].self, forKey: .items)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.on_hold = try container.decodeIfPresent(Bool.self, forKey: .on_hold)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.payment = try container.decodeIfPresent([String: AnyCodable].self, forKey: .payment)
        if let payment_statusString = try container.decodeIfPresent(String.self, forKey: .payment_status) {
            self.payment_status = RevenexxEnums.OrderPaymentStatus(rawValue: payment_statusString)
        } else {
            self.payment_status = nil
        }
        self.placed_at = try container.decodeIfPresent(String.self, forKey: .placed_at)
        self.returns = try container.decodeIfPresent([OrderReturn].self, forKey: .returns)
        self.shipments = try container.decodeIfPresent([OrderShipment].self, forKey: .shipments)
        self.shipping = try container.decodeIfPresent([String: AnyCodable].self, forKey: .shipping)
        self.shipping_address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .shipping_address)
        self.shipping_total = try container.decodeIfPresent(Double.self, forKey: .shipping_total)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.OrderStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.subtotal = try container.decodeIfPresent(Double.self, forKey: .subtotal)
        self.tax_total = try container.decodeIfPresent(Double.self, forKey: .tax_total)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.user_data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .user_data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(acknowledged_at, forKey: .acknowledged_at)
        try container.encodeIfPresent(billing_address, forKey: .billing_address)
        try container.encodeIfPresent(buyer, forKey: .buyer)
        try container.encodeIfPresent(cancellations, forKey: .cancellations)
        try container.encodeIfPresent(cancelled_at, forKey: .cancelled_at)
        try container.encodeIfPresent(cart_id, forKey: .cart_id)
        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(completed_at, forKey: .completed_at)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(customer_order_number, forKey: .customer_order_number)
        try container.encodeIfPresent(external_ref, forKey: .external_ref)
        try container.encodeIfPresent(fulfillment_status?.rawValue, forKey: .fulfillment_status)
        try container.encodeIfPresent(grand_total, forKey: .grand_total)
        try container.encodeIfPresent(hold_reason, forKey: .hold_reason)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(item_count, forKey: .item_count)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(on_hold, forKey: .on_hold)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(payment, forKey: .payment)
        try container.encodeIfPresent(payment_status?.rawValue, forKey: .payment_status)
        try container.encodeIfPresent(placed_at, forKey: .placed_at)
        try container.encodeIfPresent(returns, forKey: .returns)
        try container.encodeIfPresent(shipments, forKey: .shipments)
        try container.encodeIfPresent(shipping, forKey: .shipping)
        try container.encodeIfPresent(shipping_address, forKey: .shipping_address)
        try container.encodeIfPresent(shipping_total, forKey: .shipping_total)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(subtotal, forKey: .subtotal)
        try container.encodeIfPresent(tax_total, forKey: .tax_total)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(user_data, forKey: .user_data)
    }

    public func toMap() -> [String: Any] {
        return [
            "acknowledged_at": acknowledged_at as Any,
            "billing_address": billing_address as Any,
            "buyer": buyer as Any,
            "cancellations": cancellations?.map { $0.toMap() } as Any,
            "cancelled_at": cancelled_at as Any,
            "cart_id": cart_id as Any,
            "channel_id": channel_id as Any,
            "completed_at": completed_at as Any,
            "contact_id": contact_id as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "customer_order_number": customer_order_number as Any,
            "external_ref": external_ref as Any,
            "fulfillment_status": fulfillment_status?.rawValue as Any,
            "grand_total": grand_total as Any,
            "hold_reason": hold_reason as Any,
            "id": id as Any,
            "item_count": item_count as Any,
            "items": items?.map { $0.toMap() } as Any,
            "metadata": metadata as Any,
            "number": number as Any,
            "on_hold": on_hold as Any,
            "organization_id": organization_id as Any,
            "payment": payment as Any,
            "payment_status": payment_status?.rawValue as Any,
            "placed_at": placed_at as Any,
            "returns": returns?.map { $0.toMap() } as Any,
            "shipments": shipments?.map { $0.toMap() } as Any,
            "shipping": shipping as Any,
            "shipping_address": shipping_address as Any,
            "shipping_total": shipping_total as Any,
            "status": status?.rawValue as Any,
            "subtotal": subtotal as Any,
            "tax_total": tax_total as Any,
            "updated_at": updated_at as Any,
            "user_data": user_data as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderDetail {
        return OrderDetail(
            acknowledged_at: map["acknowledged_at"] as? String,
            billing_address: map["billing_address"] as? [String: AnyCodable],
            buyer: map["buyer"] as? [String: AnyCodable],
            cancellations: (map["cancellations"] as? [[String: Any]] ?? []).map { OrderCancellation.from(map: $0) },
            cancelled_at: map["cancelled_at"] as? String,
            cart_id: map["cart_id"] as? String,
            channel_id: map["channel_id"] as? String,
            completed_at: map["completed_at"] as? String,
            contact_id: map["contact_id"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            customer_order_number: map["customer_order_number"] as? String,
            external_ref: map["external_ref"] as? String,
            fulfillment_status: map["fulfillment_status"] as? String != nil ? OrderFulfillmentStatus(rawValue: map["fulfillment_status"] as! String) : nil,
            grand_total: map["grand_total"] as? Double,
            hold_reason: map["hold_reason"] as? String,
            id: map["id"] as? String,
            item_count: map["item_count"] as? Int,
            items: (map["items"] as? [[String: Any]] ?? []).map { OrderItem.from(map: $0) },
            metadata: map["metadata"] as? [String: AnyCodable],
            number: map["number"] as? String,
            on_hold: map["on_hold"] as? Bool,
            organization_id: map["organization_id"] as? String,
            payment: map["payment"] as? [String: AnyCodable],
            payment_status: map["payment_status"] as? String != nil ? OrderPaymentStatus(rawValue: map["payment_status"] as! String) : nil,
            placed_at: map["placed_at"] as? String,
            returns: (map["returns"] as? [[String: Any]] ?? []).map { OrderReturn.from(map: $0) },
            shipments: (map["shipments"] as? [[String: Any]] ?? []).map { OrderShipment.from(map: $0) },
            shipping: map["shipping"] as? [String: AnyCodable],
            shipping_address: map["shipping_address"] as? [String: AnyCodable],
            shipping_total: map["shipping_total"] as? Double,
            status: map["status"] as? String != nil ? OrderStatus(rawValue: map["status"] as! String) : nil,
            subtotal: map["subtotal"] as? Double,
            tax_total: map["tax_total"] as? Double,
            updated_at: map["updated_at"] as? String,
            user_data: map["user_data"] as? [String: AnyCodable]
        )
    }
}
