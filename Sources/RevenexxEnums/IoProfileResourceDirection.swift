import Foundation

public enum IoProfileResourceDirection: String, CustomStringConvertible {
    case `import` = "import"
    case export = "export"

    public var description: String {
        return rawValue
    }
}
