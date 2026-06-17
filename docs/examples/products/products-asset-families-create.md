```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let assetFamilies = try await products.productsAssetFamiliesCreate(
    code: "",
    labels: [:], // optional
    naming_convention: [:] // optional
)

```
