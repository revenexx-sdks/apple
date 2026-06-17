```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shipping = Shipping(client)

let shippingMethod = try await shipping.shippingMethodsUpdate(
    id: "",
    carrier: "", // optional
    code: "", // optional
    countries: [], // optional
    currency: "", // optional
    description: "", // optional
    enabled: false, // optional
    eta_days_max: 0, // optional
    eta_days_min: 0, // optional
    free_above: 0, // optional
    labels: [:], // optional
    matrix_attribute: "", // optional
    matrix_basis: .weight, // optional
    metadata: [:], // optional
    name: "", // optional
    position: 0, // optional
    price: 0, // optional
    pricing_type: .fixed // optional
)

```
