```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let order = try await orders.ordersCancel(
    id: "",
    cancelled_by: "", // optional
    reason: "" // optional
)

```
