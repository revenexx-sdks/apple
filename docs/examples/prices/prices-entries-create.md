```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let priceEntry = try await prices.pricesEntriesCreate(
    list_id: "",
    metadata: [:], // optional
    price_type: .standard, // optional
    product_id: "", // optional
    quantity_min: 0, // optional
    sku: "", // optional
    unit: "", // optional
    unit_price: 0, // optional
    valid_from: "", // optional
    valid_until: "" // optional
)

```
