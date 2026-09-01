```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersValueLists = CustomersValueLists(client)

let error = try await customersValueLists.customersContactEventKindsUpdate(
    id: "",
    description: "Somebody spoke to this person on the phone.", // optional
    descriptions: [
        "de": "Es wurde mit dieser Person telefoniert.",
        "en": "Somebody spoke to this person on the phone."
    ], // optional
    is_default: true, // optional
    labels: [
        "de": "Telefonat",
        "en": "Phone call"
    ], // optional
    position: 1, // optional
    title: "Phone call", // optional
    tone: .neutral // optional
)

```
