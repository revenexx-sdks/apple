```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingMethods = ShippingMethods(client)

let error = try await shippingMethods.shippingTiersList(
    method_id: "",
    limit: 1, // optional
    offset: 1, // optional
    order: "position.asc", // optional
    from_value: 10 // optional
)

```
