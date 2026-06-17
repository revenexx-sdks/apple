```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let cart = try await carts.cartsCreate(
    channel_id: "", // optional
    contact_id: "", // optional
    currency: "", // optional
    is_current: false, // optional
    market_id: "", // optional
    metadata: [:], // optional
    name: "", // optional
    session_key: "" // optional
)

```
