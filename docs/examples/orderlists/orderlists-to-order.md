```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orderlists = Orderlists(client)

let error = try await orderlists.orderlistsToOrder(
    id: "",
    currency: "", // optional
    customer_order_number: "PO-2026-0042" // optional
)

```
