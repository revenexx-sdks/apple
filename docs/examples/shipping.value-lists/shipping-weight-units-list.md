```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingValueLists = ShippingValueLists(client)

let result = try await shippingValueLists.shippingWeightUnitsList(
    limit: 1, // optional
    offset: 1 // optional
)

```
