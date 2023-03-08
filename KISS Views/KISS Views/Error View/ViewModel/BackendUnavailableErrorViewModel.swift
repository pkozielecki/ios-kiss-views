//
//  BackendUnavailableErrorViewModel.swift
//  KISS Views
//

import Foundation

/// A view model for Backend Unavailable app error screen.
final class BackendUnavailableErrorViewModel: ErrorViewModel {

    /// - SeeAlso: ErrorViewModel.viewConfiguration
    @Published var viewConfiguration: ErrorViewConfiguration
    var viewConfigurationPublished: Published<ErrorViewConfiguration> { _viewConfiguration }
    var viewConfigurationPublisher: Published<ErrorViewConfiguration>.Publisher { $viewConfiguration }

    /// - SeeAlso: ErrorViewModel.router
    let router: any NavigationRouter

    /// - SeeAlso: ErrorViewModel.presentationMode
    let presentationMode: PresentationMode

    /// A default BackendUnavailableErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - router: a navigation router.
    ///   - error: a network error.
    ///   - presentationMode: a screen presentation mode.
    init(
        router: any NavigationRouter,
        error: NetworkError,
        presentationMode: PresentationMode
    ) {
        self.router = router
        self.presentationMode = presentationMode
        switch error {
        case .serverMaintenance:
            viewConfiguration = .backendMaintenance
        case let .serverError(code, message):
            viewConfiguration = .makeBackendDownConfiguration(errorCode: code, message: message)
        default:
            fatalError("Invalid error type: expected serverMaintenance or serverError, got: \(error)")
        }
    }

    /// - SeeAlso: ErrorViewModel.onPrimaryButtonTap()
    func onPrimaryButtonTap() {
        popOrDismiss()
    }
}
