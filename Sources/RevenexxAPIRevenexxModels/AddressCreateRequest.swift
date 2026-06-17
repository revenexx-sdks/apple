import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// An address needs an owner: &#039;organization_id&#039; or &#039;contact_id&#039;.
open class AddressCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case company = "company"
        case contact_id = "contact_id"
        case country = "country"
        case is_default = "is_default"
        case name = "name"
        case organization_id = "organization_id"
        case phone = "phone"
        case region = "region"
        case street = "street"
        case street2 = "street2"
        case type = "type"
        case zip = "zip"
    }

    /// 
    public let city: String
    /// 
    public let company: String?
    /// Owning contact (personal address).
    public let contact_id: String?
    /// ISO 3166-1 alpha-2 code.
    public let country: String
    /// The default address of its owner and type.
    public let is_default: Bool?
    /// Recipient name.
    public let name: String?
    /// Owning organization (company address).
    public let organization_id: String?
    /// 
    public let phone: String?
    /// 
    public let region: String?
    /// 
    public let street: String
    /// 
    public let street2: String?
    /// Default &#039;shipping&#039;.
    public let type: Revenexx API — revenexxEnums.AddressType?
    /// 
    public let zip: String

    init(
        city: String,
        company: String?,
        contact_id: String?,
        country: String,
        is_default: Bool?,
        name: String?,
        organization_id: String?,
        phone: String?,
        region: String?,
        street: String,
        street2: String?,
        type: Revenexx API — revenexxEnums.AddressType?,
        zip: String
    ) {
        self.city = city
        self.company = company
        self.contact_id = contact_id
        self.country = country
        self.is_default = is_default
        self.name = name
        self.organization_id = organization_id
        self.phone = phone
        self.region = region
        self.street = street
        self.street2 = street2
        self.type = type
        self.zip = zip
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.city = try container.decode(String.self, forKey: .city)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.country = try container.decode(String.self, forKey: .country)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        self.street = try container.decode(String.self, forKey: .street)
        self.street2 = try container.decodeIfPresent(String.self, forKey: .street2)
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = Revenexx API — revenexxEnums.AddressType(rawValue: typeString)
        } else {
            self.type = nil
        }
        self.zip = try container.decode(String.self, forKey: .zip)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(city, forKey: .city)
        try container.encodeIfPresent(company, forKey: .company)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encode(country, forKey: .country)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(region, forKey: .region)
        try container.encode(street, forKey: .street)
        try container.encodeIfPresent(street2, forKey: .street2)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
        try container.encode(zip, forKey: .zip)
    }

    public func toMap() -> [String: Any] {
        return [
            "city": city as Any,
            "company": company as Any,
            "contact_id": contact_id as Any,
            "country": country as Any,
            "is_default": is_default as Any,
            "name": name as Any,
            "organization_id": organization_id as Any,
            "phone": phone as Any,
            "region": region as Any,
            "street": street as Any,
            "street2": street2 as Any,
            "type": type?.rawValue as Any,
            "zip": zip as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AddressCreateRequest {
        return AddressCreateRequest(
            city: map["city"] as! String,
            company: map["company"] as? String,
            contact_id: map["contact_id"] as? String,
            country: map["country"] as! String,
            is_default: map["is_default"] as? Bool,
            name: map["name"] as? String,
            organization_id: map["organization_id"] as? String,
            phone: map["phone"] as? String,
            region: map["region"] as? String,
            street: map["street"] as! String,
            street2: map["street2"] as? String,
            type: map["type"] as? String != nil ? AddressType(rawValue: map["type"] as! String) : nil,
            zip: map["zip"] as! String
        )
    }
}
