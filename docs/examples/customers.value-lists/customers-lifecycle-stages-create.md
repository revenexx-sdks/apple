```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersValueLists = CustomersValueLists(client)

let error = try await customersValueLists.customersLifecycleStagesCreate(
    code: "",
    title: "Customer",
    description: "Has ordered at least once and is being served.", // optional
    descriptions: [
        "de": "Hat mindestens einmal bestellt und wird betreut.",
        "en": "Has ordered at least once and is being served."
    ], // optional
    is_default: true, // optional
    labels: [
        "de": "Kunde",
        "en": "Customer"
    ], // optional
    position: 1, // optional
    tone: .neutral // optional
)

```
