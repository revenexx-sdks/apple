import Foundation
import JSONCodable

/// Health Certificate
open class HealthCertificate: Codable {

    enum CodingKeys: String, CodingKey {
        case issuerOrganisation = "issuerOrganisation"
        case name = "name"
        case signatureTypeSN = "signatureTypeSN"
        case subjectSN = "subjectSN"
        case validFrom = "validFrom"
        case validTo = "validTo"
    }

    /// Issuer organisation
    public let issuerOrganisation: String
    /// Certificate name
    public let name: String
    /// Signature type SN
    public let signatureTypeSN: String
    /// Subject SN
    public let subjectSN: String
    /// Valid from
    public let validFrom: String
    /// Valid to
    public let validTo: String

    init(
        issuerOrganisation: String,
        name: String,
        signatureTypeSN: String,
        subjectSN: String,
        validFrom: String,
        validTo: String
    ) {
        self.issuerOrganisation = issuerOrganisation
        self.name = name
        self.signatureTypeSN = signatureTypeSN
        self.subjectSN = subjectSN
        self.validFrom = validFrom
        self.validTo = validTo
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.issuerOrganisation = try container.decode(String.self, forKey: .issuerOrganisation)
        self.name = try container.decode(String.self, forKey: .name)
        self.signatureTypeSN = try container.decode(String.self, forKey: .signatureTypeSN)
        self.subjectSN = try container.decode(String.self, forKey: .subjectSN)
        self.validFrom = try container.decode(String.self, forKey: .validFrom)
        self.validTo = try container.decode(String.self, forKey: .validTo)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(issuerOrganisation, forKey: .issuerOrganisation)
        try container.encode(name, forKey: .name)
        try container.encode(signatureTypeSN, forKey: .signatureTypeSN)
        try container.encode(subjectSN, forKey: .subjectSN)
        try container.encode(validFrom, forKey: .validFrom)
        try container.encode(validTo, forKey: .validTo)
    }

    public func toMap() -> [String: Any] {
        return [
            "issuerOrganisation": issuerOrganisation as Any,
            "name": name as Any,
            "signatureTypeSN": signatureTypeSN as Any,
            "subjectSN": subjectSN as Any,
            "validFrom": validFrom as Any,
            "validTo": validTo as Any
        ]
    }

    public static func from(map: [String: Any] ) -> HealthCertificate {
        return HealthCertificate(
            issuerOrganisation: map["issuerOrganisation"] as! String,
            name: map["name"] as! String,
            signatureTypeSN: map["signatureTypeSN"] as! String,
            subjectSN: map["subjectSN"] as! String,
            validFrom: map["validFrom"] as! String,
            validTo: map["validTo"] as! String
        )
    }
}
