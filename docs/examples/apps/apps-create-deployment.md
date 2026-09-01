```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let deployment = try await apps.appsCreateDeployment(
    functionId: "",
    activate: true,
    code: InputFile.fromPath("file.png"),
    commands: "", // optional
    entrypoint: "" // optional
)

```
