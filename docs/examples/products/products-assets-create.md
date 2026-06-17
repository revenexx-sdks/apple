```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let assets = try await products.productsAssetsCreate(
    asset_family_id: "",
    code: "",
    attribute_values: [:], // optional
    media_uuid: "" // optional
)

```
