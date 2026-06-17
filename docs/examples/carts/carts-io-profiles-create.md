```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let ioProfile = try await carts.cartsIoProfilesCreate(
    direction: .import,
    name: "",
    apply_mode: .insert, // optional
    entity: .carts, // optional
    format: .json, // optional
    is_template: false, // optional
    mapping: [:], // optional
    options: [:] // optional
)

```
