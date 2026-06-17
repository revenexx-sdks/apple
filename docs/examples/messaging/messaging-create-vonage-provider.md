```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let provider = try await messaging.messagingCreateVonageProvider(
    name: "",
    providerId: "",
    apiKey: "", // optional
    apiSecret: "", // optional
    enabled: false, // optional
    from: "" // optional
)

```
