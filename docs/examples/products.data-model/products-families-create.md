```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsFamiliesCreate(
    code: "power_tools",
    image_attribute: "main_image", // optional
    label_attribute: "name", // optional
    labels: [
        "de": "Elektrowerkzeuge",
        "en": "Power tools"
    ] // optional
)

```
