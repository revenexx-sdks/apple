```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsAssets = ProductsAssets(client)

let error = try await productsAssets.productsAssetsUpdate(
    id: "",
    asset_family_id: "", // optional
    attribute_values: [
        "common": [
            "copyright": "© Acme Tools",
            "expires_on": "2028-12-31"
        ],
        "locale_specific": [
            "de_DE": [
                "alt_text": "Akku-Bohrschrauber, freigestellt"
            ]
        ]
    ], // optional
    code: "acme-4711-blk_packshot_1", // optional
    delivery_path: "packshots/acme-4711-blk_1.jpg", // optional
    external_url: "https://cdn.example.com/packshots/acme-4711-blk_1.jpg", // optional
    source: .storage, // optional
    storage_asset_id: "ast_01J8ZQ0000000000000000" // optional
)

```
