```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let cartsIo = CartsIo(client)

let error = try await cartsIo.cartsIoProfilesCreate(
    direction: .import,
    name: "cart-export-csv",
    apply_mode: .insert, // optional
    entity: .carts, // optional
    format: .json, // optional
    is_template: true, // optional
    mapping: [:], // optional
    options: [:] // optional
)

```
