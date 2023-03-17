//
//  LeadIcon.swift
//  KISS Views
//

import SwiftUI

/// An enumeration describing ErrorView leading icons.
enum LeadIcon: String {
    case network
    case backendMaintenance, backendIssue
    case jailbrokenDevice, appTamperedWith
    case updateNotAvailable, updateAvailable, updateRequired
}

extension LeadIcon {

    /// Creates an image representing a given icon type.
    var image: Image {
        switch self {
        case .network:
            return Image(systemName: "network")
        case .backendMaintenance:
            return Image(systemName: "wrench.and.screwdriver")
        case .backendIssue:
            return Image(systemName: "exclamationmark.circle")
        case .jailbrokenDevice:
            return Image(systemName: "lock.circle")
        case .appTamperedWith:
            return Image(systemName: "iphone.gen3.slash")
        case .updateAvailable:
            return Image(systemName: "arrow.down.heart")
        case .updateNotAvailable:
            return Image(systemName: "checkmark.seal.fill")
        case .updateRequired:
            return Image(systemName: "arrow.clockwise.heart")
        }
    }
}
