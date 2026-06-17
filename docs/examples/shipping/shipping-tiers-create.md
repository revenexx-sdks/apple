```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shipping = Shipping(client)

let shippingRateTier = try await shipping.shippingTiersCreate(
    method_id: "",
    from_value: 0, // optional
    position: 0, // optional
    price: 0 // optional
)

```
