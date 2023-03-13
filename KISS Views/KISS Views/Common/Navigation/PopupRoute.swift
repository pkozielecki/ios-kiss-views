//
//  PopupRoute.swift
//  KISS Views
//

import Foundation

/// A structure describing app popup route.
struct PopupRoute: Hashable, Codable, Identifiable {
    let id: UUID
    let popup: Popup
}

extension PopupRoute {

    var presentationMode: PresentationMode {
        .popup
    }

    static func makePopup(named popup: PopupRoute.Popup) -> PopupRoute {
        PopupRoute(id: UUID(), popup: popup)
    }
}

extension PopupRoute {

    enum Popup: Hashable, Codable {

        /// A No-Network app popup.
        case noNetwork

        /// A Backend error app popup.
        case backendError(NetworkError)

        /// An app with security issues popup.
        case securityIssues(ApplicationSecurityError)

        /// An app update availability popup.
        case appUpdate

        /// A badly written error view popup, handling multiple app errors at once.
        case badErrorView
    }
}
