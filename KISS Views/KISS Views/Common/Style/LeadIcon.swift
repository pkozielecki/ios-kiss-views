//
//  LeadIcon.swift
//  KISS Views
//

import UIKit

/// An enumeration describing ErrorView leading icons.
enum LeadIcon: String {
    case network
    case backendMaintenance, backendIssue
    case jailbrokenDevice, appTamperedWith
    case updateNotAvailable, updateAvailable, updateRequired
}

extension LeadIcon {

    /// Creates an image representing a given icon type.
    var image: UIImage {
        switch self {
        case .network:
            return UIImage(systemName: "network", withConfiguration: .leadIcon)!
        case .backendMaintenance:
            return UIImage(systemName: "wrench.and.screwdriver", withConfiguration: .leadIcon)!
        case .backendIssue:
            return UIImage(systemName: "exclamationmark.circle", withConfiguration: .leadIcon)!
        case .jailbrokenDevice:
            return UIImage(systemName: "lock.circle", withConfiguration: .leadIcon)!
        case .appTamperedWith:
            return UIImage(systemName: "iphone.gen3.slash", withConfiguration: .leadIcon)!
        case .updateAvailable:
            return UIImage(systemName: "apple.logo", withConfiguration: .leadIcon)!
        case .updateNotAvailable:
            return UIImage(systemName: "arrow.down.heart", withConfiguration: .leadIcon)!
        case .updateRequired:
            return UIImage(systemName: "arrow.clockwise.heart", withConfiguration: .leadIcon)!
        }
    }
}

extension UIImage.Configuration {

    static let leadIcon = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
}
