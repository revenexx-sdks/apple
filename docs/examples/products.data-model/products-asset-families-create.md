```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsAssetFamiliesCreate(
    code: "packshots",
    labels: [
        "de": "Packshots",
        "en": "Packshots"
    ], // optional
    naming_convention: [
        "allowed_extensions": [
            "0": "jpg",
            "1": "png"
        ],
        "pattern": "{sku}_{index}",
        "source": "sku"
    ] // optional
)

```
