```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsReferences = ProductsReferences(client)

let error = try await productsReferences.productsReferenceEntitiesUpdate(
    id: "",
    code: "brand", // optional
    image: "reference-entities/brand.svg", // optional
    labels: [
        "de": "Marke",
        "en": "Brand"
    ] // optional
)

```
