```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let channels = Channels(client)

let error = try await channels.channelsUpdate(
    id: "",
    code: "shop", // optional
    is_default: true, // optional
    labels: [
        "de": "Shop",
        "en": "Shop"
    ], // optional
    name: "Shop", // optional
    position: 1, // optional
    status: .active, // optional
    type: "storefront", // optional
    unassigned_visibility: .inherit // optional
)

```
