```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let paymentsLedger = PaymentsLedger(client)

let result = try await paymentsLedger.paymentsList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    cart_id: "", // optional
    contact_id: "", // optional
    status: .created, // optional
    order_ref: "ORD-10042", // optional
    method_code: "invoice", // optional
    kind: .selfManaged, // optional
    provider: "stripe", // optional
    dunning_stage: .none, // optional
    idempotency_key: "checkout-2f9c41" // optional
)

```
