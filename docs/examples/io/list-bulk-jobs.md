```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let io = Io(client)

let validationFailedResponse = try await io.listBulkJobs(
    type: , // optional
    status: , // optional
    vendor: "", // optional
    app: "", // optional
    entity: "", // optional
    limit: 1 // optional
)

```
