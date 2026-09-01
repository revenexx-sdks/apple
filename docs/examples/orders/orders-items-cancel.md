```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let error = try await orders.ordersItemsCancel(
    id: "",
    positions: [],
    cancelled_by: "service-desk", // optional
    reason: "Out of stock, customer agreed" // optional
)

```
