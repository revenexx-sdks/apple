import Foundation

public enum PaymentsVocabulariesGetName: String, CustomStringConvertible {
    case dunningStages = "dunning-stages"
    case feeTypes = "fee-types"
    case methodKinds = "method-kinds"
    case statuses = "statuses"

    public var description: String {
        return rawValue
    }
}
