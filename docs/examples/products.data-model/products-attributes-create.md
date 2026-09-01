```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsAttributesCreate(
    code: "net_weight",
    type: "select",
    config: [
        "reference_entity": "brand"
    ], // optional
    entity_ref: "brand", // optional
    entity_type: "product", // optional
    group_id: "", // optional
    is_filterable: true, // optional
    is_unique: true, // optional
    labels: [
        "de": "Nettogewicht",
        "en": "Net weight"
    ], // optional
    localizable: true, // optional
    position: 1, // optional
    scopable: true, // optional
    usable_in_grid: true, // optional
    validation: [
        "max_length": 64,
        "min_length": 3
    ] // optional
)

```
