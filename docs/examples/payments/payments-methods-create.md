```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let payments = Payments(client)

let paymentMethod = try await payments.paymentsMethodsCreate(
    code: "",
    name: "",
    countries: [], // optional
    description: "", // optional
    enabled: false, // optional
    fee_amount: 0, // optional
    fee_currency: "", // optional
    fee_type: .none, // optional
    kind: .selfManaged, // optional
    labels: [:], // optional
    max_order_value: 0, // optional
    metadata: [:], // optional
    min_order_value: 0, // optional
    position: 0, // optional
    provider: "", // optional
    provider_method: "" // optional
)

```
