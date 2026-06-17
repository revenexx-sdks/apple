import Foundation
import JSONCodable

/// Session
open class Session: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case clientCode = "clientCode"
        case clientEngine = "clientEngine"
        case clientEngineVersion = "clientEngineVersion"
        case clientName = "clientName"
        case clientType = "clientType"
        case clientVersion = "clientVersion"
        case countryCode = "countryCode"
        case countryName = "countryName"
        case current = "current"
        case deviceBrand = "deviceBrand"
        case deviceModel = "deviceModel"
        case deviceName = "deviceName"
        case expire = "expire"
        case factors = "factors"
        case ip = "ip"
        case mfaUpdatedAt = "mfaUpdatedAt"
        case osCode = "osCode"
        case osName = "osName"
        case osVersion = "osVersion"
        case provider = "provider"
        case providerAccessToken = "providerAccessToken"
        case providerAccessTokenExpiry = "providerAccessTokenExpiry"
        case providerRefreshToken = "providerRefreshToken"
        case providerUid = "providerUid"
        case secret = "secret"
        case userId = "userId"
    }

    /// Session creation date in ISO 8601 format.
    public let createdAt: String
    /// Session ID.
    public let id: String
    /// Session update date in ISO 8601 format.
    public let updatedAt: String
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
    /// Returns true if this the current user session.
    public let current: Bool
    /// Device brand name.
    public let deviceBrand: String
    /// Device model name.
    public let deviceModel: String
    /// Device name.
    public let deviceName: String
    /// Session expiration date in ISO 8601 format.
    public let expire: String
    /// Returns a list of active session factors.
    public let factors: [String]
    /// IP in use when the session was created.
    public let ip: String
    /// Most recent date in ISO 8601 format when the session successfully passed MFA challenge.
    public let mfaUpdatedAt: String
    /// Operating system code name. View list of [available options](https://github.com/appwrite/appwrite/blob/master/docs/lists/os.json).
    public let osCode: String
    /// Operating system name.
    public let osName: String
    /// Operating system version.
    public let osVersion: String
    /// Session Provider.
    public let provider: String
    /// Session Provider Access Token.
    public let providerAccessToken: String
    /// The date of when the access token expires in ISO 8601 format.
    public let providerAccessTokenExpiry: String
    /// Session Provider Refresh Token.
    public let providerRefreshToken: String
    /// Session Provider User ID.
    public let providerUid: String
    /// Secret used to authenticate the user. Only included if the request was made with an API key
    public let secret: String
    /// User ID.
    public let userId: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        clientCode: String,
        clientEngine: String,
        clientEngineVersion: String,
        clientName: String,
        clientType: String,
        clientVersion: String,
        countryCode: String,
        countryName: String,
        current: Bool,
        deviceBrand: String,
        deviceModel: String,
        deviceName: String,
        expire: String,
        factors: [String],
        ip: String,
        mfaUpdatedAt: String,
        osCode: String,
        osName: String,
        osVersion: String,
        provider: String,
        providerAccessToken: String,
        providerAccessTokenExpiry: String,
        providerRefreshToken: String,
        providerUid: String,
        secret: String,
        userId: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.clientCode = clientCode
        self.clientEngine = clientEngine
        self.clientEngineVersion = clientEngineVersion
        self.clientName = clientName
        self.clientType = clientType
        self.clientVersion = clientVersion
        self.countryCode = countryCode
        self.countryName = countryName
        self.current = current
        self.deviceBrand = deviceBrand
        self.deviceModel = deviceModel
        self.deviceName = deviceName
        self.expire = expire
        self.factors = factors
        self.ip = ip
        self.mfaUpdatedAt = mfaUpdatedAt
        self.osCode = osCode
        self.osName = osName
        self.osVersion = osVersion
        self.provider = provider
        self.providerAccessToken = providerAccessToken
        self.providerAccessTokenExpiry = providerAccessTokenExpiry
        self.providerRefreshToken = providerRefreshToken
        self.providerUid = providerUid
        self.secret = secret
        self.userId = userId
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.clientCode = try container.decode(String.self, forKey: .clientCode)
        self.clientEngine = try container.decode(String.self, forKey: .clientEngine)
        self.clientEngineVersion = try container.decode(String.self, forKey: .clientEngineVersion)
        self.clientName = try container.decode(String.self, forKey: .clientName)
        self.clientType = try container.decode(String.self, forKey: .clientType)
        self.clientVersion = try container.decode(String.self, forKey: .clientVersion)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.countryName = try container.decode(String.self, forKey: .countryName)
        self.current = try container.decode(Bool.self, forKey: .current)
        self.deviceBrand = try container.decode(String.self, forKey: .deviceBrand)
        self.deviceModel = try container.decode(String.self, forKey: .deviceModel)
        self.deviceName = try container.decode(String.self, forKey: .deviceName)
        self.expire = try container.decode(String.self, forKey: .expire)
        self.factors = try container.decode([String].self, forKey: .factors)
        self.ip = try container.decode(String.self, forKey: .ip)
        self.mfaUpdatedAt = try container.decode(String.self, forKey: .mfaUpdatedAt)
        self.osCode = try container.decode(String.self, forKey: .osCode)
        self.osName = try container.decode(String.self, forKey: .osName)
        self.osVersion = try container.decode(String.self, forKey: .osVersion)
        self.provider = try container.decode(String.self, forKey: .provider)
        self.providerAccessToken = try container.decode(String.self, forKey: .providerAccessToken)
        self.providerAccessTokenExpiry = try container.decode(String.self, forKey: .providerAccessTokenExpiry)
        self.providerRefreshToken = try container.decode(String.self, forKey: .providerRefreshToken)
        self.providerUid = try container.decode(String.self, forKey: .providerUid)
        self.secret = try container.decode(String.self, forKey: .secret)
        self.userId = try container.decode(String.self, forKey: .userId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(clientCode, forKey: .clientCode)
        try container.encode(clientEngine, forKey: .clientEngine)
        try container.encode(clientEngineVersion, forKey: .clientEngineVersion)
        try container.encode(clientName, forKey: .clientName)
        try container.encode(clientType, forKey: .clientType)
        try container.encode(clientVersion, forKey: .clientVersion)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(countryName, forKey: .countryName)
        try container.encode(current, forKey: .current)
        try container.encode(deviceBrand, forKey: .deviceBrand)
        try container.encode(deviceModel, forKey: .deviceModel)
        try container.encode(deviceName, forKey: .deviceName)
        try container.encode(expire, forKey: .expire)
        try container.encode(factors, forKey: .factors)
        try container.encode(ip, forKey: .ip)
        try container.encode(mfaUpdatedAt, forKey: .mfaUpdatedAt)
        try container.encode(osCode, forKey: .osCode)
        try container.encode(osName, forKey: .osName)
        try container.encode(osVersion, forKey: .osVersion)
        try container.encode(provider, forKey: .provider)
        try container.encode(providerAccessToken, forKey: .providerAccessToken)
        try container.encode(providerAccessTokenExpiry, forKey: .providerAccessTokenExpiry)
        try container.encode(providerRefreshToken, forKey: .providerRefreshToken)
        try container.encode(providerUid, forKey: .providerUid)
        try container.encode(secret, forKey: .secret)
        try container.encode(userId, forKey: .userId)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "clientCode": clientCode as Any,
            "clientEngine": clientEngine as Any,
            "clientEngineVersion": clientEngineVersion as Any,
            "clientName": clientName as Any,
            "clientType": clientType as Any,
            "clientVersion": clientVersion as Any,
            "countryCode": countryCode as Any,
            "countryName": countryName as Any,
            "current": current as Any,
            "deviceBrand": deviceBrand as Any,
            "deviceModel": deviceModel as Any,
            "deviceName": deviceName as Any,
            "expire": expire as Any,
            "factors": factors as Any,
            "ip": ip as Any,
            "mfaUpdatedAt": mfaUpdatedAt as Any,
            "osCode": osCode as Any,
            "osName": osName as Any,
            "osVersion": osVersion as Any,
            "provider": provider as Any,
            "providerAccessToken": providerAccessToken as Any,
            "providerAccessTokenExpiry": providerAccessTokenExpiry as Any,
            "providerRefreshToken": providerRefreshToken as Any,
            "providerUid": providerUid as Any,
            "secret": secret as Any,
            "userId": userId as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Session {
        return Session(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            clientCode: map["clientCode"] as! String,
            clientEngine: map["clientEngine"] as! String,
            clientEngineVersion: map["clientEngineVersion"] as! String,
            clientName: map["clientName"] as! String,
            clientType: map["clientType"] as! String,
            clientVersion: map["clientVersion"] as! String,
            countryCode: map["countryCode"] as! String,
            countryName: map["countryName"] as! String,
            current: map["current"] as! Bool,
            deviceBrand: map["deviceBrand"] as! String,
            deviceModel: map["deviceModel"] as! String,
            deviceName: map["deviceName"] as! String,
            expire: map["expire"] as! String,
            factors: map["factors"] as! [String],
            ip: map["ip"] as! String,
            mfaUpdatedAt: map["mfaUpdatedAt"] as! String,
            osCode: map["osCode"] as! String,
            osName: map["osName"] as! String,
            osVersion: map["osVersion"] as! String,
            provider: map["provider"] as! String,
            providerAccessToken: map["providerAccessToken"] as! String,
            providerAccessTokenExpiry: map["providerAccessTokenExpiry"] as! String,
            providerRefreshToken: map["providerRefreshToken"] as! String,
            providerUid: map["providerUid"] as! String,
            secret: map["secret"] as! String,
            userId: map["userId"] as! String
        )
    }
}
