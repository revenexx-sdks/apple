```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsAttributeOptionsUpdate(
    id: "",
    attribute_id: "", // optional
    code: "stainless_steel", // optional
    labels: [
        "de": "Edelstahl",
        "en": "Stainless steel"
    ], // optional
    position: 1, // optional
    swatch: [
        "hex": "#c0c0c0"
    ] // optional
)

```
