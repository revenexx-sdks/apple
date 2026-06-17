```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let provider = try await messaging.messagingCreateMsg91Provider(
    name: "",
    providerId: "",
    authKey: "", // optional
    enabled: false, // optional
    senderId: "", // optional
    templateId: "" // optional
)

```
