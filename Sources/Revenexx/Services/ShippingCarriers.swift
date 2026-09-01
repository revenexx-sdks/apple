import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// WHO carries the parcel. A carrier row is one company shipping one class of service: it owns the tracking-URL template, the service level, the transit days, the pickup cut-off and the handling days, and every shipping method that ships with it INHERITS all of those unless it states its own. A carrier selling both a parcel and an express product is therefore two rows — one row cannot hold two delivery promises. Pausing or retiring one takes every method that ships with it out of the quote in a single edit, which is the reason the table exists. The tracking resolver lives here too, because the template it substitutes into is a column of this row: ask the carrier for the link rather than copying one carrier's URL shape into every shipment. What a carrier COSTS is never here — the price is the method's.
open class ShippingCarriers: Service {

    ///
    /// Filterable by exact column value — `?code=`, `?status=` and
    /// `?service_level=` are applied as equalities and echoed back in `filter`. A
    /// query key that names no column of this entity is SILENTLY IGNORED: the page
    /// comes back unfiltered, 200, with an empty `filter`, so compare the echo
    /// against what you sent rather than trusting the status.
    ///
    /// - Parameters:
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    ///   - code: String (optional)
    ///   - status: RevenexxEnums.ShippingCarriersListStatus (optional)
    ///   - serviceLevel: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingCarriersList(
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil,
        code: String? = nil,
        status: RevenexxEnums.ShippingCarriersListStatus? = nil,
        serviceLevel: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/carriers"

