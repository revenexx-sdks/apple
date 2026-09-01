import Foundation

public enum AttributeValueBucket: String, CustomStringConvertible {
    case common = "common"
    case localeSpecific = "locale_specific"
    case channelSpecific = "channel_specific"
    case channelLocaleSpecific = "channel_locale_specific"

    public var description: String {
        return rawValue
    }
}
