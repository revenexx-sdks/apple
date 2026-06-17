```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let provider = try await messaging.messagingCreateMailgunProvider(
    name: "",
    providerId: "",
    apiKey: "", // optional
    domain: "", // optional
    enabled: false, // optional
    fromEmail: "", // optional
    fromName: "", // optional
    isEuRegion: false, // optional
    replyToEmail: "", // optional
    replyToName: "" // optional
)

```
