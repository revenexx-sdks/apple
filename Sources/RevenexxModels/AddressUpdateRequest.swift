import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class AddressUpdateRequest: Codable {

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

    /// City or town.
    public let city: String?
    /// Company line on the label. Often the owning organization's name, but not always — a delivery to a construction site carries the site.
    public let company: String?
    /// Owning person — a personal address only that contact uses. Exactly one of organization_id / contact_id is set.
    public let contact_id: String?
    /// ISO 3166-1 alpha-2 country code, exactly two letters. Uppercase by convention; it is what shipping and tax both key off.
    public let country: String?
    /// The default address of its owner AND type: one default billing and one default shipping address per owner. Setting it moves the flag off the previous holder. Default false.
    public let is_default: Bool?
    /// Recipient line on the label — the person or department the parcel is addressed to.
    public let name: String?
    /// Owning company — a company address, shared by everyone in it. Exactly one of organization_id / contact_id is set.
    public let organization_id: String?
    /// Phone number for the carrier to reach at this address — often a different one from the contact's own.
    public let phone: String?
    /// State, province or Bundesland. Required by some destinations (US, CA), unused by most European ones.
    public let region: String?
    /// Street and house number, on one line, as the local post expects it.
    public let street: String?
    /// The second address line: building, floor, gate, c/o. Null when there is none.
    public let street2: String?
    /// What the address is FOR — one of the tenant's own address types (GET /customers/address-types), seeded with billing and shipping. A merchant may add their own (a works entrance, a central accounts office) without a release of this app. A create without it gets the type flagged as default; a type the tenant does not keep is a 400.
    public let type: String?
    /// Postal code, as text — leading zeros are real in most countries.
    public let zip: String?

    init(
        city: String?,
        company: String?,
        contact_id: String?,
        country: String?,
        is_default: Bool?,
        name: String?,
        organization_id: String?,
        phone: String?,
        region: String?,
        street: String?,
        street2: String?,
        type: String?,
        zip: String?
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

        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        self.street = try container.decodeIfPresent(String.self, forKey: .street)
        self.street2 = try container.decodeIfPresent(String.self, forKey: .street2)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.zip = try container.decodeIfPresent(String.self, forKey: .zip)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(company, forKey: .company)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(region, forKey: .region)
        try container.encodeIfPresent(street, forKey: .street)
        try container.encodeIfPresent(street2, forKey: .street2)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(zip, forKey: .zip)
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
            "type": type as Any,
            "zip": zip as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AddressUpdateRequest {
        return AddressUpdateRequest(
            city: map["city"] as? String,
            company: map["company"] as? String,
            contact_id: map["contact_id"] as? String,
            country: map["country"] as? String,
            is_default: map["is_default"] as? Bool,
            name: map["name"] as? String,
            organization_id: map["organization_id"] as? String,
            phone: map["phone"] as? String,
            region: map["region"] as? String,
            street: map["street"] as? String,
            street2: map["street2"] as? String,
            type: map["type"] as? String,
            zip: map["zip"] as? String
        )
    }
}
