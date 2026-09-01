```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let sites = Sites(client)

let site = try await sites.sitesCreate(
    buildRuntime: .node180,
    framework: .analog,
    name: "",
    siteId: "",
    adapter: .static, // optional
    buildCommand: "npm run build", // optional
    enabled: true, // optional
    fallbackFile: "index.html", // optional
    installCommand: "npm install", // optional
    installationId: "", // optional
    logging: true, // optional
    outputDirectory: "", // optional
    providerBranch: "main", // optional
    providerRepositoryId: "", // optional
    providerRootDirectory: "", // optional
    providerSilentMode: true, // optional
    specification: "s-1vcpu-512mb", // optional
    timeout: 1 // optional
)

```
