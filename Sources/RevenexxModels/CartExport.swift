import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class CartExport: Codable {

    enum CodingKeys: String, CodingKey {
        case content = "content"
        case filename = "filename"
        case format = "format"
    }

    /// The export itself. For json: `{ "cart": { name, status, currency, channel_id, item_count, subtotal }, "items": [ … ] }` — exactly what carts.import takes back, so an export round-trips. For csv: the lines as a CSV string, header first, with jsonb columns serialized as JSON text. Deliberately untyped, because a profile's mapping renames the columns and that mapping is the caller's own.
    public let content: String?
    /// A suggested download name, built as `cart-<cart id>.<format>`. Nothing is stored under it; it is there so a browser download has a name that says which cart it is.
    public let filename: String?
    /// The format that ran — the profile's, or the ad-hoc one.
    public let format: RevenexxEnums.CartIoFormat?

    init(
        content: String?,
        filename: String?,
        format: RevenexxEnums.CartIoFormat?
    ) {
        self.content = content
        self.filename = filename
        self.format = format
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.filename = try container.decodeIfPresent(String.self, forKey: .filename)
        if let formatString = try container.decodeIfPresent(String.self, forKey: .format) {
            self.format = RevenexxEnums.CartIoFormat(rawValue: formatString)
        } else {
            self.format = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(content, forKey: .content)
        try container.encodeIfPresent(filename, forKey: .filename)
        try container.encodeIfPresent(format?.rawValue, forKey: .format)
    }

    public func toMap() -> [String: Any] {
        return [
            "content": content as Any,
            "filename": filename as Any,
            "format": format?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartExport {
        return CartExport(
            content: map["content"] as? String,
            filename: map["filename"] as? String,
            format: map["format"] as? String != nil ? CartIoFormat(rawValue: map["format"] as! String) : nil
        )
    }
}
