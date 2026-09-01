```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let channels = Channels(client)

let error = try await channels.channelsList(
    id: "", // optional
    code: "shop", // optional
    name: "Shop", // optional
    labels: "{"en":"Shop","de":"Shop"}", // optional
    type: "storefront", // optional
    status: .active, // optional
    unassigned_visibility: .inherit, // optional
    is_default: true, // optional
    position: 1, // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
