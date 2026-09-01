import Foundation

public enum AvatarsGetCreditCardCode: String, CustomStringConvertible {
    case amex = "amex"
    case argencard = "argencard"
    case cabal = "cabal"
    case cencosud = "cencosud"
    case diners = "diners"
    case discover = "discover"
    case elo = "elo"
    case hipercard = "hipercard"
    case jcb = "jcb"
    case mastercard = "mastercard"
    case naranja = "naranja"
    case targetaShopping = "targeta-shopping"
    case unionpay = "unionpay"
    case visa = "visa"
    case mir = "mir"
    case maestro = "maestro"
    case rupay = "rupay"

    public var description: String {
        return rawValue
    }
}
