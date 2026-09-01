```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let paymentsProviders = PaymentsProviders(client)

let result = try await paymentsProviders.paymentsProvidersList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    provider: "stripe", // optional
    enabled: true, // optional
    test_mode: true // optional
)

```
