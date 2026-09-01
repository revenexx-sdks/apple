```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let error = try await prices.pricesEntriesLadder(
    list_id: "",
    base_price: 9.99,
    discount_percent: 9.99, // optional
    product_id: "", // optional
    quantities: [1,10,50], // optional
    replace: true, // optional
    rounding: .exact, // optional
    sku: "BOLT-M8-30", // optional
    unit: "pcs" // optional
)

```
