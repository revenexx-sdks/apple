```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let search = Search(client)

let error = try await search.searchSearchDocuments(
    collection: .products,
    exclude_fields: "", // optional
    facet_by: "", // optional
    filter_by: "", // optional
    group_by: "", // optional
    highlight_full_fields: "", // optional
    include_fields: "", // optional
    max_facet_values: 1, // optional
    num_typos: 1, // optional
    page: 1, // optional
    per_page: 1, // optional
    prefix: "", // optional
    q: "", // optional
    query_by: "", // optional
    sort_by: "" // optional
)

```
