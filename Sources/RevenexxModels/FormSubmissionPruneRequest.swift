import Foundation
import JSONCodable
import RevenexxEnums

/// Retention sweep. Previews unless `dry_run` is explicitly false.
open class FormSubmissionPruneRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case dry_run = "dry_run"
        case form_slug = "form_slug"
        case older_than_days = "older_than_days"
        case status = "status"
    }

    /// Default TRUE. Nothing is deleted until this is explicitly false.
    public let dry_run: Bool?
    /// Narrow the sweep to one form.
    public let form_slug: String?
    /// Age threshold. Omit to use the retention floor. A value BELOW the floor is raised to it — the setting is the floor, not a default, and the floor is the LONGEST submission_retention_days configured anywhere in the tenant (see the operation description).
    public let older_than_days: Int?
    /// Narrow the sweep to one inbox status, e.g. 'spam'.
    public let status: RevenexxEnums.FormSubmissionPruneRequestStatus?

    init(
        dry_run: Bool?,
        form_slug: String?,
        older_than_days: Int?,
        status: RevenexxEnums.FormSubmissionPruneRequestStatus?
    ) {
        self.dry_run = dry_run
        self.form_slug = form_slug
        self.older_than_days = older_than_days
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.dry_run = try container.decodeIfPresent(Bool.self, forKey: .dry_run)
        self.form_slug = try container.decodeIfPresent(String.self, forKey: .form_slug)
        self.older_than_days = try container.decodeIfPresent(Int.self, forKey: .older_than_days)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.FormSubmissionPruneRequestStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(dry_run, forKey: .dry_run)
        try container.encodeIfPresent(form_slug, forKey: .form_slug)
        try container.encodeIfPresent(older_than_days, forKey: .older_than_days)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "dry_run": dry_run as Any,
            "form_slug": form_slug as Any,
            "older_than_days": older_than_days as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormSubmissionPruneRequest {
        return FormSubmissionPruneRequest(
            dry_run: map["dry_run"] as? Bool,
            form_slug: map["form_slug"] as? String,
            older_than_days: map["older_than_days"] as? Int,
            status: map["status"] as? String != nil ? FormSubmissionPruneRequestStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
