```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let function = try await apps.appsCreate(
    functionId: "",
    name: "",
    runtime: .node180,
    commands: "npm install", // optional
    enabled: true, // optional
    entrypoint: "src/main.js", // optional
    events: [], // optional
    execute: ["any"], // optional
    installationId: "", // optional
    logging: true, // optional
    providerBranch: "main", // optional
    providerRepositoryId: "", // optional
    providerRootDirectory: "", // optional
    providerSilentMode: true, // optional
    schedule: "0 3 * * *", // optional
    scopes: [.sessionsWrite], // optional
    specification: "s-1vcpu-512mb", // optional
    timeout: 1 // optional
)

```
