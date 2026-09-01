import Foundation

public enum CustomersVocabulariesGetName: String, CustomStringConvertible {
    case addressTypes = "address-types"
    case contactEventKinds = "contact-event-kinds"
    case contactStatuses = "contact-statuses"
    case lifecycleStages = "lifecycle-stages"
    case locales = "locales"
    case organizationStatuses = "organization-statuses"
    case paymentTerms = "payment-terms"
    case registrationStatuses = "registration-statuses"
    case roles = "roles"
    case ruleMatches = "rule-matches"
    case segmentSources = "segment-sources"

    public var description: String {
        return rawValue
    }
}
