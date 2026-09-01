import Foundation
import JSONCodable

/// One node of a form definition.
/// 
/// A definition is a FLAT ARRAY of these, and the storefront hands each one to `<FormKitSchema>` verbatim — it maps nothing, so every key FormKit understands works here whether or not it is named below (`options`, `if`, `rows`, `autocomplete`, `min`, `max`, `$cmp`, …). Three kinds of node occur:
/// 
///   • an INPUT node (`$formkit`) collects a value and, if it carries a `name`, contributes exactly one key to a submission's `data`;
///   • a CONTENT node (`$el`) renders markup — a paragraph of legal text, a heading — and collects nothing;
///   • a STEP MARKER (`$rxStep`) is a Revenexx extension the storefront consumes and strips before FormKit sees the node; it splits the flat array into wizard steps.
/// 
/// Only the four keys `name`, `label`, `placeholder` and `help` are read by Revenexx code at all (the last three are what the per-form i18n overlay translates). Everything else is FormKit's business.
open class FormKitNode<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case el = "$el"
        case formkit = "$formkit"
        case rxStep = "$rxStep"
        case children = "children"
        case help = "help"
        case label = "label"
        case name = "name"
        case placeholder = "placeholder"
        case rxKind = "rxKind"
        case validation = "validation"
        case data
    }

    /// A CONTENT node instead of an input: a raw element name ('p', 'h2', 'div'). It collects no value and contributes no key to `data`.
    public let el: String?
    /// An INPUT node: the FormKit input type — 'text', 'email', 'textarea', 'number', 'select', 'checkbox', 'radio', 'date', 'group', 'list', … . The set is FormKit's, not this app's, which is why nothing here enforces it and no vocabulary is published for it; the storefront adds one input of its own, `datepicker`, and three validation rules (`zip`, `companyName`, `phoneNumber`).
    public let formkit: String?
    /// A Revenexx step marker. The storefront cuts the flat array at each marker and renders the nodes that follow it as one wizard step, then removes the marker before FormKit renders anything. A definition with no marker is a single-step form.
    public let rxStep: FormKitStepMarker<T>?
    /// The content of an `$el` node: a string of text, or nested nodes.
    public let children: String?
    /// The hint under the input. Translatable.
    public let help: String?
    /// What the visitor reads above the input. Translatable: the per-form i18n overlay replaces it per locale.
    public let label: String?
    /// The key this input writes into a submission's `data` — `{ "$formkit": "email", "name": "email" }` here is the `"email"` key there, and that correspondence is the whole contract between a form and its inbox. A node with a non-empty `name` is a FIELD: only fields count against the tenant's `max_form_fields`, so a form with twenty paragraphs of legal text and three inputs is a three-field form. A `group` or `list` input nests, and its `name` keys the nested object or array.
    public let name: String?
    /// Placeholder text inside the input. Translatable.
    public let placeholder: String?
    /// A Revenexx hint about where the value comes from rather than what it looks like. 'product' means the storefront prefills this input from the page context or the query string (`?sku=…`) and renders it read-only — how a price request knows which article it is about. Stripped before FormKit renders the node.
    public let rxKind: String?
    /// FormKit validation, in either notation FormKit accepts: the pipe string 'required|email', or the array form. It is enforced in the browser by FormKit — this API stores whatever `data` it is sent, so a server-side integration must not treat it as a guarantee.
    public let validation: String?
    /// Additional properties
    public let data: T

    init(
        el: String?,
        formkit: String?,
        rxStep: FormKitStepMarker<T>?,
        children: String?,
        help: String?,
        label: String?,
        name: String?,
        placeholder: String?,
        rxKind: String?,
        validation: String?,
        data: T
    ) {
        self.el = el
        self.formkit = formkit
        self.rxStep = rxStep
        self.children = children
        self.help = help
        self.label = label
        self.name = name
        self.placeholder = placeholder
        self.rxKind = rxKind
        self.validation = validation
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.el = try container.decodeIfPresent(String.self, forKey: .el)
        self.formkit = try container.decodeIfPresent(String.self, forKey: .formkit)
        self.rxStep = try container.decodeIfPresent(FormKitStepMarker<T>.self, forKey: .rxStep)
        self.children = try container.decodeIfPresent(String.self, forKey: .children)
        self.help = try container.decodeIfPresent(String.self, forKey: .help)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.placeholder = try container.decodeIfPresent(String.self, forKey: .placeholder)
        self.rxKind = try container.decodeIfPresent(String.self, forKey: .rxKind)
        self.validation = try container.decodeIfPresent(String.self, forKey: .validation)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(el, forKey: .el)
        try container.encodeIfPresent(formkit, forKey: .formkit)
        try container.encodeIfPresent(rxStep, forKey: .rxStep)
        try container.encodeIfPresent(children, forKey: .children)
        try container.encodeIfPresent(help, forKey: .help)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(placeholder, forKey: .placeholder)
        try container.encodeIfPresent(rxKind, forKey: .rxKind)
        try container.encodeIfPresent(validation, forKey: .validation)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "$el": el as Any,
            "$formkit": formkit as Any,
            "$rxStep": rxStep?.toMap() as Any,
            "children": children as Any,
            "help": help as Any,
            "label": label as Any,
            "name": name as Any,
            "placeholder": placeholder as Any,
            "rxKind": rxKind as Any,
            "validation": validation as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FormKitNode {
        return FormKitNode(
            el: map["$el"] as? String,
            formkit: map["$formkit"] as? String,
            rxStep: FormKitStepMarker.from(map: map["$rxStep"] as! [String: Any]),
            children: map["children"] as? String,
            help: map["help"] as? String,
            label: map["label"] as? String,
            name: map["name"] as? String,
            placeholder: map["placeholder"] as? String,
            rxKind: map["rxKind"] as? String,
            validation: map["validation"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
