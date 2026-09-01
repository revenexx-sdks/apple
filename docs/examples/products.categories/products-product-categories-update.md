```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsCategories = ProductsCategories(client)

let error = try await productsCategories.productsProductCategoriesUpdate(
    id: "",
    category_id: "", // optional
    position: 1, // optional
    product_id: "", // optional
    source: .manual // optional
)

```
