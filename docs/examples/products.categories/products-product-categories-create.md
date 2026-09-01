```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsCategories = ProductsCategories(client)

let error = try await productsCategories.productsProductCategoriesCreate(
    category_id: "",
    product_id: "",
    position: 1, // optional
    source: .manual // optional
)

```
