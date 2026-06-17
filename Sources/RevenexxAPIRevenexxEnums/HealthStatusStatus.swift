import Foundation

public enum HealthStatusStatus: String, CustomStringConvertible {
    case pass = "pass"
    case fail = "fail"

    public var description: String {
        return rawValue
    }
}
