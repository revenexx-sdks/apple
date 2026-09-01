```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsCategories = ProductsCategories(client)

let error = try await productsCategories.productsCategoriesCreate(
    code: "cordless_drills",
    labels: [
        "de": "Akku-Bohrschrauber",
        "en": "Cordless drills"
    ], // optional
    parent_id: "", // optional
    path: "tools/power_tools/cordless_drills", // optional
    position: 1, // optional
    rule_match: .all, // optional
    rules: [
        "conditions": [
            "0": [
                "field": "attribute:brand",
                "operator": "in",
                "value": [
                    "0": "acme",
                    "1": "globex"
                ]
            ],
            "1": [
                "field": "enabled",
                "operator": "eq",
                "value": true
            ]
        ]
    ], // optional
    rules_computed_at: "2026-01-01T12:00:00Z", // optional
    values: [
        "hero_asset": "packshots/cordless_drills_hero",
        "seo_title": "Cordless drills"
    ] // optional
)

```
