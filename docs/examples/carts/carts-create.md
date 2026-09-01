```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let error = try await carts.cartsCreate(
    channel_id: "", // optional
    contact_id: "", // optional
    currency: "EUR", // optional
    is_current: true, // optional
    metadata: [
        "campaign": "spring-catalogue",
        "locale": "de-DE",
        "source": "storefront"
    ], // optional
    name: "Weekly order", // optional
    session_key: "a1b2c3d4e5f6" // optional
)

```
