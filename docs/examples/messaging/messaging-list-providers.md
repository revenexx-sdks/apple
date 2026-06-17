```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let providerList = try await messaging.messagingListProviders(
    queries: [], // optional
    search: "", // optional
    total: false // optional
)

```
