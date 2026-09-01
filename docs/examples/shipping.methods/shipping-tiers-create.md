```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingMethods = ShippingMethods(client)

let error = try await shippingMethods.shippingTiersCreate(
    method_id: "",
    from_value: 10, // optional
    position: 1, // optional
    price: 6.9 // optional
)

```
