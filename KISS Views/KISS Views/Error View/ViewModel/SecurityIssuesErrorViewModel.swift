//
//  SecurityIssuesErrorViewModel.swift
//  KISS Views
//

import Foundation

/// A view model for App Security Issues error screen.
final class SecurityIssuesErrorViewModel: ErrorViewModel {

    /// - SeeAlso: ErrorViewModel.viewConfiguration
    @Published var viewConfiguration: ErrorViewConfiguration
    var viewConfigurationPublished: Published<ErrorViewConfiguration> { _viewConfiguration }
    var viewConfigurationPublisher: Published<ErrorViewConfiguration>.Publisher { $viewConfiguration }

    /// - SeeAlso: ErrorViewModel.router
    let router: any NavigationRouter

    /// - SeeAlso: ErrorViewModel.presentationMode
    let presentationMode: PresentationMode

    /// A default SecurityIssuesErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - router: a navigation router.
    ///   - error: an application security error.
    ///   - presentationMode: a screen presentation mode.
    init(
        router: any NavigationRouter,
        error: ApplicationSecurityError,
        presentationMode: PresentationMode
    ) {
        self.router = router
        self.presentationMode = presentationMode
        switch error {
        case .jailbrokenDevice:
            viewConfiguration = .jailbrokenApp
        case .appTamperedWith:
            viewConfiguration = .appTamperedWith
        }
    }

    /// - SeeAlso: ErrorViewModel.onPrimaryButtonTap()
    func onPrimaryButtonTap() async {
        popOrDismiss()
    }
}
