```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let paymentsMethods = PaymentsMethods(client)

let result = try await paymentsMethods.paymentsMethodsEligible(
    amount: 49.9, // optional
    country: "DE", // optional
    currency: "EUR" // optional
)

```
