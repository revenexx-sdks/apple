```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let payments = Payments(client)

let payment = try await payments.paymentsCreate(
    amount: 0,
    method_code: "",
    cart_id: "", // optional
    contact_id: "", // optional
    country: "", // optional
    currency: "", // optional
    idempotency_key: "", // optional
    metadata: [:], // optional
    order_ref: "", // optional
    return_url: "" // optional
)

```
