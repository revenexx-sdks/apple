```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersOrganizations = CustomersOrganizations(client)

let result = try await customersOrganizations.customersAddressesList(
    id: "", // optional
    organization_id: "", // optional
    contact_id: "", // optional
    type: "shipping", // optional
    company: "Beispiel Industrietechnik GmbH", // optional
    name: "Anna Berger", // optional
    street: "Musterstraße 12", // optional
    street2: "Gebäude C, 2. OG", // optional
    zip: "10115", // optional
    city: "Berlin", // optional
    region: "Berlin", // optional
    country: "DE", // optional
    phone: "+49 30 5550123", // optional
    is_default: true, // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
