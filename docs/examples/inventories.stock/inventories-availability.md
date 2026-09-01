```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesStock = InventoriesStock(client)

let error = try await inventoriesStock.inventoriesAvailability(
    items: [], // optional
    location_code: "main", // optional
    product_id: "", // optional
    quantity: 1, // optional
    sku: "ACME-4711-BLK" // optional
)

```
