```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let error = try await carts.cartsOrder(
    id: "",
    order_ref: "SO-10042" // optional
)

```
