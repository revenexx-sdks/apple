```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

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
    buildCommand: "", // optional
    enabled: false, // optional
    fallbackFile: "", // optional
    installCommand: "", // optional
    installationId: "", // optional
    logging: false, // optional
    outputDirectory: "", // optional
    providerBranch: "", // optional
    providerRepositoryId: "", // optional
    providerRootDirectory: "", // optional
    providerSilentMode: false, // optional
    specification: "", // optional
    timeout: 0 // optional
)

```
