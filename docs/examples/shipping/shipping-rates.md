```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shipping = Shipping(client)

let result = try await shipping.shippingRates(
    attributes: [:], // optional
    country: "", // optional
    currency: "", // optional
    market_id: "", // optional
    order_value: 0, // optional
    quantity: 0, // optional
    weight: 0 // optional
)

```
