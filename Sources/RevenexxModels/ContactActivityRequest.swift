import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ContactActivityRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case actor = "actor"
        case kind = "kind"
        case note = "note"
        case occurred_at = "occurred_at"
        case subject = "subject"
    }

    /// Who logged it (operator id or email). Free text; this app does not resolve it.
    public let actor: String?
    /// What happened. 'system' is deliberately NOT accepted — those rows are the registration decision trail and are written by the approve/reject routes. Default 'note'.
    public let kind: RevenexxEnums.ContactActivityKind?
    /// The long form. Stored inside the event payload as `note`, not as a column of its own.
    public let note: String?
    /// When it actually happened. Defaults to now — a call logged on Monday about Friday should say Friday.
    public let occurred_at: String?
    /// One line a person can scan in a timeline. Required — an entry nobody can read at a glance is not worth the row.
    public let subject: String

    init(
        actor: String?,
        kind: RevenexxEnums.ContactActivityKind?,
        note: String?,
        occurred_at: String?,
        subject: String
    ) {
        self.actor = actor
        self.kind = kind
        self.note = note
        self.occurred_at = occurred_at
        self.subject = subject
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.actor = try container.decodeIfPresent(String.self, forKey: .actor)
        if let kindString = try container.decodeIfPresent(String.self, forKey: .kind) {
            self.kind = RevenexxEnums.ContactActivityKind(rawValue: kindString)
        } else {
            self.kind = nil
        }
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        self.occurred_at = try container.decodeIfPresent(String.self, forKey: .occurred_at)
        self.subject = try container.decode(String.self, forKey: .subject)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(actor, forKey: .actor)
        try container.encodeIfPresent(kind?.rawValue, forKey: .kind)
        try container.encodeIfPresent(note, forKey: .note)
        try container.encodeIfPresent(occurred_at, forKey: .occurred_at)
        try container.encode(subject, forKey: .subject)
    }

    public func toMap() -> [String: Any] {
        return [
            "actor": actor as Any,
            "kind": kind?.rawValue as Any,
            "note": note as Any,
            "occurred_at": occurred_at as Any,
            "subject": subject as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ContactActivityRequest {
        return ContactActivityRequest(
            actor: map["actor"] as? String,
            kind: map["kind"] as? String != nil ? ContactActivityKind(rawValue: map["kind"] as! String) : nil,
            note: map["note"] as? String,
            occurred_at: map["occurred_at"] as? String,
            subject: map["subject"] as! String
        )
    }
}
