```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let error = try await carts.cartsUpdate(
    id: "",
    channel_id: "", // optional
    currency: "EUR", // optional
    metadata: [
        "campaign": "spring-catalogue",
        "locale": "de-DE",
        "source": "storefront"
    ], // optional
    name: "Weekly order" // optional
)

```
