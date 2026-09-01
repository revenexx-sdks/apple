import Foundation

public enum OrdersVocabulariesGetName: String, CustomStringConvertible {
    case cancellationScopes = "cancellation-scopes"
    case commentVisibilities = "comment-visibilities"
    case fulfillmentStatuses = "fulfillment-statuses"
    case itemTypes = "item-types"
    case paymentStatuses = "payment-statuses"
    case returnResolutions = "return-resolutions"
    case returnStatuses = "return-statuses"
    case statuses = "statuses"

    public var description: String {
        return rawValue
    }
}
