```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsFamilyAttributesCreate(
    attribute_id: "",
    family_id: "",
    is_required: true, // optional
    position: 1, // optional
    required_channels: [
        "0": "shop",
        "1": "b2b"
    ] // optional
)

```
