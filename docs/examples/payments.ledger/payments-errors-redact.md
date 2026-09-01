```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let paymentsLedger = PaymentsLedger(client)

let result = try await paymentsLedger.paymentsErrorsRedact(
    apply: true, // optional
    limit: 500 // optional
)

```
