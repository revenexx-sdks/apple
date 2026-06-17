```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let referenceEntityRecords = try await products.productsReferenceEntityRecordsUpdate(
    id: "",
    attribute_values: [:], // optional
    code: "", // optional
    labels: [:], // optional
    reference_entity_id: "" // optional
)

```
