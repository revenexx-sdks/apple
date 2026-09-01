```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingValueLists = ShippingValueLists(client)

let error = try await shippingValueLists.shippingServiceLevelsUpdate(
    id: "",
    description: "When to pick this service level.", // optional
    descriptions: [
        "de": "Wann diese Option zu wählen ist.",
        "en": "When to pick this service level."
    ], // optional
    is_default: true, // optional
    labels: [
        "de": "Night courier",
        "en": "Night courier"
    ], // optional
    position: 1, // optional
    title: "Night courier", // optional
    tone: .neutral // optional
)

```
