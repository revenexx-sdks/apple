```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let measurementFamilies = try await products.productsMeasurementFamiliesUpdate(
    id: "",
    code: "", // optional
    labels: [:], // optional
    standard_unit: "", // optional
    units: [:] // optional
)

```
