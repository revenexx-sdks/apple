```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let numberRange = try await orders.ordersNumberRangesUpdate(
    id: "",
    channel_id: "", // optional
    code: "", // optional
    counter: 0, // optional
    metadata: [:], // optional
    padding: 0, // optional
    position_step: 0, // optional
    prefix: "", // optional
    step: 0, // optional
    suffix: "" // optional
)

```
