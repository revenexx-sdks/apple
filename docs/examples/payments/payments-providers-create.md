```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let payments = Payments(client)

let paymentProvider = try await payments.paymentsProvidersCreate(
    provider: "",
    credentials: [:], // optional
    enabled: false, // optional
    name: "", // optional
    options: [:], // optional
    test_mode: false, // optional
    webhook_secret: "" // optional
)

```
