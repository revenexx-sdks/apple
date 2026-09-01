```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesCollaboration = PagesCollaboration(client)

let pageCommentList = try await pagesCollaboration.pagesEditorCommentsList(
    page_id: ""
)

```
