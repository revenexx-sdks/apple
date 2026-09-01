```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let paymentsProviders = PaymentsProviders(client)

let error = try await paymentsProviders.paymentsProvidersUpdate(
    id: "",
    credentials: [:], // optional
    enabled: true, // optional
    name: "Stripe", // optional
    options: [
        "capture_method": "automatic",
        "logo_url": "https://apps.example.com/payments/logos/stripe",
        "three_ds": false
    ], // optional
    provider: "stripe", // optional
    test_mode: true, // optional
    webhook_secret: "" // optional
)

```
