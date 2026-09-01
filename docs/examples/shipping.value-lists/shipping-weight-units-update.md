```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingValueLists = ShippingValueLists(client)

let error = try await shippingValueLists.shippingWeightUnitsUpdate(
    id: "",
    description: "When to pick this weight unit.", // optional
    descriptions: [
        "de": "Wann diese Option zu wählen ist.",
        "en": "When to pick this weight unit."
    ], // optional
    factor: 1000, // optional
    is_default: true, // optional
    labels: [
        "de": "Tonne",
        "en": "Tonne"
    ], // optional
    position: 1, // optional
    title: "Tonne", // optional
    tone: .neutral // optional
)

```
