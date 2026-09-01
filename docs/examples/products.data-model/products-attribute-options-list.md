```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let result = try await productsDataModel.productsAttributeOptionsList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    attribute_id: "", // optional
    code: "stainless_steel", // optional
    position: 1, // optional
    swatch: "{}", // optional
    labels: "{}", // optional
    created_at: "2026-01-01T12:00:00Z" // optional
)

```
