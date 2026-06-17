```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let attributeOptions = try await products.productsAttributeOptionsUpdate(
    id: "",
    attribute_id: "", // optional
    code: "", // optional
    labels: [:], // optional
    position: 0, // optional
    swatch: [:] // optional
)

```
