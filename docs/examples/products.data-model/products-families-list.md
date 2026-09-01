```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let result = try await productsDataModel.productsFamiliesList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    code: "power_tools", // optional
    label_attribute: "name", // optional
    image_attribute: "main_image", // optional
    labels: "{}", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z" // optional
)

```
