import Foundation

public enum CartIoDirection: String, CustomStringConvertible {
    case `import` = "import"
    case export = "export"

    public var description: String {
        return rawValue
    }
}
