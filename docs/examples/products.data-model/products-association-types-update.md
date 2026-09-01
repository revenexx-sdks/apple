```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsAssociationTypesUpdate(
    id: "",
    code: "cross_sell", // optional
    is_quantified: true, // optional
    is_two_way: true, // optional
    labels: [
        "de": "Querverkauf",
        "en": "Cross-sell"
    ] // optional
)

```
