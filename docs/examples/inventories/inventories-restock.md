```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventories = Inventories(client)

let result = try await inventories.inventoriesRestock(
    items: [],
    location_code: "", // optional
    order_ref: "", // optional
    reason: "" // optional
)

```
