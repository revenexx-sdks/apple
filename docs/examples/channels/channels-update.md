```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let channels = Channels(client)

let channel = try await channels.channelsUpdate(
    id: "",
    code: "", // optional
    is_default: false, // optional
    labels: [:], // optional
    name: "", // optional
    position: 0, // optional
    status: .active, // optional
    type: .storefront // optional
)

```
