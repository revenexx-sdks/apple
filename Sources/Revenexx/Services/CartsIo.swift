import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Moving carts in and out as JSON or CSV — the bulk data plane, which a storefront checkout never touches. An import/export profile (Baseline-IO-compatible) declares which direction it runs in, whether it carries whole carts or bare lines, the format, how the external columns are named, and what an import does with the lines a target cart already has; four templates ship with the app and are seeded idempotently by name. The two routes that actually move data are here as well: export one cart through an export profile or ad hoc, and import a payload into a new cart or an existing one. A profile only ever runs in the direction it declares — handing an import profile to the export route is a 400.
open class CartsIo: Service {

    ///
    /// Reads a payload of lines into a cart — the bulk-order path a buyer pastes
    /// a spreadsheet into. With `target_cart_id` the lines land in that cart,
    /// which must be active, and the profile's `apply_mode` decides what happens
    /// to the lines already there: 'replace' clears them first, 'insert' and
    /// 'append' both add. Without a target a new cart is created, and an OWNER is
    /// then required — `contact_id` or `session_key` — because a cart with
    /// neither cannot exist. `profile_id` names an IMPORT profile; without one the
    /// payload is read ad hoc, as CSV when `csv` is present and as JSON otherwise.
    /// The lines fold into identical product lines exactly as carts.items.create
    /// does, so `imported_lines` counts the lines READ and the cart may have
    /// gained fewer rows than that. A payload that parses to no line at all is a
    /// 400 rather than a quiet no-op.
    ///
    /// - Parameters:
    ///   - contactId: String (optional)
    ///   - csv: String (optional)
    ///   - name: String (optional)
    ///   - payload: Any (optional)
    ///   - profileId: String (optional)
    ///   - sessionKey: String (optional)
    ///   - targetCartId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsImport(
        contactId: String? = nil,
        csv: String? = nil,
        name: String? = nil,
        payload: Any? = nil,
        profileId: String? = nil,
        sessionKey: String? = nil,
        targetCartId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/import"

