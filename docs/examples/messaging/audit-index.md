```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.auditIndex(
    resource_type: .template, // optional
    resource_id: "", // optional
    subject: "", // optional
    limit: 1 // optional
)

```
