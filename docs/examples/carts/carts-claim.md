```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let result = try await carts.cartsClaim(
    contact_id: "",
    session_key: "",
    target_cart_id: "" // optional
)

```
