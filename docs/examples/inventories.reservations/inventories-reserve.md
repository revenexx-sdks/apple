```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesReservations = InventoriesReservations(client)

let error = try await inventoriesReservations.inventoriesReserve(
    order_ref: "SO-2026-000123",
    expires_at: "2026-01-01T12:00:00Z", // optional
    items: [], // optional
    location_code: "main", // optional
    product_id: "", // optional
    quantity: 2, // optional
    ship_to: [:], // optional
    sku: "ACME-4711-BLK" // optional
)

```
