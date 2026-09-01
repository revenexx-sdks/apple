```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersOrganizations = CustomersOrganizations(client)

let result = try await customersOrganizations.customersOrganizationMetricsList(
    id: "", // optional
    organization_id: "", // optional
    order_count: 1, // optional
    order_count_30d: 1, // optional
    order_count_90d: 1, // optional
    order_count_365d: 1, // optional
    revenue_total: 9.99, // optional
    revenue_30d: 9.99, // optional
    revenue_90d: 9.99, // optional
    revenue_365d: 9.99, // optional
    avg_order_value: 9.99, // optional
    avg_order_value_365d: 9.99, // optional
    first_order_at: "2026-01-01T12:00:00Z", // optional
    last_order_at: "2026-01-01T12:00:00Z", // optional
    currency: "EUR", // optional
    currency_mixed: true, // optional
    orders_as_of: "2026-01-01T12:00:00Z", // optional
    computed_at: "2026-01-01T12:00:00Z", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
