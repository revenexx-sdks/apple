```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let familyAttributes = try await products.productsFamilyAttributesUpdate(
    id: "",
    attribute_id: "", // optional
    family_id: "", // optional
    is_required: false, // optional
    position: 0, // optional
    required_channels: [:] // optional
)

```
