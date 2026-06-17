```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventories = Inventories(client)

let stockLevel = try await inventories.inventoriesStockUpdate(
    id: "",
    location_id: "", // optional
    metadata: [:], // optional
    on_hand: 0, // optional
    product_id: "", // optional
    reorder_point: 0, // optional
    reserved: 0, // optional
    sku: "" // optional
)

```
