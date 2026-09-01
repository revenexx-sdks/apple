```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesCollaboration = PagesCollaboration(client)

let pageCommentList = try await pagesCollaboration.pagesEditorCommentsCreate(
    page_id: "",
    body: "<p>Please shorten this headline.</p>",
    blockUuids: [], // optional
    parentUuid: "" // optional
)

```
