```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let error = try await orders.ordersNumberRangesCreate(
    code: "order",
    channel_id: "", // optional
    counter: 123, // optional
    metadata: [
        "owner": "erp-sync"
    ], // optional
    padding: 6, // optional
    position_step: 10, // optional
    prefix: "ORD-", // optional
    step: 1, // optional
    suffix: "" // optional
)

```
