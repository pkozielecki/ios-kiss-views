//
//  ErrorViewConfiguration.swift
//  KISS Views
//

import UIKit

/// A structure describing configuration for universal application error screen.
struct ErrorViewConfiguration: Hashable {
    let title: String
    let description: String
    let icon: UIImage
    let primaryButtonLabel: String?
    let secondaryButtonLabel: String?
}

extension ErrorViewConfiguration {

    /// A No-Network app error screen configuration.
    static var noNetwork: ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "No network!",
            description: "I'm unable to connect to the Internet.\nCheck your connection and try again later.",
            icon: UIImage(systemName: "network", withConfiguration: .leadIcon)!,
            primaryButtonLabel: "OK",
            secondaryButtonLabel: nil
        )
    }
}
