```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let error = try await orders.ordersEventsList(
    id: "",
    id_query: "", // optional
    name: "order.shipment.created", // optional
    actor: "", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc" // optional
)

```