        let apiParams: [String: Any?] = [
            "contact_id": contactId,
            "csv": csv,
            "name": name,
            "payload": payload,
            "profile_id": profileId,
            "session_key": sessionKey,
            "target_cart_id": targetCartId
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
    /// The filters are what make this list usable: `?direction=export` is how a
    /// client offers the profiles that carts.export will accept, and
    /// `?is_template=true` separates the four bundled templates from what a
    /// merchant wrote. An unknown column is dropped rather than refused —
    /// `filter` echoes what was understood.
    ///
    /// - Parameters:
    ///   - id: String (optional)
    ///   - name: String (optional)
    ///   - direction: RevenexxEnums.CartIoDirection (optional)
    ///   - entity: RevenexxEnums.CartIoEntity (optional)
    ///   - format: RevenexxEnums.CartIoFormat (optional)
    ///   - applyMode: RevenexxEnums.CartIoApplyMode (optional)
    ///   - isTemplate: Bool (optional)
    ///   - createdAt: String (optional)
    ///   - updatedAt: String (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - order: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsIoProfilesList(
        id: String? = nil,
        name: String? = nil,
        direction: RevenexxEnums.CartIoDirection? = nil,
        entity: RevenexxEnums.CartIoEntity? = nil,
        format: RevenexxEnums.CartIoFormat? = nil,
        applyMode: RevenexxEnums.CartIoApplyMode? = nil,
        isTemplate: Bool? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        order: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/io/profiles"

        let apiParams: [String: Any?] = [
            "id": id,
            "name": name,
            "direction": direction,
            "entity": entity,
            "format": format,
            "apply_mode": applyMode,
            "is_template": isTemplate,
            "created_at": createdAt,
            "updated_at": updatedAt,
            "limit": limit,
            "offset": offset,
            "order": order
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
    /// Defines a new import/export profile. Two fields are required and have no
    /// default — `name`, which must be unique within the tenant, and
    /// `direction`, which fixes the one way this profile will ever run. Everything
    /// else defaults to the common case: whole carts, JSON, `apply_mode` 'insert',
    /// not a template. The uniqueness of the name is a unique index rather than a
    /// check in this app, so a reused name is a 409 no matter which route wrote
    /// the other one, including the four bundled templates. The shape is
    /// Baseline-IO-compatible, so a mapping written for another app's import reads
    /// the same way here. Creating a profile does not move any data: carts.export
    /// and carts.import are what execute one, and each refuses a profile pointed
    /// the wrong way.
    ///
    /// - Parameters:
    ///   - direction: RevenexxEnums.CartIoDirection
    ///   - name: String
    ///   - applyMode: RevenexxEnums.CartIoApplyMode (optional)
    ///   - entity: RevenexxEnums.CartIoEntity (optional)
    ///   - format: RevenexxEnums.CartIoFormat (optional)
    ///   - isTemplate: Bool (optional)
    ///   - mapping: Any (optional)
    ///   - options: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsIoProfilesCreate(
        direction: RevenexxEnums.CartIoDirection,
        name: String,
        applyMode: RevenexxEnums.CartIoApplyMode? = nil,
        entity: RevenexxEnums.CartIoEntity? = nil,
        format: RevenexxEnums.CartIoFormat? = nil,
        isTemplate: Bool? = nil,
        mapping: Any? = nil,
        options: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/io/profiles"

        let apiParams: [String: Any?] = [
            "apply_mode": applyMode,
            "direction": direction,
            "entity": entity,
            "format": format,
            "is_template": isTemplate,
            "mapping": mapping,
            "name": name,
            "options": options
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
    /// Seeds the 4 bundled templates and reports which of them it had to create
    /// — the call that gives a fresh tenant something to export through before
    /// anybody has written a profile. Idempotent and matched by NAME, so a second
    /// call answers with everything under 'existing' and writes nothing, and a
    /// template a merchant has edited is left exactly as they left it rather than
    /// reset. It also runs by itself on app.installed; call it by hand where that
    /// event cannot be relied on, and after deleting a template to get it back.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func cartsIoProfilesDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/carts/io/profiles/defaults"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Removes a profile. Nothing in this app points at one — no cart and no
    /// line stores the profile it was imported through — so no foreign key holds
    /// the delete up and nothing is orphaned by it; what breaks is the caller
    /// still holding that `profile_id`, which answers 404 on its next run.
    /// Deleting one of the four bundled templates is not permanent either: the
    /// next carts.io.profiles.defaults, and the next install of this app, seeds it
    /// again by name, in the shape it ships with rather than the shape a merchant
    /// had edited it into.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsIoProfilesDelete(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/io/profiles/{id}"
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
    /// One profile by id — the id carts.export and carts.import name in
    /// `profile_id`. Read it to see what a run will do before starting one:
    /// `direction`, because a profile only ever runs the way it declares;
    /// `entity`, whole carts or bare lines; `format`, where json round-trips and
    /// csv carries line fields only; `mapping`, what the external columns are
    /// called; and `apply_mode`, which decides what an import does with the lines
    /// a target cart already has. `is_template` says whether this is one of the
    /// four the app ships with or something a merchant wrote. Reading a profile
    /// runs nothing and changes nothing.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsIoProfilesGet(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/io/profiles/{id}"
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
    /// Edits a profile in place, the four bundled templates included — seeding
    /// matches on name and never rewrites what it finds, so an edit made here
    /// survives every later call to carts.io.profiles.defaults and every reinstall
    /// of the app. The name stays unique in the tenant, so renaming onto another
    /// profile's name is a 409, and a payload carrying no updatable field answers
    /// 400 rather than storing nothing quietly. Runs that already happened are
    /// unaffected: a profile is read at the moment carts.export or carts.import
    /// executes and nothing is kept pointing back at it, so changing a mapping
    /// changes the next run and no earlier one.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - applyMode: RevenexxEnums.CartIoApplyMode (optional)
    ///   - direction: RevenexxEnums.CartIoDirection (optional)
    ///   - entity: RevenexxEnums.CartIoEntity (optional)
    ///   - format: RevenexxEnums.CartIoFormat (optional)
    ///   - isTemplate: Bool (optional)
    ///   - mapping: Any (optional)
    ///   - name: String (optional)
    ///   - options: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsIoProfilesUpdate(
        id: String,
        applyMode: RevenexxEnums.CartIoApplyMode? = nil,
        direction: RevenexxEnums.CartIoDirection? = nil,
        entity: RevenexxEnums.CartIoEntity? = nil,
        format: RevenexxEnums.CartIoFormat? = nil,
        isTemplate: Bool? = nil,
        mapping: Any? = nil,
        name: String? = nil,
        options: Any? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/io/profiles/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "apply_mode": applyMode,
            "direction": direction,
            "entity": entity,
            "format": format,
            "is_template": isTemplate,
            "mapping": mapping,
            "name": name,
            "options": options
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
    /// Renders one cart as a document somebody can take away. With `profile_id`
    /// the named EXPORT profile decides the format, the entity and the column
    /// names; handing it an import profile is a 400, because a profile only runs
    /// the way it declares. Without one the call runs ad hoc — JSON, unless
    /// `format: 'csv'` says otherwise. The JSON form is `{cart: {…}, items:
    /// […]}` and is exactly what carts.import takes back, so an export
    /// round-trips; the CSV form is the lines only, header first, and drops
    /// everything that lives on the cart rather than on a line. Nothing is stored
    /// and nothing about the cart changes — `filename` is a suggestion for a
    /// browser download, not a file this app keeps — and a cart of any status
    /// can be exported, including one already ordered.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - format: RevenexxEnums.CartExportFormat (optional)
    ///   - profileId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func cartsExport(
        id: String,
        format: RevenexxEnums.CartExportFormat? = nil,
        profileId: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/carts/{id}/export"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "format": format,
            "profile_id": profileId
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