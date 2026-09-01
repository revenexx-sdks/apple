```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersOrganizations = CustomersOrganizations(client)

let error = try await customersOrganizations.customersOrganizationMetricsRefresh(
    as_of: "2026-01-01T12:00:00Z", // optional
    cursor: "", // optional
    organization_ids: [] // optional
)

```
