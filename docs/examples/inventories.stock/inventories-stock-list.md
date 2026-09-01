```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesStock = InventoriesStock(client)

let error = try await inventoriesStock.inventoriesStockList(
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    location_id: "", // optional
    product_id: "", // optional
    sku: "ACME-4711-BLK", // optional
    on_hand: 42, // optional
    reserved: 5, // optional
    reorder_point: 10, // optional
    metadata: "{}", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z" // optional
)

```
