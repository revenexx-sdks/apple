```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesStock = InventoriesStock(client)

let error = try await inventoriesStock.inventoriesReceive(
    items: [], // optional
    location_code: "main", // optional
    product_id: "", // optional
    quantity: 12, // optional
    reason: "Delivery note 4711", // optional
    sku: "ACME-4711-BLK" // optional
)

```
