```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingMethods = ShippingMethods(client)

let error = try await shippingMethods.shippingMethodsCreate(
    code: "express",
    name: "Express delivery",
    carrier: "acme-parcel", // optional
    carrier_id: "8a4d1c7e-2b93-4f61-b0d2-6c5a9e3f1a44", // optional
    countries: ["DE","AT","CH"], // optional
    currency: "EUR", // optional
    description: "Delivered by the next working day when ordered before the cut-off.", // optional
    enabled: true, // optional
    eta_days_max: 1, // optional
    eta_days_min: 1, // optional
    free_above: 100, // optional
    labels: [
        "de": "Expressversand",
        "en": "Express delivery"
    ], // optional
    matrix_attribute: "volume_litres", // optional
    matrix_basis: .weight, // optional
    metadata: [
        "erp_key": "SHIP-EXPRESS",
        "printer": "label-2"
    ], // optional
    position: 1, // optional
    price: 9.9, // optional
    pricing_type: .fixed, // optional
    quote_above: 31.5, // optional
    tax_class: "reduced" // optional
)

```
