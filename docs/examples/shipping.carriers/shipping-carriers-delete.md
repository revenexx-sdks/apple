```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingCarriers = ShippingCarriers(client)

let error = try await shippingCarriers.shippingCarriersDelete(
    id: ""
)

```
