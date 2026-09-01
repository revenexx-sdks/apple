```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesLocations = InventoriesLocations(client)

let error = try await inventoriesLocations.inventoriesLocationsList(
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    code: "main", // optional
    name: "Main warehouse", // optional
    labels: "{}", // optional
    type: .warehouse, // optional
    priority: 0, // optional
    enabled: true, // optional
    address: "{}", // optional
    metadata: "{}", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z" // optional
)

```
