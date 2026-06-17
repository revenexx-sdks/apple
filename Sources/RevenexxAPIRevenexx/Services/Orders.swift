import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxAPIRevenexxEnums
import RevenexxAPIRevenexxModels

/// 
open class Orders: Service {

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func ordersList(
    ) async throws -> Any {
        let apiPath: String = "/v1/orders"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func ordersNumberRangesList(
    ) async throws -> Any {
        let apiPath: String = "/v1/orders/number-ranges"

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
    ///   - code: String
    ///   - channelId: String (optional)
    ///   - counter: Int (optional)
    ///   - metadata: Any (optional)
    ///   - padding: Int (optional)
    ///   - positionStep: Int (optional)
    ///   - prefix: String (optional)
    ///   - step: Int (optional)
    ///   - suffix: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.NumberRange
    ///
    open func ordersNumberRangesCreate(
        code: String,
        channelId: String? = nil,
        counter: Int? = nil,
        metadata: Any? = nil,
        padding: Int? = nil,
        positionStep: Int? = nil,
        `prefix`: String? = nil,
        step: Int? = nil,
        suffix: String? = nil
    ) async throws -> Revenexx API — revenexxModels.NumberRange {
        let apiPath: String = "/v1/orders/number-ranges"

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "code": code,
            "counter": counter,
            "metadata": metadata,
            "padding": padding,
            "position_step": positionStep,
            "prefix": `prefix`,
            "step": step,
            "suffix": suffix
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.NumberRange = { response in
            return RevenexxAPIRevenexxModels.NumberRange.from(map: response as! [String: Any])
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
    open func ordersNumberRangesDefaults(
    ) async throws -> Any {
        let apiPath: String = "/v1/orders/number-ranges/defaults"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func ordersNumberRangesDelete(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/orders/number-ranges/{id}"
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
    /// - Returns: Revenexx API — revenexxModels.NumberRange
    ///
    open func ordersNumberRangesGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.NumberRange {
        let apiPath: String = "/v1/orders/number-ranges/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.NumberRange = { response in
            return RevenexxAPIRevenexxModels.NumberRange.from(map: response as! [String: Any])
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
    ///   - channelId: String (optional)
    ///   - code: String (optional)
    ///   - counter: Int (optional)
    ///   - metadata: Any (optional)
    ///   - padding: Int (optional)
    ///   - positionStep: Int (optional)
    ///   - prefix: String (optional)
    ///   - step: Int (optional)
    ///   - suffix: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.NumberRange
    ///
    open func ordersNumberRangesUpdate(
        id: String,
        channelId: String? = nil,
        code: String? = nil,
        counter: Int? = nil,
        metadata: Any? = nil,
        padding: Int? = nil,
        positionStep: Int? = nil,
        `prefix`: String? = nil,
        step: Int? = nil,
        suffix: String? = nil
    ) async throws -> Revenexx API — revenexxModels.NumberRange {
        let apiPath: String = "/v1/orders/number-ranges/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "channel_id": channelId,
            "code": code,
            "counter": counter,
            "metadata": metadata,
            "padding": padding,
            "position_step": positionStep,
            "prefix": `prefix`,
            "step": step,
            "suffix": suffix
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.NumberRange = { response in
            return RevenexxAPIRevenexxModels.NumberRange.from(map: response as! [String: Any])
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
    ///   - items: [Revenexx API — revenexxModels.OrderItemCreateRequest]
    ///   - billingAddress: Any (optional)
    ///   - buyer: Any (optional)
    ///   - cartId: String (optional)
    ///   - channelId: String (optional)
    ///   - contactId: String (optional)
    ///   - currency: String (optional)
    ///   - customerOrderNumber: String (optional)
    ///   - grandTotal: Double (optional)
    ///   - marketId: String (optional)
    ///   - metadata: Any (optional)
    ///   - organizationId: String (optional)
    ///   - payment: Any (optional)
    ///   - shipping: Any (optional)
    ///   - shippingAddress: Any (optional)
    ///   - shippingTotal: Double (optional)
    ///   - userData: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.OrderDetail
    ///
    open func ordersPlace(
        items: [Revenexx API — revenexxModels.OrderItemCreateRequest],
        billingAddress: Any? = nil,
        buyer: Any? = nil,
        cartId: String? = nil,
        channelId: String? = nil,
        contactId: String? = nil,
        currency: String? = nil,
        customerOrderNumber: String? = nil,
        grandTotal: Double? = nil,
        marketId: String? = nil,
        metadata: Any? = nil,
        organizationId: String? = nil,
        payment: Any? = nil,
        shipping: Any? = nil,
        shippingAddress: Any? = nil,
        shippingTotal: Double? = nil,
        userData: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.OrderDetail {
        let apiPath: String = "/v1/orders/place"

        let apiParams: [String: Any?] = [
            "billing_address": billingAddress,
            "buyer": buyer,
            "cart_id": cartId,
            "channel_id": channelId,
            "contact_id": contactId,
            "currency": currency,
            "customer_order_number": customerOrderNumber,
            "grand_total": grandTotal,
            "items": items,
            "market_id": marketId,
            "metadata": metadata,
            "organization_id": organizationId,
            "payment": payment,
            "shipping": shipping,
            "shipping_address": shippingAddress,
            "shipping_total": shippingTotal,
            "user_data": userData
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.OrderDetail = { response in
            return RevenexxAPIRevenexxModels.OrderDetail.from(map: response as! [String: Any])
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
    /// - Returns: Revenexx API — revenexxModels.OrderDetail
    ///
    open func ordersGet(
        id: String
    ) async throws -> Revenexx API — revenexxModels.OrderDetail {
        let apiPath: String = "/v1/orders/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> Revenexx API — revenexxModels.OrderDetail = { response in
            return RevenexxAPIRevenexxModels.OrderDetail.from(map: response as! [String: Any])
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
    ///   - billingAddress: Any (optional)
    ///   - buyer: Any (optional)
    ///   - customerOrderNumber: String (optional)
    ///   - metadata: Any (optional)
    ///   - shippingAddress: Any (optional)
    ///   - userData: Any (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Order
    ///
    open func ordersUpdate(
        id: String,
        billingAddress: Any? = nil,
        buyer: Any? = nil,
        customerOrderNumber: String? = nil,
        metadata: Any? = nil,
        shippingAddress: Any? = nil,
        userData: Any? = nil
    ) async throws -> Revenexx API — revenexxModels.Order {
        let apiPath: String = "/v1/orders/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "billing_address": billingAddress,
            "buyer": buyer,
            "customer_order_number": customerOrderNumber,
            "metadata": metadata,
            "shipping_address": shippingAddress,
            "user_data": userData
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Order = { response in
            return RevenexxAPIRevenexxModels.Order.from(map: response as! [String: Any])
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
    ///   - id: String
    ///   - externalRef: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Order
    ///
    open func ordersAcknowledge(
        id: String,
        externalRef: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Order {
        let apiPath: String = "/v1/orders/{id}/acknowledge"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "external_ref": externalRef
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Order = { response in
            return RevenexxAPIRevenexxModels.Order.from(map: response as! [String: Any])
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
    ///   - cancelledBy: String (optional)
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Order
    ///
    open func ordersCancel(
        id: String,
        cancelledBy: String? = nil,
        reason: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Order {
        let apiPath: String = "/v1/orders/{id}/cancel"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "cancelled_by": cancelledBy,
            "reason": reason
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Order = { response in
            return RevenexxAPIRevenexxModels.Order.from(map: response as! [String: Any])
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
    open func ordersCommentsList(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/orders/{id}/comments"
            .replacingOccurrences(of: "{id}", with: id)

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
    ///   - id: String
    ///   - body: String
    ///   - author: String (optional)
    ///   - visibility: Revenexx API — revenexxEnums.OrderCommentVisibility (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.OrderComment
    ///
    open func ordersCommentsCreate(
        id: String,
        body: String,
        author: String? = nil,
        visibility: Revenexx API — revenexxEnums.OrderCommentVisibility? = nil
    ) async throws -> Revenexx API — revenexxModels.OrderComment {
        let apiPath: String = "/v1/orders/{id}/comments"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "author": author,
            "body": body,
            "visibility": visibility
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.OrderComment = { response in
            return RevenexxAPIRevenexxModels.OrderComment.from(map: response as! [String: Any])
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
    open func ordersEventsList(
        id: String
    ) async throws -> Any {
        let apiPath: String = "/v1/orders/{id}/events"
            .replacingOccurrences(of: "{id}", with: id)

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
    ///   - id: String
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Order
    ///
    open func ordersHold(
        id: String,
        reason: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Order {
        let apiPath: String = "/v1/orders/{id}/hold"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "reason": reason
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Order = { response in
            return RevenexxAPIRevenexxModels.Order.from(map: response as! [String: Any])
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
    ///   - positions: [Revenexx API — revenexxModels.OrderCancelPosition]
    ///   - cancelledBy: String (optional)
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Order
    ///
    open func ordersItemsCancel(
        id: String,
        positions: [Revenexx API — revenexxModels.OrderCancelPosition],
        cancelledBy: String? = nil,
        reason: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Order {
        let apiPath: String = "/v1/orders/{id}/items/cancel"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "cancelled_by": cancelledBy,
            "positions": positions,
            "reason": reason
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Order = { response in
            return RevenexxAPIRevenexxModels.Order.from(map: response as! [String: Any])
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
    ///   - status: Revenexx API — revenexxEnums.OrderPaymentStatus
    ///   - paymentId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Order
    ///
    open func ordersPaymentStatusUpdate(
        id: String,
        status: Revenexx API — revenexxEnums.OrderPaymentStatus,
        paymentId: String? = nil
    ) async throws -> Revenexx API — revenexxModels.Order {
        let apiPath: String = "/v1/orders/{id}/payment-status"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "payment_id": paymentId,
            "status": status
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Order = { response in
            return RevenexxAPIRevenexxModels.Order.from(map: response as! [String: Any])
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
    ///   - positions: [Revenexx API — revenexxModels.OrderReturnPosition]
    ///   - metadata: Any (optional)
    ///   - reason: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.OrderReturn
    ///
    open func ordersReturn(
        id: String,
        positions: [Revenexx API — revenexxModels.OrderReturnPosition],
        metadata: Any? = nil,
        reason: String? = nil
    ) async throws -> Revenexx API — revenexxModels.OrderReturn {
        let apiPath: String = "/v1/orders/{id}/return"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "metadata": metadata,
            "positions": positions,
            "reason": reason
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.OrderReturn = { response in
            return RevenexxAPIRevenexxModels.OrderReturn.from(map: response as! [String: Any])
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
    ///   - rid: String
    ///   - resolution: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.OrderReturn
    ///
    open func ordersReturnsComplete(
        id: String,
        rid: String,
        resolution: String? = nil
    ) async throws -> Revenexx API — revenexxModels.OrderReturn {
        let apiPath: String = "/v1/orders/{id}/returns/{rid}/complete"
            .replacingOccurrences(of: "{id}", with: id)
            .replacingOccurrences(of: "{rid}", with: rid)

        let apiParams: [String: Any?] = [
            "resolution": resolution
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.OrderReturn = { response in
            return RevenexxAPIRevenexxModels.OrderReturn.from(map: response as! [String: Any])
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
    ///   - rid: String
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.OrderReturn
    ///
    open func ordersReturnsReceive(
        id: String,
        rid: String,
        data: Any
    ) async throws -> Revenexx API — revenexxModels.OrderReturn {
        let apiPath: String = "/v1/orders/{id}/returns/{rid}/receive"
            .replacingOccurrences(of: "{id}", with: id)
            .replacingOccurrences(of: "{rid}", with: rid)

        let apiParams: [String: Any?] = [
            "data": data
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.OrderReturn = { response in
            return RevenexxAPIRevenexxModels.OrderReturn.from(map: response as! [String: Any])
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
    ///   - rid: String
    ///   - reason: String (optional)
    ///   - resolution: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.OrderReturn
    ///
    open func ordersReturnsReject(
        id: String,
        rid: String,
        reason: String? = nil,
        resolution: String? = nil
    ) async throws -> Revenexx API — revenexxModels.OrderReturn {
        let apiPath: String = "/v1/orders/{id}/returns/{rid}/reject"
            .replacingOccurrences(of: "{id}", with: id)
            .replacingOccurrences(of: "{rid}", with: rid)

        let apiParams: [String: Any?] = [
            "reason": reason,
            "resolution": resolution
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.OrderReturn = { response in
            return RevenexxAPIRevenexxModels.OrderReturn.from(map: response as! [String: Any])
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
    ///   - carrier: String (optional)
    ///   - metadata: Any (optional)
    ///   - number: String (optional)
    ///   - positions: [Revenexx API — revenexxModels.OrderShipmentPosition] (optional)
    ///   - shippedAt: String (optional)
    ///   - trackingCode: String (optional)
    ///   - trackingUrl: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func ordersShip(
        id: String,
        carrier: String? = nil,
        metadata: Any? = nil,
        number: String? = nil,
        positions: [Revenexx API — revenexxModels.OrderShipmentPosition]? = nil,
        shippedAt: String? = nil,
        trackingCode: String? = nil,
        trackingUrl: String? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/orders/{id}/ship"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "carrier": carrier,
            "metadata": metadata,
            "number": number,
            "positions": positions,
            "shipped_at": shippedAt,
            "tracking_code": trackingCode,
            "tracking_url": trackingUrl
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
    ///   - id: String
    ///   - data: Any
    /// - Throws: Exception if the request fails
    /// - Returns: Revenexx API — revenexxModels.Order
    ///
    open func ordersUnhold(
        id: String,
        data: Any
    ) async throws -> Revenexx API — revenexxModels.Order {
        let apiPath: String = "/v1/orders/{id}/unhold"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "data": data
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> Revenexx API — revenexxModels.Order = { response in
            return RevenexxAPIRevenexxModels.Order.from(map: response as! [String: Any])
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