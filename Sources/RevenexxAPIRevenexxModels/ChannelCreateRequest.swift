import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// 
open class ChannelCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case status = "status"
        case type = "type"
    }

    /// Stable channel code, unique per tenant (e.g. shop, punchout-acme).
    public let code: String
    /// Mark as the default channel (default false).
    public let is_default: Bool?
    /// Localized display names keyed by locale.
    public let labels: [String: AnyCodable]?
    /// Display name.
    public let name: String
    /// Sort position (default 0).
    public let position: Int?
    /// Lifecycle status (default &#039;active&#039;).
    public let status: Revenexx API — revenexxEnums.ChannelStatus?
    /// Where business happens (default &#039;storefront&#039;).
    public let type: Revenexx API — revenexxEnums.ChannelType?

    init(
        code: String,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        name: String,
        position: Int?,
        status: Revenexx API — revenexxEnums.ChannelStatus?,
        type: Revenexx API — revenexxEnums.ChannelType?
    ) {
        self.code = code
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.status = status
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decode(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = Revenexx API — revenexxEnums.ChannelStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = Revenexx API — revenexxEnums.ChannelType(rawValue: typeString)
        } else {
            self.type = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "status": status?.rawValue as Any,
            "type": type?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelCreateRequest {
        return ChannelCreateRequest(
            code: map["code"] as! String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as! String,
            position: map["position"] as? Int,
            status: map["status"] as? String != nil ? ChannelStatus(rawValue: map["status"] as! String) : nil,
            type: map["type"] as? String != nil ? ChannelType(rawValue: map["type"] as! String) : nil
        )
    }
}
