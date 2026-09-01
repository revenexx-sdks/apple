```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let storage = Storage(client)

let result = try await storage.syncRuleUpdate(
    id: "",
    enabled: true, // optional
    options: [], // optional
    schedule: "0 3 * * *", // optional
    sftp_account_id: "", // optional
    source_path: "/uploads", // optional
    target_folder_id: "" // optional
)

```
