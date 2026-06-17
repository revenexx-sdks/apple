```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let tokens = Tokens(client)

let resourceToken = try await tokens.tokensCreateFileToken(
    bucketId: "",
    fileId: "",
    expire: "" // optional
)

```
