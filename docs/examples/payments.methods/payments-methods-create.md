```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let paymentsMethods = PaymentsMethods(client)

let error = try await paymentsMethods.paymentsMethodsCreate(
    code: "invoice",
    name: "Invoice",
    countries: ["DE","AT"], // optional
    description: "Pay within 14 days of the invoice date.", // optional
    enabled: true, // optional
    fee_amount: 2.5, // optional
    fee_currency: "EUR", // optional
    fee_type: .none, // optional
    kind: .selfManaged, // optional
    labels: [
        "de": "Rechnung",
        "en": "Invoice"
    ], // optional
    max_order_value: 2500, // optional
    metadata: [
        "erp_payment_key": "ZTRM01"
    ], // optional
    min_order_value: 10, // optional
    position: 0, // optional
    provider: "stripe", // optional
    provider_method: "card" // optional
)

```
