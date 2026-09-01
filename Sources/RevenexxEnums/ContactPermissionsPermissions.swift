import Foundation

public enum ContactPermissionsPermissions: String, CustomStringConvertible {
    case catalogRead = "catalog.read"
    case cartsManage = "carts.manage"
    case ordersCreate = "orders.create"
    case ordersRequest = "orders.request"
    case ordersApprove = "orders.approve"
    case ordersRead = "orders.read"
    case addressesManage = "addresses.manage"
    case contactsRead = "contacts.read"
    case contactsManage = "contacts.manage"
    case organizationManage = "organization.manage"

    public var description: String {
        return rawValue
    }
}
