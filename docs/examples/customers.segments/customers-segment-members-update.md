```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersSegments = CustomersSegments(client)

let error = try await customersSegments.customersSegmentMembersUpdate(
    id: "",
    organization_id: "", // optional
    segment_id: "", // optional
    source: .manual // optional
)

```
