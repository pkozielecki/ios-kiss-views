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
    let showPreloader: Bool
    let primaryButtonLabel: String?
    let secondaryButtonLabel: String?
}

extension ErrorViewConfiguration {

    /// A helper function setting `showPreloader` to a provided value.
    ///
    /// - Parameter value: a show / hide preloader flag.
    /// - Returns: an ErrorView configuration.
    func showingPreloader(_ value: Bool) -> ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: title,
            description: description,
            icon: icon,
            showPreloader: value,
            primaryButtonLabel: primaryButtonLabel,
            secondaryButtonLabel: secondaryButtonLabel
        )
    }
}

extension ErrorViewConfiguration {

    /// A No-Network app error screen configuration.
    static var noNetwork: ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "No network!",
            description: "I'm unable to connect to the Internet.\nUse the button below to check the connection.",
            icon: LeadIcon.network.image,
            showPreloader: false,
            primaryButtonLabel: "Check connection",
            secondaryButtonLabel: nil
        )
    }

    /// A Backend Under Maintenance app error screen configuration.
    static var backendMaintenance: ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "The server is under maintenance",
            description: "We're sorry, but our server is being updated.\nPlease try again in a couple of minutes.",
            icon: LeadIcon.backendMaintenance.image,
            showPreloader: false,
            primaryButtonLabel: "Refresh backend status",
            secondaryButtonLabel: nil
        )
    }

    /// A Jailbroken device error screen configuration.
    static var jailbrokenDevice: ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "Device unsafe to run the app",
            description: "We are unable to guarantee the safety of your data on a current device\nPlease contact our helpdesk for more information.",
            icon: LeadIcon.jailbrokenDevice.image,
            showPreloader: false,
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
            showPreloader: false,
            primaryButtonLabel: nil,
            secondaryButtonLabel: nil
        )
    }

    /// An app screen showing no updates required.
    static var appUpdateNotAvailableConfiguration: ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "Your app is up to date!",
            description: "No action required! Just enjoy the app!",
            icon: LeadIcon.updateNotAvailable.image,
            showPreloader: false,
            primaryButtonLabel: "Go back",
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
            showPreloader: false,
            primaryButtonLabel: "Try again",
            secondaryButtonLabel: nil
        )
    }

    static func makeAppUpdateAvailableConfiguration(version: String) -> ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "App update is available",
            description: "There's a \(version) version of app available.\nCheck it out!",
            icon: LeadIcon.updateAvailable.image,
            showPreloader: false,
            primaryButtonLabel: "Go to store",
            secondaryButtonLabel: "Not now"
        )
    }

    static func makeAppUpdateRequiredConfiguration(minimalVersion: String, currentVersion: String) -> ErrorViewConfiguration {
        ErrorViewConfiguration(
            title: "Your app is no longer supported",
            description: "Unfortunately, we no longer support \(currentVersion) version of the app.\nThe minimal supported version is now \(minimalVersion).\n\nPlease go to store and make the update!",
            icon: LeadIcon.updateRequired.image,
            showPreloader: false,
            primaryButtonLabel: "Go to store",
            secondaryButtonLabel: nil
        )
    }
}
