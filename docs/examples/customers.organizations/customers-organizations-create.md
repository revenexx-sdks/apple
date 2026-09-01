```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersOrganizations = CustomersOrganizations(client)

let error = try await customersOrganizations.customersOrganizationsCreate(
    name: "Beispiel Industrietechnik GmbH",
    branche: "Maschinenbau", // optional
    credit_limit: 5000, // optional
    customer_number: "K-10042", // optional
    delivery_block: true, // optional
    lifecycle_stage: "customer", // optional
    payment_terms: "net_30", // optional
    price_list: "standard", // optional
    settings: [
        "account_manager": "sales-north",
        "delivery_tour": "tuesday",
        "self_pickup": true
    ], // optional
    status: .active, // optional
    vat_id: "DE123456789" // optional
)

```
