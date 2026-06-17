```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let search = Search(client)

let result = try await search.searchSearchDocumentsGet(
    collection: .greetings,
    q: "", // optional
    query_by: "", // optional
    filter_by: "", // optional
    sort_by: "", // optional
    page: 0, // optional
    per_page: 0 // optional
)

```
