```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesStock = InventoriesStock(client)

let error = try await inventoriesStock.inventoriesStockCreate(
    location_id: "",
    metadata: [
        "backorder": true
    ], // optional
    product_id: "", // optional
    reorder_point: 10, // optional
    sku: "ACME-4711-BLK" // optional
)

```
