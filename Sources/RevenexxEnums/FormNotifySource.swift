import Foundation

public enum FormNotifySource: String, CustomStringConvertible {
    case form = "form"
    case tenant = "tenant"

    public var description: String {
        return rawValue
    }
}
