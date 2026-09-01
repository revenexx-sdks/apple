```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let paymentsProviders = PaymentsProviders(client)

let error = try await paymentsProviders.paymentsProvidersGet(
    id: ""
)

```
