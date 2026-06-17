import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Customers: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersAddressesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/addresses"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - city: String
    ///   - country: String
    ///   - street: String
    ///   - zip: String
    ///   - company: String (optional)
    ///   - contactId: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - name: String (optional)
    ///   - organizationId: String (optional)
    ///   - phone: String (optional)
    ///   - region: String (optional)
    ///   - street2: String (optional)
    ///   - type: Revenexx API — revenexxEnums.AddressType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Address
    ///
    open func customersAddressesCreate(
        city: String,
        country: String,
        street: String,
        zip: String,
        company: String? = nil,
        contactId: String? = nil,
        isDefault: Bool? = nil,
        name: String? = nil,
        organizationId: String? = nil,
        phone: String? = nil,
        region: String? = nil,
        street2: String? = nil,
        type: Revenexx API — revenexxEnums.AddressType? = nil
    ) async throws -> Revenexx API — revenexxModels.Address {
        let apiPath: String = "/v1/customers/addresses"

        let apiParams: [String: Any?] = [
            "city": city,
            "company": company,
            "contact_id": contactId,
            "country": country,
            "is_default": isDefault,
            "name": name,
            "organization_id": organizationId,
            "phone": phone,
            "region": region,
            "street": street,
            "street2": street2,
            "type": type,
            "zip": zip
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Address = { response in
            return RevenexxAPIRevenexxModels.Address.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersAddressesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/addresses/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Address
    ///
    open func customersAddressesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Address {
        let apiPath: String = "/v1/customers/addresses/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Address = { response in
            return RevenexxAPIRevenexxModels.Address.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    ///   - city: String (optional)
    ///   - company: String (optional)
    ///   - contactId: String (optional)
    ///   - country: String (optional)
    ///   - isDefault: Bool (optional)
    ///   - name: String (optional)
    ///   - organizationId: String (optional)
    ///   - phone: String (optional)
    ///   - region: String (optional)
    ///   - street: String (optional)
    ///   - street2: String (optional)
    ///   - type: Revenexx API — revenexxEnums.AddressType (optional)
    ///   - zip: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Address
    ///
    open func customersAddressesUpdate(
        id: String,
        city: String? = nil,
        company: String? = nil,
        contactId: String? = nil,
        country: String? = nil,
        isDefault: Bool? = nil,
        name: String? = nil,
        organizationId: String? = nil,
        phone: String? = nil,
        region: String? = nil,
        street: String? = nil,
        street2: String? = nil,
        type: Revenexx API — revenexxEnums.AddressType? = nil,
        zip: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Address {
        let apiPath: String = "/v1/customers/addresses/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "city": city,
            "company": company,
            "contact_id": contactId,
            "country": country,
            "is_default": isDefault,
            "name": name,
            "organization_id": organizationId,
            "phone": phone,
            "region": region,
            "street": street,
            "street2": street2,
            "type": type,
            "zip": zip
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Address = { response in
            return RevenexxAPIRevenexxModels.Address.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AuthLoginResponse
    ///
    open func customersAuthLogin(
        email: String,
        password: String
    ) async throws -> Revenexx API — revenexxModels.AuthLoginResponse {
        let apiPath: String = "/v1/customers/auth/login"

        let apiParams: [String: Any?] = [
            "email": email,
            "password": password
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AuthLoginResponse = { response in
            return RevenexxAPIRevenexxModels.AuthLoginResponse.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - sessionId: String
    ///   - userId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersAuthLogout(
        sessionId: String,
        userId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/auth/logout"

        let apiParams: [String: Any?] = [
            "session_id": sessionId,
            "user_id": userId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - userId: String
    ///   - sessionId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AuthMeResponse
    ///
    open func customersAuthMe(
        userId: String,
        sessionId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.AuthMeResponse {
        let apiPath: String = "/v1/customers/auth/me"

        let apiParams: [String: Any?] = [
            "session_id": sessionId,
            "user_id": userId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AuthMeResponse = { response in
            return RevenexxAPIRevenexxModels.AuthMeResponse.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - email: String
    ///   - url: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersAuthRecovery(
        email: String,
        url: String
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/auth/recovery"

        let apiParams: [String: Any?] = [
            "email": email,
            "url": url
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - password: String
    ///   - secret: String
    ///   - userId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersAuthRecoveryConfirm(
        password: String,
        secret: String,
        userId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/auth/recovery"

        let apiParams: [String: Any?] = [
            "password": password,
            "secret": secret,
            "user_id": userId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    ///   - firstName: String (optional)
    ///   - lastName: String (optional)
    ///   - locale: String (optional)
    ///   - organizationId: String (optional)
    ///   - organizationName: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.AuthRegisterResponse
    ///
    open func customersAuthRegister(
        email: String,
        password: String,
        firstName: String? = nil,
        lastName: String? = nil,
        locale: String? = nil,
        organizationId: String? = nil,
        organizationName: String? = nil
    ) async throws -> Revenexx API — revenexxModels.AuthRegisterResponse {
        let apiPath: String = "/v1/customers/auth/register"

        let apiParams: [String: Any?] = [
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "locale": locale,
            "organization_id": organizationId,
            "organization_name": organizationName,
            "password": password
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.AuthRegisterResponse = { response in
            return RevenexxAPIRevenexxModels.AuthRegisterResponse.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersContactsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/contacts"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - email: String
    ///   - firstName: String (optional)
    ///   - isPrimary: Bool (optional)
    ///   - lastName: String (optional)
    ///   - locale: String (optional)
    ///   - organizationId: String (optional)
    ///   - phone: String (optional)
    ///   - role: Revenexx API — revenexxEnums.ContactRole (optional)
    ///   - status: Revenexx API — revenexxEnums.ContactStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Contact
    ///
    open func customersContactsCreate(
        email: String,
        firstName: String? = nil,
        isPrimary: Bool? = nil,
        lastName: String? = nil,
        locale: String? = nil,
        organizationId: String? = nil,
        phone: String? = nil,
        role: Revenexx API — revenexxEnums.ContactRole? = nil,
        status: Revenexx API — revenexxEnums.ContactStatus? = nil
    ) async throws -> Revenexx API — revenexxModels.Contact {
        let apiPath: String = "/v1/customers/contacts"

        let apiParams: [String: Any?] = [
            "email": email,
            "first_name": firstName,
            "is_primary": isPrimary,
            "last_name": lastName,
            "locale": locale,
            "organization_id": organizationId,
            "phone": phone,
            "role": role,
            "status": status
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Contact = { response in
            return RevenexxAPIRevenexxModels.Contact.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersContactsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/contacts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Contact
    ///
    open func customersContactsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Contact {
        let apiPath: String = "/v1/customers/contacts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Contact = { response in
            return RevenexxAPIRevenexxModels.Contact.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    ///   - email: String (optional)
    ///   - firstName: String (optional)
    ///   - isPrimary: Bool (optional)
    ///   - lastName: String (optional)
    ///   - locale: String (optional)
    ///   - organizationId: String (optional)
    ///   - phone: String (optional)
    ///   - role: Revenexx API — revenexxEnums.ContactRole (optional)
    ///   - status: Revenexx API — revenexxEnums.ContactStatus (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Contact
    ///
    open func customersContactsUpdate(
        id: String,
        email: String? = nil,
        firstName: String? = nil,
        isPrimary: Bool? = nil,
        lastName: String? = nil,
        locale: String? = nil,
        organizationId: String? = nil,
        phone: String? = nil,
        role: Revenexx API — revenexxEnums.ContactRole? = nil,
        status: Revenexx API — revenexxEnums.ContactStatus? = nil
    ) async throws -> Revenexx API — revenexxModels.Contact {
        let apiPath: String = "/v1/customers/contacts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "email": email,
            "first_name": firstName,
            "is_primary": isPrimary,
            "last_name": lastName,
            "locale": locale,
            "organization_id": organizationId,
            "phone": phone,
            "role": role,
            "status": status
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Contact = { response in
            return RevenexxAPIRevenexxModels.Contact.from(map: response as! [String: Any])
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
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersOrganizationsList(
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/organizations"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - name: String
    ///   - settings: Any (optional)
    ///   - status: Revenexx API — revenexxEnums.OrganizationStatus (optional)
    ///   - vatId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Organization
    ///
    open func customersOrganizationsCreate(
        name: String,
        settings: Any? = nil,
        status: Revenexx API — revenexxEnums.OrganizationStatus? = nil,
        vatId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Organization {
        let apiPath: String = "/v1/customers/organizations"

        let apiParams: [String: Any?] = [
            "name": name,
            "settings": settings,
            "status": status,
            "vat_id": vatId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Organization = { response in
            return RevenexxAPIRevenexxModels.Organization.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func customersOrganizationsDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/customers/organizations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Organization
    ///
    open func customersOrganizationsGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.Organization {
        let apiPath: String = "/v1/customers/organizations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.Organization = { response in
            return RevenexxAPIRevenexxModels.Organization.from(map: response as! [String: Any])
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
    /// - Parameters:
    ///   - id: String
    ///   - name: String (optional)
    ///   - settings: Any (optional)
    ///   - status: Revenexx API — revenexxEnums.OrganizationStatus (optional)
    ///   - vatId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Organization
    ///
    open func customersOrganizationsUpdate(
        id: String,
        name: String? = nil,
        settings: Any? = nil,
        status: Revenexx API — revenexxEnums.OrganizationStatus? = nil,
        vatId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Organization {
        let apiPath: String = "/v1/customers/organizations/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "name": name,
            "settings": settings,
            "status": status,
            "vat_id": vatId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Organization = { response in
            return RevenexxAPIRevenexxModels.Organization.from(map: response as! [String: Any])
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