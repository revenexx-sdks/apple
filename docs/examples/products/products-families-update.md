```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let families = try await products.productsFamiliesUpdate(
    id: "",
    code: "", // optional
    image_attribute: "", // optional
    label_attribute: "", // optional
    labels: [:] // optional
)

```
