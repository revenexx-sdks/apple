```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let orderDetail = try await orders.ordersPlace(
    items: [],
    billing_address: [:], // optional
    buyer: [:], // optional
    cart_id: "", // optional
    channel_id: "", // optional
    contact_id: "", // optional
    currency: "", // optional
    customer_order_number: "", // optional
    grand_total: 0, // optional
    market_id: "", // optional
    metadata: [:], // optional
    organization_id: "", // optional
    payment: [:], // optional
    shipping: [:], // optional
    shipping_address: [:], // optional
    shipping_total: 0, // optional
    user_data: [:] // optional
)

```
