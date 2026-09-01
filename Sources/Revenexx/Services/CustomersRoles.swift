import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The role catalogue and the tenant's own role-to-permission mapping. A role is held by a CONTACT and applies inside that contact's organization; there is no global customer role. Permissions are DERIVED from the role on every read and never stored per contact, so a role change takes effect immediately and can never leave a stale grant behind. Five built-in roles answer for a tenant that has written none of its own down; seeding them and replacing a role's permission set are the two writes. What one PERSON ends up holding is read in Contacts.
open class CustomersRoles: Service {

    ///
    /// The whole catalogue in one read: every role a contact of this tenant can
    /// hold, the permissions each one grants, and the built-in permission
    /// vocabulary those grants are drawn from. Roles are held by a CONTACT and
    /// apply inside that contact's organization; there is no global customer role.
    /// Permissions are derived from the role at read time and never stored per
    /// contact, so a role change takes effect immediately and cannot leave a stale
    /// grant. The role to permission MAPPING is per tenant and configurable (PUT
    /// /customers/roles/{key}/permissions); a tenant that has not configured
    /// anything gets the built-ins and 'source' says which of the two answered.
    /// Built-in roles, least to most privileged: viewer (Viewer), requester
    /// (Requester), buyer (Buyer), approver (Approver), admin (Administrator). The
    /// permission KEYS themselves come from the cross-app ledger — every
    /// installed app declares what it enforces — so a tenant may grant a key
    /// this list does not mention.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.RoleCatalogResponse
    ///
    open func customersRolesList(
    ) async throws -> RevenexxModels.RoleCatalogResponse {
        let apiPath: String = "/v1/customers/roles"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.RoleCatalogResponse = { response in
            return RevenexxModels.RoleCatalogResponse.from(map: response as! [String: Any])
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
    /// Idempotent: a role that already exists is left completely alone, its
    /// permissions included, so re-seeding never undoes a merchant's edits.
    /// Creates viewer, requester, buyer, approver, admin with the built-in
    /// mapping. A tenant that never calls this still behaves correctly — the
    /// catalogue and every permission read fall back to the same built-ins.
    ///
    /// - Parameters:
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersRolesDefaults(
        data: Any
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/roles/defaults"

        let apiParams: [String: Any?] = [
            "data": data
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
    /// The whole new set in one call — the shape a role editor actually
    /// produces, and the one that cannot leave a half-applied grant behind if a
    /// second call fails. Seeds the built-in roles first when the tenant has none,
    /// so editing works without calling /defaults. Permission keys are free text
    /// on purpose: they belong to whichever app declared them, and a grant for an
    /// app that is not installed simply has nothing to act on.
    ///
    /// - Parameters:
    ///   - key: String
    ///   - permissions: [String]
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func customersRolesPermissionsReplace(
        key: String,
        permissions: [String]
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/customers/roles/{key}/permissions"
            .replacingOccurrences(of: "{key}", with: key)

        let apiParams: [String: Any?] = [
            "permissions": permissions
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


}