import Foundation
import JSONCodable
import RevenexxEnums

/// Free-form metadata, plus what this app stamped on at insert. The recipient is resolved ONCE, here, because this row is the payload of `form.submitted` — a workflow reads the address off the event instead of re-resolving a form's settings that may since have changed.
open class FormSubmissionMetadata<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case notify_email = "notify_email"
        case notify_source = "notify_source"
        case spam_reason = "spam_reason"
        case data
    }

    /// The resolved notification recipient, or null when neither the form nor the tenant names one.
    public let notify_email: String?
    /// Which of the two configured recipients won: the form's own, or the tenant setting.
    public let notify_source: RevenexxEnums.FormNotifySource?
    /// Present only on a submission the honeypot caught: 'honeypot'.
    public let spam_reason: String?
    /// Additional properties
    public let data: T

    init(
        notify_email: String?,
        notify_source: RevenexxEnums.FormNotifySource?,
        spam_reason: String?,
        data: T
    ) {
        self.notify_email = notify_email
        self.notify_source = notify_source
        self.spam_reason = spam_reason
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.notify_email = try container.decodeIfPresent(String.self, forKey: .notify_email)
        if let notify_sourceString = try container.decodeIfPresent(String.self, forKey: .notify_source) {
            self.notify_source = RevenexxEnums.FormNotifySource(rawValue: notify_sourceString)
        } else {
            self.notify_source = nil
        }
        self.spam_reason = try container.decodeIfPresent(String.self, forKey: .spam_reason)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(notify_email, forKey: .notify_email)
        try container.encodeIfPresent(notify_source?.rawValue, forKey: .notify_source)
        try container.encodeIfPresent(spam_reason, forKey: .spam_reason)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "notify_email": notify_email as Any,
            "notify_source": notify_source?.rawValue as Any,
            "spam_reason": spam_reason as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FormSubmissionMetadata {
        return FormSubmissionMetadata(
            notify_email: map["notify_email"] as? String,
            notify_source: map["notify_source"] as? String != nil ? FormNotifySource(rawValue: map["notify_source"] as! String) : nil,
            spam_reason: map["spam_reason"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
