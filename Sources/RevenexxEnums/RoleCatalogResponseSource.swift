import Foundation

public enum RoleCatalogResponseSource: String, CustomStringConvertible {
    case tenant = "tenant"
    case defaults = "defaults"

    public var description: String {
        return rawValue
    }
}
