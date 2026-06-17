```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let result = try await carts.cartsImport(
    contact_id: "", // optional
    csv: "", // optional
    name: "", // optional
    payload: [:], // optional
    profile_id: "", // optional
    session_key: "", // optional
    target_cart_id: "" // optional
)

```
