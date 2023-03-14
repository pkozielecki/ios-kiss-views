//
//  NavigationRoute.swift
//  KISS Views
//

import Foundation

/// A structure describing app navigation route.
struct NavigationRoute: Hashable, Codable, Identifiable {
    let id: UUID
    let screen: Screen
}

extension NavigationRoute {

    var presentationMode: PresentationMode {
        .inline
    }

    static func makeScreen(named screen: NavigationRoute.Screen) -> NavigationRoute {
        NavigationRoute(id: UUID(), screen: screen)
    }
}

extension NavigationRoute {

    enum Screen: Hashable, Codable {

        /// A No-Network app screen.
        case noNetwork

        /// A Backend error app screen.
        case backendError(NetworkError)

        /// An app with security issues screen.
        case securityIssues(ApplicationSecurityError)

        /// An app update availability screen.
        case appUpdate

        /// A badly written error view screen, handling multiple app errors at once.
        case badErrorView(NetworkError?, AppUpdateAvailabilityStatus?)
    }
}
