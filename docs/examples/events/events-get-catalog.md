```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let events = Events(client)

let result = try await events.eventsGetCatalog(
    fields: "topic,channel" // optional
)

```
