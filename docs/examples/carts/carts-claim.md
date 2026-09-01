```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let error = try await carts.cartsClaim(
    contact_id: "",
    session_key: "a1b2c3d4e5f6",
    strategy: .merge, // optional
    target_cart_id: "" // optional
)

```
