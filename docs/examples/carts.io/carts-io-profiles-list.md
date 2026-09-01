```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let cartsIo = CartsIo(client)

let error = try await cartsIo.cartsIoProfilesList(
    id: "", // optional
    name: "cart-export-csv", // optional
    direction: .import, // optional
    entity: .carts, // optional
    format: .json, // optional
    apply_mode: .insert, // optional
    is_template: true, // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
