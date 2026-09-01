```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesReservations = InventoriesReservations(client)

let error = try await inventoriesReservations.inventoriesReservationsList(
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    location_id: "", // optional
    product_id: "", // optional
    sku: "ACME-4711-BLK", // optional
    quantity: 2, // optional
    order_ref: "SO-2026-000123", // optional
    status: .active, // optional
    expires_at: "2026-01-01T12:00:00Z", // optional
    metadata: "{}", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z" // optional
)

```
