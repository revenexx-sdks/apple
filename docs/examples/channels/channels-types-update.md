```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let channels = Channels(client)

let error = try await channels.channelsTypesUpdate(
    id: "",
    description: "A web shop a human browses.", // optional
    descriptions: [
        "de": "Shop",
        "en": "Shop"
    ], // optional
    is_default: true, // optional
    labels: [
        "de": "Shop",
        "en": "Shop"
    ], // optional
    position: 1, // optional
    title: "Product feed", // optional
    tone: .neutral // optional
)

```
