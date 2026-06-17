import Foundation

public enum UseCases: String, CustomStringConvertible {
    case starter = "starter"
    case databases = "databases"
    case ai = "ai"
    case messaging = "messaging"
    case utilities = "utilities"
    case devTools = "dev-tools"
    case auth = "auth"

    public var description: String {
        return rawValue
    }
}
