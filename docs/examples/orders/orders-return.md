```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let error = try await orders.ordersReturn(
    id: "",
    metadata: [
        "rma_portal_case": "C-2026-0917"
    ], // optional
    positions: [], // optional
    reason: "Damaged on arrival", // optional
    restock: true // optional
)

```
