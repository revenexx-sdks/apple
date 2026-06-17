```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventories = Inventories(client)

let location = try await inventories.inventoriesLocationsUpdate(
    id: "",
    address: [:], // optional
    code: "", // optional
    enabled: false, // optional
    labels: [:], // optional
    metadata: [:], // optional
    name: "", // optional
    priority: 0, // optional
    type: .warehouse // optional
)

```
