```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let categories = try await products.productsCategoriesUpdate(
    id: "",
    code: "", // optional
    labels: [:], // optional
    parent_id: "", // optional
    path: "", // optional
    position: 0, // optional
    values: [:] // optional
)

```
