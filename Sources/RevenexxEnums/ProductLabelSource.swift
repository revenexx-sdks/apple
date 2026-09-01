import Foundation

public enum ProductLabelSource: String, CustomStringConvertible {
    case common = "common"
    case localeSpecific = "locale_specific"
    case channelSpecific = "channel_specific"
    case channelLocaleSpecific = "channel_locale_specific"
    case sku = "sku"

    public var description: String {
        return rawValue
    }
}
