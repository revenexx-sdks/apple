import Foundation

public enum Code: String, CustomStringConvertible {
    case aa = "aa"
    case an = "an"
    case ch = "ch"
    case ci = "ci"
    case cm = "cm"
    case cr = "cr"
    case ff = "ff"
    case sf = "sf"
    case mf = "mf"
    case ps = "ps"
    case oi = "oi"
    case om = "om"
    case op = "op"
    case on = "on"

    public var description: String {
        return rawValue
    }
}
