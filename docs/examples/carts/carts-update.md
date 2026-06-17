```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let cart = try await carts.cartsUpdate(
    id: "",
    channel_id: "", // optional
    currency: "", // optional
    market_id: "", // optional
    metadata: [:], // optional
    name: "" // optional
)

```
