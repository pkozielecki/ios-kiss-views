//
//  LeadIcon.swift
//  KISS Views
//

import UIKit

/// An enumeration describing ErrorView leading icons.
enum LeadIcon: String {
    case network, maintenance, backendIssue, jailbrokenDevice, appTamperedWith
}

extension LeadIcon {

    /// Creates an image representing a given icon type.
    var image: UIImage {
        switch self {
        case .network:
            return UIImage(systemName: "network", withConfiguration: .leadIcon)!
        case .maintenance:
            return UIImage(systemName: "wrench.and.screwdriver", withConfiguration: .leadIcon)!
        case .backendIssue:
            return UIImage(systemName: "exclamationmark.circle", withConfiguration: .leadIcon)!
        case .jailbrokenDevice:
            return UIImage(systemName: "lock.shield", withConfiguration: .leadIcon)!
        case .appTamperedWith:
            return UIImage(systemName: "iphone.gen3.slash", withConfiguration: .leadIcon)!
        }
    }
}

extension UIImage.Configuration {

    static let leadIcon = UIImage.SymbolConfiguration(pointSize: 200, weight: .bold, scale: .large)
}
