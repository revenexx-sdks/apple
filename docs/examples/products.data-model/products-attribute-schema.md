```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsAttributeSchema(
    family_id: "", // optional
    family_code: "", // optional
    entity_type: .product, // optional
    entity_ref: "brand", // optional
    locale: "de_DE", // optional
    channel: "b2b", // optional
    kind: .simple // optional
)

```
