```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let order = try await orders.ordersUpdate(
    id: "",
    billing_address: [:], // optional
    buyer: [:], // optional
    customer_order_number: "", // optional
    metadata: [:], // optional
    shipping_address: [:], // optional
    user_data: [:] // optional
)

```
