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
            icon: LeadIcon.network.image,
            primaryButtonLabel: "OK",
            secondaryButtonLabel: nil
        )
    }

    /// A Backend Under Maintenance app error screen configuration.
    static var backendMaintenance: ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "The server is under maintenance",
            description: "We're sorry, but our server is being updated.\nPlease try again in a couple of minutes.",
            icon: LeadIcon.maintenance.image,
            primaryButtonLabel: "Try again",
            secondaryButtonLabel: nil
        )
    }

    /// A Jailbroken app error screen configuration.
    static var jailbrokenApp: ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "Device unsafe to run the app",
            description: "We are unable to guarantee the safety of your data on a current device\nPlease contact our helpdesk for more information.",
            icon: LeadIcon.jailbrokenDevice.image,
            primaryButtonLabel: nil,
            secondaryButtonLabel: nil
        )
    }

    /// An App Tampered With error screen configuration.
    static var appTamperedWith: ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "The app integrity is compromised",
            description: "We detected that the app has been tampered with.\nAs such, we cannot guarantee safety of your data.\n\nPlease contact our helpdesk for more information.",
            icon: LeadIcon.appTamperedWith.image,
            primaryButtonLabel: nil,
            secondaryButtonLabel: nil
        )
    }
}

extension ErrorViewConfiguration {

    static func makeBackendDownConfiguration(errorCode: Int, message: String?) -> ErrorViewConfiguration {
        let formattedMessage = message != nil ? " - \(message!)" : ""
        return ErrorViewConfiguration(
            title: "Unexpected server issue",
            description: "We're sorry, but there seems to be an issue with our server.\n\nError: \(errorCode)\(formattedMessage).\n\nPlease try again in a couple of minutes.",
            icon: LeadIcon.backendIssue.image,
            primaryButtonLabel: "Try again",
            secondaryButtonLabel: nil
        )
    }
}
