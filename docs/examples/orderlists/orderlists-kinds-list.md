```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orderlists = Orderlists(client)

let result = try await orderlists.orderlistsKindsList(
    limit: 50, // optional
    offset: 0 // optional
)

```
