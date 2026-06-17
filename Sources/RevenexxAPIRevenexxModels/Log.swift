import Foundation
import JSONCodable

/// Log
open class Log: Codable {

    enum CodingKeys: String, CodingKey {
        case clientCode = "clientCode"
        case clientEngine = "clientEngine"
        case clientEngineVersion = "clientEngineVersion"
        case clientName = "clientName"
        case clientType = "clientType"
        case clientVersion = "clientVersion"
        case countryCode = "countryCode"
        case countryName = "countryName"
        case deviceBrand = "deviceBrand"
        case deviceModel = "deviceModel"
        case deviceName = "deviceName"
        case event = "event"
        case ip = "ip"
        case mode = "mode"
        case osCode = "osCode"
        case osName = "osName"
        case osVersion = "osVersion"
        case time = "time"
        case userEmail = "userEmail"
        case userId = "userId"
        case userName = "userName"
    }

    /// Client code name. View list of [available options](https://github.com/appwrite/appwrite/blob/master/docs/lists/clients.json).
    public let clientCode: String
    /// Client engine name.
    public let clientEngine: String
    /// Client engine name.
    public let clientEngineVersion: String
    /// Client name.
    public let clientName: String
    /// Client type.
    public let clientType: String
    /// Client version.
    public let clientVersion: String
    /// Country two-character ISO 3166-1 alpha code.
    public let countryCode: String
    /// Country name.
    public let countryName: String
    /// Device brand name.
    public let deviceBrand: String
    /// Device model name.
    public let deviceModel: String
    /// Device name.
    public let deviceName: String
    /// Event name.
    public let event: String
    /// IP session in use when the session was created.
    public let ip: String
    /// API mode when event triggered.
    public let mode: String
    /// Operating system code name. View list of [available options](https://github.com/appwrite/appwrite/blob/master/docs/lists/os.json).
    public let osCode: String
    /// Operating system name.
    public let osName: String
    /// Operating system version.
    public let osVersion: String
    /// Log creation date in ISO 8601 format.
    public let time: String
    /// User Email.
    public let userEmail: String
    /// User ID.
    public let userId: String
    /// User Name.
    public let userName: String

    init(
        clientCode: String,
        clientEngine: String,
        clientEngineVersion: String,
        clientName: String,
        clientType: String,
        clientVersion: String,
        countryCode: String,
        countryName: String,
        deviceBrand: String,
        deviceModel: String,
        deviceName: String,
        event: String,
        ip: String,
        mode: String,
        osCode: String,
        osName: String,
        osVersion: String,
        time: String,
        userEmail: String,
        userId: String,
        userName: String
    ) {
        self.clientCode = clientCode
        self.clientEngine = clientEngine
        self.clientEngineVersion = clientEngineVersion
        self.clientName = clientName
        self.clientType = clientType
        self.clientVersion = clientVersion
        self.countryCode = countryCode
        self.countryName = countryName
        self.deviceBrand = deviceBrand
        self.deviceModel = deviceModel
        self.deviceName = deviceName
        self.event = event
        self.ip = ip
        self.mode = mode
        self.osCode = osCode
        self.osName = osName
        self.osVersion = osVersion
        self.time = time
        self.userEmail = userEmail
        self.userId = userId
        self.userName = userName
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.clientCode = try container.decode(String.self, forKey: .clientCode)
        self.clientEngine = try container.decode(String.self, forKey: .clientEngine)
        self.clientEngineVersion = try container.decode(String.self, forKey: .clientEngineVersion)
        self.clientName = try container.decode(String.self, forKey: .clientName)
        self.clientType = try container.decode(String.self, forKey: .clientType)
        self.clientVersion = try container.decode(String.self, forKey: .clientVersion)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.countryName = try container.decode(String.self, forKey: .countryName)
        self.deviceBrand = try container.decode(String.self, forKey: .deviceBrand)
        self.deviceModel = try container.decode(String.self, forKey: .deviceModel)
        self.deviceName = try container.decode(String.self, forKey: .deviceName)
        self.event = try container.decode(String.self, forKey: .event)
        self.ip = try container.decode(String.self, forKey: .ip)
        self.mode = try container.decode(String.self, forKey: .mode)
        self.osCode = try container.decode(String.self, forKey: .osCode)
        self.osName = try container.decode(String.self, forKey: .osName)
        self.osVersion = try container.decode(String.self, forKey: .osVersion)
        self.time = try container.decode(String.self, forKey: .time)
        self.userEmail = try container.decode(String.self, forKey: .userEmail)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.userName = try container.decode(String.self, forKey: .userName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(clientCode, forKey: .clientCode)
        try container.encode(clientEngine, forKey: .clientEngine)
        try container.encode(clientEngineVersion, forKey: .clientEngineVersion)
        try container.encode(clientName, forKey: .clientName)
        try container.encode(clientType, forKey: .clientType)
        try container.encode(clientVersion, forKey: .clientVersion)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(countryName, forKey: .countryName)
        try container.encode(deviceBrand, forKey: .deviceBrand)
        try container.encode(deviceModel, forKey: .deviceModel)
        try container.encode(deviceName, forKey: .deviceName)
        try container.encode(event, forKey: .event)
        try container.encode(ip, forKey: .ip)
        try container.encode(mode, forKey: .mode)
        try container.encode(osCode, forKey: .osCode)
        try container.encode(osName, forKey: .osName)
        try container.encode(osVersion, forKey: .osVersion)
        try container.encode(time, forKey: .time)
        try container.encode(userEmail, forKey: .userEmail)
        try container.encode(userId, forKey: .userId)
        try container.encode(userName, forKey: .userName)
    }

    public func toMap() -> [String: Any] {
        return [
            "clientCode": clientCode as Any,
            "clientEngine": clientEngine as Any,
            "clientEngineVersion": clientEngineVersion as Any,
            "clientName": clientName as Any,
            "clientType": clientType as Any,
            "clientVersion": clientVersion as Any,
            "countryCode": countryCode as Any,
            "countryName": countryName as Any,
            "deviceBrand": deviceBrand as Any,
            "deviceModel": deviceModel as Any,
            "deviceName": deviceName as Any,
            "event": event as Any,
            "ip": ip as Any,
            "mode": mode as Any,
            "osCode": osCode as Any,
            "osName": osName as Any,
            "osVersion": osVersion as Any,
            "time": time as Any,
            "userEmail": userEmail as Any,
            "userId": userId as Any,
            "userName": userName as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Log {
        return Log(
            clientCode: map["clientCode"] as! String,
            clientEngine: map["clientEngine"] as! String,
            clientEngineVersion: map["clientEngineVersion"] as! String,
            clientName: map["clientName"] as! String,
            clientType: map["clientType"] as! String,
            clientVersion: map["clientVersion"] as! String,
            countryCode: map["countryCode"] as! String,
            countryName: map["countryName"] as! String,
            deviceBrand: map["deviceBrand"] as! String,
            deviceModel: map["deviceModel"] as! String,
            deviceName: map["deviceName"] as! String,
            event: map["event"] as! String,
            ip: map["ip"] as! String,
            mode: map["mode"] as! String,
            osCode: map["osCode"] as! String,
            osName: map["osName"] as! String,
            osVersion: map["osVersion"] as! String,
            time: map["time"] as! String,
            userEmail: map["userEmail"] as! String,
            userId: map["userId"] as! String,
            userName: map["userName"] as! String
        )
    }
}
