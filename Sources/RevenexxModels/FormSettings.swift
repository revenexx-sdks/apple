import Foundation
import JSONCodable

/// Everything about a form that is not a field: what the storefront renders around the inputs, what happens after a successful submit, and who is told about it. Open jsonb, so an unknown key is stored and handed back rather than refused — the keys below are the ones something actually READS, and each says which reader that is. Null on a form nobody has configured, which is not an error: every one of these has a fallback.
open class FormSettings<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case actions = "actions"
        case default_locale = "default_locale"
        case i18n = "i18n"
        case notify_email = "notify_email"
        case submit_label = "submit_label"
        case success_message = "success_message"
        case data
    }

    /// What the storefront runs after a successful submit, in order. Executed by the cover BFF, not by this API — this app only stores them, and a workflow that wants the same event should listen to `form.submitted` instead.
    public let actions: [FormPostSubmitAction<T>]?
    /// The language the definition itself is written in. Read by the storefront BFF, which overlays `i18n` on top of it.
    public let default_locale: String?
    /// Translations for the definition, keyed by language tag and then by field name: `{"en": {"email": {"label": "Email"}}}`. Only `label`, `placeholder` and `help` are overlaid — a translation of anything else is stored and ignored. Applied by the storefront BFF before the definition reaches the browser, so the API always returns the untranslated definition.
    public let i18n: [String: AnyCodable]?
    /// This form's own notification recipient, read by THIS app at insert. It beats the tenant's `notify_email` setting; null means fall back to the tenant. The storefront never sees it — the BFF hands the browser only the submit label and the success message.
    public let notify_email: String?
    /// The submit button caption, read by the storefront. Null falls back to 'Submit'.
    public let submit_label: String?
    /// What the visitor reads after a successful submit, read by the storefront. Null falls back to a generic thank-you.
    public let success_message: String?
    /// Additional properties
    public let data: T

    init(
        actions: [FormPostSubmitAction<T>]?,
        default_locale: String?,
        i18n: [String: AnyCodable]?,
        notify_email: String?,
        submit_label: String?,
        success_message: String?,
        data: T
    ) {
        self.actions = actions
        self.default_locale = default_locale
        self.i18n = i18n
        self.notify_email = notify_email
        self.submit_label = submit_label
        self.success_message = success_message
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.actions = try container.decodeIfPresent([FormPostSubmitAction<T>].self, forKey: .actions)
        self.default_locale = try container.decodeIfPresent(String.self, forKey: .default_locale)
        self.i18n = try container.decodeIfPresent([String: AnyCodable].self, forKey: .i18n)
        self.notify_email = try container.decodeIfPresent(String.self, forKey: .notify_email)
        self.submit_label = try container.decodeIfPresent(String.self, forKey: .submit_label)
        self.success_message = try container.decodeIfPresent(String.self, forKey: .success_message)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(actions, forKey: .actions)
        try container.encodeIfPresent(default_locale, forKey: .default_locale)
        try container.encodeIfPresent(i18n, forKey: .i18n)
        try container.encodeIfPresent(notify_email, forKey: .notify_email)
        try container.encodeIfPresent(submit_label, forKey: .submit_label)
        try container.encodeIfPresent(success_message, forKey: .success_message)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "actions": actions?.map { $0.toMap() } as Any,
            "default_locale": default_locale as Any,
            "i18n": i18n as Any,
            "notify_email": notify_email as Any,
            "submit_label": submit_label as Any,
            "success_message": success_message as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FormSettings {
        return FormSettings(
            actions: (map["actions"] as? [[String: Any]] ?? []).map { FormPostSubmitAction.from(map: $0) },
            default_locale: map["default_locale"] as? String,
            i18n: map["i18n"] as? [String: AnyCodable],
            notify_email: map["notify_email"] as? String,
            submit_label: map["submit_label"] as? String,
            success_message: map["success_message"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
