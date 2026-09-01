```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingMethods = ShippingMethods(client)

let shippingTaxClassUsage = try await shippingMethods.shippingTaxClassesUsage(
    code: "reduced"
)

```
