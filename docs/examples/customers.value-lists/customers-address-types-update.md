```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersValueLists = CustomersValueLists(client)

let error = try await customersValueLists.customersAddressTypesUpdate(
    id: "",
    description: "Where the goods go.", // optional
    descriptions: [
        "de": "Wohin die Ware geliefert wird.",
        "en": "Where the goods go."
    ], // optional
    is_default: true, // optional
    labels: [
        "de": "Lieferadresse",
        "en": "Shipping address"
    ], // optional
    position: 1, // optional
    title: "Shipping address", // optional
    tone: .neutral // optional
)

```
