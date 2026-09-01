```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesReservations = InventoriesReservations(client)

let error = try await inventoriesReservations.inventoriesRelease(
    order_ref: "SO-2026-000123"
)

```
