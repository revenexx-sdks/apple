```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let function = try await apps.appsCreate(
    functionId: "",
    name: "",
    runtime: .node180,
    commands: "", // optional
    enabled: false, // optional
    entrypoint: "", // optional
    events: [], // optional
    execute: [], // optional
    installationId: "", // optional
    logging: false, // optional
    providerBranch: "", // optional
    providerRepositoryId: "", // optional
    providerRootDirectory: "", // optional
    providerSilentMode: false, // optional
    schedule: "", // optional
    scopes: [.sessionsWrite], // optional
    specification: "", // optional
    timeout: 0 // optional
)

```
