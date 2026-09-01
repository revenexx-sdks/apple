```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let channels = Channels(client)

let channelVocabularyIndex = try await channels.channelsVocabulariesList()

```
