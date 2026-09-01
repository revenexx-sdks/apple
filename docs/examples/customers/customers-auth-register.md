```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customers = Customers(client)

let error = try await customers.customersAuthRegister(
    email: "einkauf@example.com",
    password: "",
    first_name: "Anna", // optional
    last_name: "Berger", // optional
    locale: "de-DE", // optional
    organization_id: "", // optional
    organization_name: "Beispiel Industrietechnik GmbH", // optional
    url: "https://shop.example.com/account", // optional
    vat_id: "DE123456789", // optional
    verification_url: "https://shop.example.com/bestaetigen" // optional
)

```
