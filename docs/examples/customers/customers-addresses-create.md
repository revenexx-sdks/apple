```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customers = Customers(client)

let address = try await customers.customersAddressesCreate(
    city: "",
    country: "",
    street: "",
    zip: "",
    company: "", // optional
    contact_id: "", // optional
    is_default: false, // optional
    name: "", // optional
    organization_id: "", // optional
    phone: "", // optional
    region: "", // optional
    street2: "", // optional
    type: .billing // optional
)

```
