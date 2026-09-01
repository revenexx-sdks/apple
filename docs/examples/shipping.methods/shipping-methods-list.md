```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingMethods = ShippingMethods(client)

let error = try await shippingMethods.shippingMethodsList(
    limit: 1, // optional
    offset: 1, // optional
    order: "position.asc", // optional
    code: "express", // optional
    enabled: true, // optional
    pricing_type: .matrix, // optional
    carrier_id: "8a4d1c7e-2b93-4f61-b0d2-6c5a9e3f1a44", // optional
    carrier: "acme-parcel", // optional
    tax_class: "reduced" // optional
)

```
