```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let tokens = Tokens(client)

let resourceTokenList = try await tokens.tokensList(
    bucketId: "",
    fileId: "",
    queries: [], // optional
    total: false // optional
)

```
