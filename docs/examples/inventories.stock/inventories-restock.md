```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesStock = InventoriesStock(client)

let error = try await inventoriesStock.inventoriesRestock(
    items: [], // optional
    location_code: "main", // optional
    order_ref: "SO-2026-000123", // optional
    product_id: "", // optional
    quantity: 1, // optional
    reason: "Return: wrong size", // optional
    restock: true, // optional
    sku: "ACME-4711-BLK" // optional
)

```
