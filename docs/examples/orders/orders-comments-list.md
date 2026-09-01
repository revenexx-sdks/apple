```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let error = try await orders.ordersCommentsList(
    id: "",
    id_query: "", // optional
    body: "Called the customer, delivery agreed for next week.", // optional
    visibility: .internal, // optional
    author: "service-desk", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc" // optional
)

```
