```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.sendSend(
    channel: "",
    template: "",
    to: "",
    attachments: [], // optional
    data: [:], // optional
    draft: true, // optional
    locale: "", // optional
    market: "", // optional
    send_at: "2026-01-01T12:00:00Z" // optional
)

```
