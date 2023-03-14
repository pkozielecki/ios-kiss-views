//
//  BackendUnavailableErrorViewModel.swift
//  KISS Views
//

import Foundation

/// A view model for Backend Unavailable app error screen.
final class BackendUnavailableErrorViewModel: ErrorViewModel, Navigator {

    /// - SeeAlso: ErrorViewModel.viewConfiguration
    @Published var viewConfiguration: ErrorViewConfiguration
    var viewConfigurationPublished: Published<ErrorViewConfiguration> { _viewConfiguration }
    var viewConfigurationPublisher: Published<ErrorViewConfiguration>.Publisher { $viewConfiguration }

    /// - SeeAlso: Navigator.router
    let router: any NavigationRouter

    /// - SeeAlso: Navigator.presentationMode
    let presentationMode: PresentationMode

    private let backendStatusChecker: BackendStatusChecker

    /// A default BackendUnavailableErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - router: a navigation router.
    ///   - error: a network error.
    ///   - presentationMode: a screen presentation mode.
    ///   - backendStatusChecker: a backend status checker.
    init(
        router: any NavigationRouter,
        error: NetworkError,
        presentationMode: PresentationMode,
        backendStatusChecker: BackendStatusChecker
    ) {
        self.router = router
        self.presentationMode = presentationMode
        self.backendStatusChecker = backendStatusChecker
        viewConfiguration = BackendUnavailableErrorViewModel.composeViewConfiguration(error: error)
    }

    /// - SeeAlso: ErrorViewModel.onPrimaryButtonTap()
    @MainActor func onPrimaryButtonTap() async {
        viewConfiguration = viewConfiguration.showingPreloader(true)
        let status = await backendStatusChecker.checkBackendStatus()
        viewConfiguration = viewConfiguration.showingPreloader(false)
        switch status {
        case let .issueDetected(error):
            viewConfiguration = BackendUnavailableErrorViewModel.composeViewConfiguration(error: error)
        case .ok:
            await popOrDismiss()
        }
    }
}

extension BackendUnavailableErrorViewModel {

    static func composeViewConfiguration(error: NetworkError) -> ErrorViewConfiguration {
        switch error {
        case .serverMaintenance:
            return .backendMaintenance
        case let .serverError(code, message):
            return .makeBackendDownConfiguration(errorCode: code, message: message)
        default:
            fatalError("Invalid error type: expected serverMaintenance or serverError, got: \(error)")
        }
    }
}
