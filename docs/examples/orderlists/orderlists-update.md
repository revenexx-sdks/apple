```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orderlists = Orderlists(client)

let error = try await orderlists.orderlistsUpdate(
    id: "",
    kind: "shopping", // optional
    metadata: [
        "department": "facility",
        "erp_reference": "REQ-2026-0042"
    ], // optional
    name: "Weekly office supplies", // optional
    shared: true // optional
)

```
