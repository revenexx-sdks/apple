```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingCarriers = ShippingCarriers(client)

let error = try await shippingCarriers.shippingCarriersList(
    limit: 1, // optional
    offset: 1, // optional
    order: "position.asc", // optional
    code: "acme-parcel", // optional
    status: .active, // optional
    service_level: "express" // optional
)

```
