```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customers = Customers(client)

let address = try await customers.customersAddressesUpdate(
    id: "",
    city: "", // optional
    company: "", // optional
    contact_id: "", // optional
    country: "", // optional
    is_default: false, // optional
    name: "", // optional
    organization_id: "", // optional
    phone: "", // optional
    region: "", // optional
    street: "", // optional
    street2: "", // optional
    type: .billing, // optional
    zip: "" // optional
)

```
