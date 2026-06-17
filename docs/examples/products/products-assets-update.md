```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let assets = try await products.productsAssetsUpdate(
    id: "",
    asset_family_id: "", // optional
    attribute_values: [:], // optional
    code: "", // optional
    media_uuid: "" // optional
)

```
