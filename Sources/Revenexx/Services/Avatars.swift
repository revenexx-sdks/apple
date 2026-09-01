import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Generated images: initials, QR codes, country flags, browser and credit-card icons. Every operation answers image bytes, not JSON.
open class Avatars: Service {

    ///
    /// You can use this endpoint to show different browser icons to your users.
    /// The code argument receives the browser code as it appears in your user [GET
    /// /account/sessions](https://app.revenexx.com/docs/references/cloud/client-web/account#getSessions)
    /// endpoint. Use width, height and quality arguments to change the output
    /// settings.
    /// 
    /// When one dimension is specified and the other is 0, the image is scaled
    /// with preserved aspect ratio. If both dimensions are 0, the API provides an
    /// image at source quality. If dimensions are not specified, the default size
    /// of image returned is 100x100px.
    ///
    /// - Parameters:
    ///   - code: RevenexxEnums.Code
    ///   - width: Int (optional)
    ///   - height: Int (optional)
    ///   - quality: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func avatarsGetBrowser(
        code: RevenexxEnums.Code,
        width: Int? = nil,
        height: Int? = nil,
        quality: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/avatars/browsers/{code}"
            .replacingOccurrences(of: "{code}", with: code.rawValue)

        let apiParams: [String: Any?] = [
            "width": width,
            "height": height,
            "quality": quality
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// The credit card endpoint will return you the icon of the credit card
    /// provider you need. Use width, height and quality arguments to change the
    /// output settings.
    /// 
    /// When one dimension is specified and the other is 0, the image is scaled
    /// with preserved aspect ratio. If both dimensions are 0, the API provides an
    /// image at source quality. If dimensions are not specified, the default size
    /// of image returned is 100x100px.
    /// 
    ///
    /// - Parameters:
    ///   - code: RevenexxEnums.AvatarsGetCreditCardCode
    ///   - width: Int (optional)
    ///   - height: Int (optional)
    ///   - quality: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func avatarsGetCreditCard(
        code: RevenexxEnums.AvatarsGetCreditCardCode,
        width: Int? = nil,
        height: Int? = nil,
        quality: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/avatars/credit-cards/{code}"
            .replacingOccurrences(of: "{code}", with: code.rawValue)

        let apiParams: [String: Any?] = [
            "width": width,
            "height": height,
            "quality": quality
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// You can use this endpoint to show different country flags icons to your
    /// users. The code argument receives the 2 letter country code. Use width,
    /// height and quality arguments to change the output settings. Country codes
    /// follow the [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1) standard.
    /// 
    /// When one dimension is specified and the other is 0, the image is scaled
    /// with preserved aspect ratio. If both dimensions are 0, the API provides an
    /// image at source quality. If dimensions are not specified, the default size
    /// of image returned is 100x100px.
    /// 
    ///
    /// - Parameters:
    ///   - code: RevenexxEnums.AvatarsGetFlagCode
    ///   - width: Int (optional)
    ///   - height: Int (optional)
    ///   - quality: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func avatarsGetFlag(
        code: RevenexxEnums.AvatarsGetFlagCode,
        width: Int? = nil,
        height: Int? = nil,
        quality: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/avatars/flags/{code}"
            .replacingOccurrences(of: "{code}", with: code.rawValue)

        let apiParams: [String: Any?] = [
            "width": width,
            "height": height,
            "quality": quality
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Use this endpoint to fetch a remote image URL and crop it to any image size
    /// you want. This endpoint is very useful if you need to crop and display
    /// remote images in your app or in case you want to make sure a 3rd party
    /// image is properly served using a TLS protocol.
    /// 
    /// When one dimension is specified and the other is 0, the image is scaled
    /// with preserved aspect ratio. If both dimensions are 0, the API provides an
    /// image at source quality. If dimensions are not specified, the default size
    /// of image returned is 400x400px.
    /// 
    /// This endpoint does not follow HTTP redirects.
    ///
    /// - Parameters:
    ///   - url: String
    ///   - width: Int (optional)
    ///   - height: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func avatarsGetImage(
        url: String,
        width: Int? = nil,
        height: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/avatars/image"

        let apiParams: [String: Any?] = [
            "url": url,
            "width": width,
            "height": height
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Use this endpoint to show your user initials avatar icon on your website or
    /// app. By default, this route will try to print your logged-in user name or
    /// email initials. You can also overwrite the user name if you pass the 'name'
    /// parameter. If no name is given and no user is logged, an empty avatar will
    /// be returned.
    /// 
    /// You can use the color and background params to change the avatar colors. By
    /// default, a random theme will be selected. The random theme will persist for
    /// the user's initials when reloading the same theme will always return for
    /// the same initials.
    /// 
    /// When one dimension is specified and the other is 0, the image is scaled
    /// with preserved aspect ratio. If both dimensions are 0, the API provides an
    /// image at source quality. If dimensions are not specified, the default size
    /// of image returned is 100x100px.
    /// 
    ///
    /// - Parameters:
    ///   - name: String (optional)
    ///   - width: Int (optional)
    ///   - height: Int (optional)
    ///   - background: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func avatarsGetInitials(
        name: String? = nil,
        width: Int? = nil,
        height: Int? = nil,
        background: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/avatars/initials"

        let apiParams: [String: Any?] = [
            "name": name,
            "width": width,
            "height": height,
            "background": background
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Converts a given plain text to a QR code image. You can use the query
    /// parameters to change the size and style of the resulting image.
    /// 
    ///
    /// - Parameters:
    ///   - text: String
    ///   - size: Int (optional)
    ///   - margin: Int (optional)
    ///   - download: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func avatarsGetQR(
        text: String,
        size: Int? = nil,
        margin: Int? = nil,
        download: Bool? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/avatars/qr"

        let apiParams: [String: Any?] = [
            "text": text,
            "size": size,
            "margin": margin,
            "download": download
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Use this endpoint to capture a screenshot of any website URL. This endpoint
    /// uses a headless browser to render the webpage and capture it as an image.
    /// 
    /// You can configure the browser viewport size, theme, user agent,
    /// geolocation, permissions, and more. Capture either just the viewport or the
    /// full page scroll.
    /// 
    /// When width and height are specified, the image is resized accordingly. If
    /// both dimensions are 0, the API provides an image at original size. If
    /// dimensions are not specified, the default viewport size is 1280x720px.
    ///
    /// - Parameters:
    ///   - url: String
    ///   - headers: Any (optional)
    ///   - viewportWidth: Int (optional)
    ///   - viewportHeight: Int (optional)
    ///   - scale: Double (optional)
    ///   - theme: RevenexxEnums.Theme (optional)
    ///   - userAgent: String (optional)
    ///   - fullpage: Bool (optional)
    ///   - locale: String (optional)
    ///   - timezone: RevenexxEnums.Timezone (optional)
    ///   - latitude: Double (optional)
    ///   - longitude: Double (optional)
    ///   - accuracy: Double (optional)
    ///   - touch: Bool (optional)
    ///   - permissions: [RevenexxEnums.Permissions] (optional)
    ///   - sleep: Int (optional)
    ///   - width: Int (optional)
    ///   - height: Int (optional)
    ///   - quality: Int (optional)
    ///   - output: RevenexxEnums.Output (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func avatarsGetScreenshot(
        url: String,
        headers: Any? = nil,
        viewportWidth: Int? = nil,
        viewportHeight: Int? = nil,
        scale: Double? = nil,
        theme: RevenexxEnums.Theme? = nil,
        userAgent: String? = nil,
        fullpage: Bool? = nil,
        locale: String? = nil,
        timezone: RevenexxEnums.Timezone? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        accuracy: Double? = nil,
        touch: Bool? = nil,
        permissions: [RevenexxEnums.Permissions]? = nil,
        sleep: Int? = nil,
        width: Int? = nil,
        height: Int? = nil,
        quality: Int? = nil,
        output: RevenexxEnums.Output? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/avatars/screenshots"

        let apiParams: [String: Any?] = [
            "url": url,
            "headers": headers,
            "viewportWidth": viewportWidth,
            "viewportHeight": viewportHeight,
            "scale": scale,
            "theme": theme,
            "userAgent": userAgent,
            "fullpage": fullpage,
            "locale": locale,
            "timezone": timezone,
            "latitude": latitude,
            "longitude": longitude,
            "accuracy": accuracy,
            "touch": touch,
            "permissions": permissions,
            "sleep": sleep,
            "width": width,
            "height": height,
            "quality": quality,
            "output": output
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }


}