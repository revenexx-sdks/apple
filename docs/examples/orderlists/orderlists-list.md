```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orderlists = Orderlists(client)

let error = try await orderlists.orderlistsList(
    owner_id: "", // optional
    organization_id: "", // optional
    kind: "shopping", // optional
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc" // optional
)

```
