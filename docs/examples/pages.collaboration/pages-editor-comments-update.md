```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesCollaboration = PagesCollaboration(client)

let error = try await pagesCollaboration.pagesEditorCommentsUpdate(
    page_id: "",
    uuid: "",
    body: "<p>Please shorten this headline.</p>"
)

```
