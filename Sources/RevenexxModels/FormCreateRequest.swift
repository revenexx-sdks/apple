import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class FormCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case definition = "definition"
        case metadata = "metadata"
        case name = "name"
        case settings = "settings"
        case slug = "slug"
        case status = "status"
    }

    /// The form itself: a FormKit schema, held as a flat ARRAY of nodes (it defaults to `[]`, never to an object) and rendered verbatim by the storefront.
    /// 
    /// Read it as the field list. Every node carrying a non-empty `name` collects one value and writes it into a submission's `data` under exactly that name — the example below produces `{"company": …, "email": …, "message": …}` — while `$el` content nodes and `$rxStep` step markers collect nothing. Order is render order, and a `$rxStep` marker starts a new wizard step.
    /// 
    /// See the `FormKitNode` schema for what a node may carry.
    /// 
    /// On the way IN a node is any object: this is unconstrained jsonb, FormKit owns the grammar, and the one rule this app applies is the tenant's `max_form_fields` ceiling counted over the nodes with a non-empty `name`. Anything that is not an array at all is a 400.
    public let definition: [[String: AnyCodable]]?
    /// Free-form metadata on the FORM, which this app neither reads nor writes: yours to key however an integration needs, stored and returned verbatim. (The metadata this app does write is on a SUBMISSION — see `FormSubmissionMetadata`.)
    public let metadata: [String: AnyCodable]?
    /// What this form is called in the Cockpit's form list. Operator-facing only — the storefront never renders it, so renaming a form breaks no page.
    public let name: String
    /// Submit label, success message, per-form notify email, post-submit actions, translations — see the `FormSettings` schema for every key that is read. Unconstrained jsonb on the way in: nothing here is required and no key is refused.
    public let settings: [String: AnyCodable]?
    /// URL-safe identifier, unique per tenant. This is the name a storefront resolves a form by (`GET /v1/forms?slug=contact&status=live&limit=1`), so it is part of the page's contract: changing it changes which form a page renders. Lower-case letters, digits and inner hyphens. Taken already? That is the 409 — one slug answers for one form.
    public let slug: String
    /// Lifecycle. `draft` while it is being built; `live` once the storefront may render it — the cover BFF resolves live forms only, so a draft is a 404 on the storefront and never a broken page; `archived` for a form that is kept for its submissions but no longer offered. Default 'draft'.
    public let status: RevenexxEnums.FormStatus?

    init(
        definition: [[String: AnyCodable]]?,
        metadata: [String: AnyCodable]?,
        name: String,
        settings: [String: AnyCodable]?,
        slug: String,
        status: RevenexxEnums.FormStatus?
    ) {
        self.definition = definition
        self.metadata = metadata
        self.name = name
        self.settings = settings
        self.slug = slug
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.definition = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .definition)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decode(String.self, forKey: .name)
        self.settings = try container.decodeIfPresent([String: AnyCodable].self, forKey: .settings)
        self.slug = try container.decode(String.self, forKey: .slug)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.FormStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(definition, forKey: .definition)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(settings, forKey: .settings)
        try container.encode(slug, forKey: .slug)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "definition": definition as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "settings": settings as Any,
            "slug": slug as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormCreateRequest {
        return FormCreateRequest(
            definition: map["definition"] as? [[String: AnyCodable]],
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as! String,
            settings: map["settings"] as? [String: AnyCodable],
            slug: map["slug"] as! String,
            status: map["status"] as? String != nil ? FormStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
