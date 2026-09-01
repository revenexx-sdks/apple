import Foundation

public enum ContactActivityKind: String, CustomStringConvertible {
    case note = "note"
    case call = "call"
    case email = "email"
    case meeting = "meeting"
    case visit = "visit"
    case task = "task"

    public var description: String {
        return rawValue
    }
}
