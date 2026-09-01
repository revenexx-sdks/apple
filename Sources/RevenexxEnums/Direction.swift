import Foundation

public enum Direction: String, CustomStringConvertible {
    case `import` = "import"
    case export = "export"

    public var description: String {
        return rawValue
    }
}
