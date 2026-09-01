import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Localisation reference data: countries, currencies, languages.
open class Locale: Service {

    ///
    /// Get the current user location based on IP. Returns an object with user
    /// country code, country name, continent name, continent code, ip address and
    /// suggested currency. You can use the locale header to get the data in a
    /// supported language.
    /// 
    /// ([IP Geolocation by DB-IP](https://db-ip.com))
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Locale
    ///
    open func localeGet(
    ) async throws -> RevenexxModels.Locale {
        let apiPath: String = "/v1/locale"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Locale = { response in
            return RevenexxModels.Locale.from(map: response as! [String: Any])
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
    /// List of all locale codes in [ISO
    /// 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.LocaleCodeList
    ///
    open func localeListCodes(
    ) async throws -> RevenexxModels.LocaleCodeList {
        let apiPath: String = "/v1/locale/codes"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.LocaleCodeList = { response in
            return RevenexxModels.LocaleCodeList.from(map: response as! [String: Any])
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
    /// List of all continents. You can use the locale header to get the data in a
    /// supported language.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ContinentList
    ///
    open func localeListContinents(
    ) async throws -> RevenexxModels.ContinentList {
        let apiPath: String = "/v1/locale/continents"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ContinentList = { response in
            return RevenexxModels.ContinentList.from(map: response as! [String: Any])
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
    /// List of all countries. You can use the locale header to get the data in a
    /// supported language.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.CountryList
    ///
    open func localeListCountries(
    ) async throws -> RevenexxModels.CountryList {
        let apiPath: String = "/v1/locale/countries"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.CountryList = { response in
            return RevenexxModels.CountryList.from(map: response as! [String: Any])
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
    /// List of all countries that are currently members of the EU. You can use the
    /// locale header to get the data in a supported language.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.CountryList
    ///
    open func localeListCountriesEU(
    ) async throws -> RevenexxModels.CountryList {
        let apiPath: String = "/v1/locale/countries/eu"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.CountryList = { response in
            return RevenexxModels.CountryList.from(map: response as! [String: Any])
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
    /// List of all countries phone codes. You can use the locale header to get the
    /// data in a supported language.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.PhoneList
    ///
    open func localeListCountriesPhones(
    ) async throws -> RevenexxModels.PhoneList {
        let apiPath: String = "/v1/locale/countries/phones"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.PhoneList = { response in
            return RevenexxModels.PhoneList.from(map: response as! [String: Any])
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
    /// List of all currencies, including currency symbol, name, plural, and
    /// decimal digits for all major and minor currencies. You can use the locale
    /// header to get the data in a supported language.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.CurrencyList
    ///
    open func localeListCurrencies(
    ) async throws -> RevenexxModels.CurrencyList {
        let apiPath: String = "/v1/locale/currencies"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.CurrencyList = { response in
            return RevenexxModels.CurrencyList.from(map: response as! [String: Any])
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
    /// List of all languages classified by ISO 639-1 including 2-letter code, name
    /// in English, and name in the respective language.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.LanguageList
    ///
    open func localeListLanguages(
    ) async throws -> RevenexxModels.LanguageList {
        let apiPath: String = "/v1/locale/languages"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.LanguageList = { response in
            return RevenexxModels.LanguageList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}