```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customers = Customers(client)

let contact = try await customers.customersContactsUpdate(
    id: "",
    email: "", // optional
    first_name: "", // optional
    is_primary: false, // optional
    last_name: "", // optional
    locale: "", // optional
    organization_id: "", // optional
    phone: "", // optional
    role: .buyer, // optional
    status: .invited // optional
)

```
