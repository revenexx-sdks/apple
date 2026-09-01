import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — omitted fields keep their current value; external_team_id is mirror-managed and ignored.
open class OrganizationUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case branche = "branche"
        case credit_limit = "credit_limit"
        case customer_number = "customer_number"
        case delivery_block = "delivery_block"
        case lifecycle_stage = "lifecycle_stage"
        case name = "name"
        case payment_terms = "payment_terms"
        case price_list = "price_list"
        case settings = "settings"
        case status = "status"
        case vat_id = "vat_id"
    }

    /// Industry / line of business, in the merchant's own words. Free text: no NACE code, no WZ number, no list to pick from — whatever somebody typed on the company. Segment rules read it, and both `?branche=` and an `eq` condition match it EXACTLY and case-sensitively, so 'Maschinenbau' and 'maschinenbau' are two different industries. Indexed, so it stays cheap to filter on.
    public let branche: String?
    /// Ceiling on open receivables in the market's currency, and one of the inputs that decide whether an order is accepted at all. Null means NO limit — not a limit of zero. A create without it inherits the tenant's `default_credit_limit`.
    public let credit_limit: Double?
    /// The number this company carries in the merchant's own ERP — the key an ERP integration joins on, and what a service desk asks for on the phone. Free text with NO enforced format (a letter prefix and a running number is the common shape, but plain digits are just as valid), unique per tenant while it is set, and one of the fields duplicate detection can be pointed at. The real values come out of the merchant's ERP; nothing published here can name one that exists. A second company with the same number is a 409.
    public let customer_number: String?
    /// True stops SHIPMENTS to this company while leaving login and ordering alone — the "they may order, we are just not sending anything until this is settled" state. Separate from `status` on purpose: blocking the login to stop a delivery locks out the people who could settle it. Default false.
    public let delivery_block: Bool?
    /// Where the company stands in the SALES PIPELINE, and a deliberately separate axis from `status`: a prospect that may log in and a customer that may not are both ordinary states, and one column cannot say that. One of the tenant's own stages (GET /customers/lifecycle-stages) — a fresh install starts with lead, prospect, customer, churned, and the merchant may add their own. Nothing moves it automatically; a stage changes when a person or an integration says so. A create without it gets the stage flagged as default; a value the tenant does not keep is a 400.
    public let lifecycle_stage: String?
    /// Legal or trading name of the COMPANY — never a person. Mirrored to the platform team, so a rename here is a rename in storefront auth too.
    public let name: String?
    /// When this company has to pay — one of the tenant's own terms (GET /customers/payment-terms, seeded with prepayment, direct_debit, net_7/14/30/60/90). Null means nothing was agreed and the order flow falls back to the market's `default_payment_terms`. This is a commercial term, not a payment method: HOW they pay is the payments app's business. A create without it inherits the market's `default_payment_terms`; a value the tenant does not keep is a 400.
    public let payment_terms: String?
    /// Code of the price list this company buys on — plain text pointing into the prices app. ADR-0055 forbids the cross-app foreign key, so nothing here checks it: a code that names no list simply prices nothing. `standard` is the list the prices app seeds on install.
    public let price_list: String?
    /// Free-form per-organization settings, keyed by whatever the merchant's own integrations agree on — this app never branches on a key in here. Segment rules can address a TOP-LEVEL key as `setting:<key>`, which is the whole reason the blob survives: a flag an ERP writes here selects a segment without a schema change. Commercial terms are typed columns now (payment_terms, credit_limit); writing them back in here leaves the checkout reading the column and finding nothing. Replaced wholesale on an update — send the whole object, not a patch of it.
    public let settings: [String: AnyCodable]?
    /// ACCESS, not pipeline: 'blocked' stops this company's people from logging in and is where a rejected registration parks the company it founded. 'active' is the default. For how far along a company is, read `lifecycle_stage` — reading this one for that is how a won deal gets locked out. Default 'active'.
    public let status: RevenexxEnums.OrganizationStatus?
    /// VAT identification number (USt-IdNr. in Germany) — the closest thing a B2B buyer has to a legal identity. Validated against the EU VIES service when the tenant's `organization_vat_id_required` setting is on, and stored verbatim otherwise, including for buyers outside the EU.
    public let vat_id: String?

    init(
        branche: String?,
        credit_limit: Double?,
        customer_number: String?,
        delivery_block: Bool?,
        lifecycle_stage: String?,
        name: String?,
        payment_terms: String?,
        price_list: String?,
        settings: [String: AnyCodable]?,
        status: RevenexxEnums.OrganizationStatus?,
        vat_id: String?
    ) {
        self.branche = branche
        self.credit_limit = credit_limit
        self.customer_number = customer_number
        self.delivery_block = delivery_block
        self.lifecycle_stage = lifecycle_stage
        self.name = name
        self.payment_terms = payment_terms
        self.price_list = price_list
        self.settings = settings
        self.status = status
        self.vat_id = vat_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.branche = try container.decodeIfPresent(String.self, forKey: .branche)
        self.credit_limit = try container.decodeIfPresent(Double.self, forKey: .credit_limit)
        self.customer_number = try container.decodeIfPresent(String.self, forKey: .customer_number)
        self.delivery_block = try container.decodeIfPresent(Bool.self, forKey: .delivery_block)
        self.lifecycle_stage = try container.decodeIfPresent(String.self, forKey: .lifecycle_stage)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.payment_terms = try container.decodeIfPresent(String.self, forKey: .payment_terms)
        self.price_list = try container.decodeIfPresent(String.self, forKey: .price_list)
        self.settings = try container.decodeIfPresent([String: AnyCodable].self, forKey: .settings)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.OrganizationStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.vat_id = try container.decodeIfPresent(String.self, forKey: .vat_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(branche, forKey: .branche)
        try container.encodeIfPresent(credit_limit, forKey: .credit_limit)
        try container.encodeIfPresent(customer_number, forKey: .customer_number)
        try container.encodeIfPresent(delivery_block, forKey: .delivery_block)
        try container.encodeIfPresent(lifecycle_stage, forKey: .lifecycle_stage)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(payment_terms, forKey: .payment_terms)
        try container.encodeIfPresent(price_list, forKey: .price_list)
        try container.encodeIfPresent(settings, forKey: .settings)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(vat_id, forKey: .vat_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "branche": branche as Any,
            "credit_limit": credit_limit as Any,
            "customer_number": customer_number as Any,
            "delivery_block": delivery_block as Any,
            "lifecycle_stage": lifecycle_stage as Any,
            "name": name as Any,
            "payment_terms": payment_terms as Any,
            "price_list": price_list as Any,
            "settings": settings as Any,
            "status": status?.rawValue as Any,
            "vat_id": vat_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrganizationUpdateRequest {
        return OrganizationUpdateRequest(
            branche: map["branche"] as? String,
            credit_limit: map["credit_limit"] as? Double,
            customer_number: map["customer_number"] as? String,
            delivery_block: map["delivery_block"] as? Bool,
            lifecycle_stage: map["lifecycle_stage"] as? String,
            name: map["name"] as? String,
            payment_terms: map["payment_terms"] as? String,
            price_list: map["price_list"] as? String,
            settings: map["settings"] as? [String: AnyCodable],
            status: map["status"] as? String != nil ? OrganizationStatus(rawValue: map["status"] as! String) : nil,
            vat_id: map["vat_id"] as? String
        )
    }
}
