```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let orderReturn = try await orders.ordersReturnsReject(
    id: "",
    rid: "",
    reason: "", // optional
    resolution: "" // optional
)

```
