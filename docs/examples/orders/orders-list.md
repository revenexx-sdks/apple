```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let result = try await orders.ordersList(
    id: "", // optional
    number: "ORD-000123", // optional
    customer_order_number: "PO-2026-0042", // optional
    external_ref: "ERP-4711", // optional
    acknowledged_at: "2026-01-01T12:00:00Z", // optional
    cart_id: "", // optional
    contact_id: "", // optional
    organization_id: "", // optional
    channel_id: "", // optional
    currency: "EUR", // optional
    status: .pending, // optional
    payment_status: .open, // optional
    fulfillment_status: .unfulfilled, // optional
    on_hold: true, // optional
    hold_reason: "Credit check pending", // optional
    item_count: 3, // optional
    subtotal: 149.7, // optional
    shipping_total: 5.9, // optional
    tax_total: 29.56, // optional
    grand_total: 185.16, // optional
    placed_at: "2026-01-01T12:00:00Z", // optional
    completed_at: "2026-01-01T12:00:00Z", // optional
    cancelled_at: "2026-01-01T12:00:00Z", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc" // optional
)

```
