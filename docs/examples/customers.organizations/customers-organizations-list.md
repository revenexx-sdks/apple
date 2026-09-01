```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersOrganizations = CustomersOrganizations(client)

let result = try await customersOrganizations.customersOrganizationsList(
    id: "", // optional
    name: "Beispiel Industrietechnik GmbH", // optional
    vat_id: "DE123456789", // optional
    branche: "Maschinenbau", // optional
    customer_number: "K-10042", // optional
    status: .active, // optional
    lifecycle_stage: "customer", // optional
    payment_terms: "net_30", // optional
    credit_limit: 9.99, // optional
    price_list: "standard", // optional
    delivery_block: true, // optional
    external_team_id: "", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
