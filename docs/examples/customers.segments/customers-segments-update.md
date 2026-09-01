```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersSegments = CustomersSegments(client)

let error = try await customersSegments.customersSegmentsUpdate(
    id: "",
    code: "key_accounts", // optional
    labels: [
        "de": "Großkunden",
        "en": "Key accounts"
    ], // optional
    position: 1, // optional
    rule_match: .all, // optional
    rules: [:] // optional
)

```
