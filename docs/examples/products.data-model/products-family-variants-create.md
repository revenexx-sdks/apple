```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsFamilyVariantsCreate(
    code: "clothing_by_colour_size",
    family_id: "",
    axes: [
        "0": "colour",
        "1": "size"
    ], // optional
    labels: [
        "de": "Nach Farbe und Größe",
        "en": "By colour and size"
    ] // optional
)

```
