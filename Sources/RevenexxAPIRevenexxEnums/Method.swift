import Foundation

public enum Method: String, CustomStringConvertible {
    case gET = "GET"
    case pOST = "POST"
    case pUT = "PUT"
    case pATCH = "PATCH"
    case dELETE = "DELETE"
    case oPTIONS = "OPTIONS"
    case hEAD = "HEAD"

    public var description: String {
        return rawValue
    }
}