        let apiParams: [String: Any?] = [
            "limit": limit,
            "offset": offset,
            "order": order,
            "code": code,
            "status": status,
            "service_level": serviceLevel
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// A carrier row is one company shipping one class of service: it owns the
    /// tracking-URL template, the service level, the transit days, the pickup
    /// cut-off and the handling days, and every method that ships with it inherits
    /// all of those unless it states its own. A carrier selling both a parcel and
    /// an express product is two rows. Reach for it for a carrier this app does
    /// not describe — a regional courier, a forwarder, an own fleet; for the
    /// DACH networks read GET /shipping/carriers/catalog and let POST
    /// /shipping/carriers/defaults write them. A create cannot omit `code` and
    /// `name`; every other column is optional or defaulted by the database. Two
    /// rows of this tenant may not share `code` — that is the 409.
    /// `service_level` has to name one of the tenant's own levels and
    /// `cutoff_time` has to be HH:MM in 24-hour UTC — both are refused rather
    /// than stored, because a cut-off the estimator cannot read would be dropped
    /// in silence and the shop would keep promising a ship date nobody computed.
    /// Creating a carrier quotes nothing on its own: a method has to reference it
    /// (`carrier_id`, or a `carrier` text equal to this code) before any of it is
    /// inherited.
    ///
    /// - Parameters:
    ///   - code: String
    ///   - name: String
    ///   - countries: [String] (optional)
    ///   - cutoffTime: String (optional)
    ///   - etaDaysMax: Int (optional)
    ///   - etaDaysMin: Int (optional)
    ///   - handlingDays: Int (optional)
    ///   - labels: Any (optional)
    ///   - metadata: Any (optional)
    ///   - position: Int (optional)
    ///   - serviceLevel: String (optional)
    ///   - status: RevenexxEnums.ShippingCarrierStatus (optional)
    ///   - trackingUrlTemplate: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingCarriersCreate(
        code: String,
        name: String,
        countries: [String]? = nil,
        cutoffTime: String? = nil,
        etaDaysMax: Int? = nil,
        etaDaysMin: Int? = nil,
        handlingDays: Int? = nil,
        labels: Any? = nil,
        metadata: Any? = nil,
        position: Int? = nil,
        serviceLevel: String? = nil,
        status: RevenexxEnums.ShippingCarrierStatus? = nil,
        trackingUrlTemplate: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/carriers"

        let apiParams: [String: Any?] = [
            "code": code,
            "countries": countries,
            "cutoff_time": cutoffTime,
            "eta_days_max": etaDaysMax,
            "eta_days_min": etaDaysMin,
            "handling_days": handlingDays,
            "labels": labels,
            "metadata": metadata,
            "name": name,
            "position": position,
            "service_level": serviceLevel,
            "status": status,
            "tracking_url_template": trackingUrlTemplate
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// The DACH set — the three German parcel networks, the express carriers,
    /// the AT/CH incumbents and the pallet forwarders — each with the tracking
    /// template, service level, transit time and pickup cut-off it would be
    /// created with. `seeded` marks the four a fresh install already has. Adding a
    /// carrier is a data change, never a code change, and a merchant may of course
    /// create one that is not in here at all.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func shippingCarriersCatalog(
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/carriers/catalog"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// The four networks a DACH shop is expected to have — DHL, DPD, GLS and UPS
    /// — created by code, and only the ones that are missing. The app runs this
    /// itself on `app.installed`, so a fresh install already has them; calling it
    /// by hand afterwards is how a tenant that predates a catalog entry catches
    /// up, and calling it twice costs nothing, because it reconciles rather than
    /// seeds. An existing row belongs to the merchant: only columns that are
    /// genuinely EMPTY are filled in (a tracking template added to the catalog
    /// after their install), never a value they set. Nothing is deleted.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func shippingCarriersDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/shipping/carriers/defaults"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Deleting one clears `shipping_methods.carrier_id` rather than deleting
    /// those rows — the foreign keys decide that, not this route. So a method
    /// that referenced this carrier keeps working and resolves through its
    /// `carrier` code instead, which is also why this never answers a conflict —
    /// and it is the reason to prefer `status: 'retired'` where the carrier is
    /// merely finished. What the method silently LOSES is everything it was
    /// inheriting: the tracking template, the pickup cut-off, the handling days
    /// and the transit days. Unless its `carrier` text still matches another
    /// carrier, its ship date is recomputed on the market's own cut-off and
    /// handling settings, and a method that stated no `eta_days_min`/`max` of its
    /// own stops carrying a `delivery` estimate altogether. Nothing errors; the
    /// promise in the checkout just changes.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingCarriersDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/carriers/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// A carrier row is one company shipping one class of service: it owns the
    /// tracking-URL template, the service level, the transit days, the pickup
    /// cut-off and the handling days, and every method that ships with it inherits
    /// all of those unless it states its own. A carrier selling both a parcel and
    /// an express product is two rows. Read it when you need to know what a
    /// method's delivery promise really is: `cutoff_time`, `handling_days` and
    /// `eta_days_min`/`max` are inherited from here, so a shop that seems to
    /// promise the wrong ship date is usually explained by this row rather than by
    /// the method. It does NOT say which methods ship with it — that is GET
    /// /shipping/methods?carrier_id=… for the ones holding a reference and
    /// ?carrier=… for the ones still resolving through the legacy code text.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingCarriersGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/carriers/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// A carrier row is one company shipping one class of service: it owns the
    /// tracking-URL template, the service level, the transit days, the pickup
    /// cut-off and the handling days, and every method that ships with it inherits
    /// all of those unless it states its own. A carrier selling both a parcel and
    /// an express product is two rows. A partial update — send only what
    /// changes, which is where a carrier is paused, given a different tracking
    /// template, or moved to another pickup cut-off or transit time. This is the
    /// one switch that acts on several methods at once, in both directions. Moving
    /// `status` off 'active' takes every method that ships with this carrier out
    /// of POST /shipping/rates with a reason, which beats disabling each of them
    /// and forgetting one; tracking links are deliberately not gated on it, so a
    /// retired carrier's old shipments stay resolvable. Editing `cutoff_time`,
    /// `handling_days` or `eta_days_min`/`max` MOVES THE PROMISED SHIP DATE of
    /// every method that states none of its own: the estimator adds the handling
    /// days, then one further day when the cut-off has already passed at the
    /// instant being evaluated — compared at or after, in UTC, and as calendar
    /// days that do not skip a weekend. Two rows of this tenant may not share
    /// `code` — that is the 409.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - code: String (optional)
    ///   - countries: [String] (optional)
    ///   - cutoffTime: String (optional)
    ///   - etaDaysMax: Int (optional)
    ///   - etaDaysMin: Int (optional)
    ///   - handlingDays: Int (optional)
    ///   - labels: Any (optional)
    ///   - metadata: Any (optional)
    ///   - name: String (optional)
    ///   - position: Int (optional)
    ///   - serviceLevel: String (optional)
    ///   - status: RevenexxEnums.ShippingCarrierStatus (optional)
    ///   - trackingUrlTemplate: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingCarriersUpdate(
        id: String,
        code: String? = nil,
        countries: [String]? = nil,
        cutoffTime: String? = nil,
        etaDaysMax: Int? = nil,
        etaDaysMin: Int? = nil,
        handlingDays: Int? = nil,
        labels: Any? = nil,
        metadata: Any? = nil,
        name: String? = nil,
        position: Int? = nil,
        serviceLevel: String? = nil,
        status: RevenexxEnums.ShippingCarrierStatus? = nil,
        trackingUrlTemplate: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/carriers/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "code": code,
            "countries": countries,
            "cutoff_time": cutoffTime,
            "eta_days_max": etaDaysMax,
            "eta_days_min": etaDaysMin,
            "handling_days": handlingDays,
            "labels": labels,
            "metadata": metadata,
            "name": name,
            "position": position,
            "service_level": serviceLevel,
            "status": status,
            "tracking_url_template": trackingUrlTemplate
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Hand in a carrier code and the tracking number printed on the label, and
    /// this answers the URL a buyer follows. The carrier owns the URL format, so
    /// nobody else has to. `order_shipments` stores a tracking_url per shipment
    /// today, which is one carrier's URL shape copied into every row — the day
    /// it changes, every historic link is wrong. Ask here instead. Tracking is NOT
    /// gated on carrier status: a retired carrier's old shipments stay resolvable.
    ///
    /// - Parameters:
    ///   - carrier: String
    ///   - country: String (optional)
    ///   - postalCode: String (optional)
    ///   - trackingCode: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func shippingTracking(
        carrier: String,
        country: String? = nil,
        postalCode: String? = nil,
        trackingCode: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/shipping/tracking"

        let apiParams: [String: Any?] = [
            "carrier": carrier,
            "country": country,
            "postal_code": postalCode,
            "tracking_code": trackingCode
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}