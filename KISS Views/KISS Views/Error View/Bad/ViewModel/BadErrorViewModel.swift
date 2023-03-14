//
//  BadErrorViewModel.swift
//  KISS Views
//

import Foundation
import Combine

/// A view model for a badly written error view.
final class BadErrorViewModel: ObservableObject, Navigator {

    /// A flag indicating if any actions are performed in the background.
    @Published var isLoading: Bool = false

    /// A network error.
    @Published var error: NetworkError

    /// - SeeAlso: Navigator.router
    let router: any NavigationRouter

    /// - SeeAlso: Navigator.presentationMode
    let presentationMode: PresentationMode

    private let networkConnectionChecker: NetworkConnectionChecker
    private let backendStatusChecker: BackendStatusChecker

    /// A default BadErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - error: a network error.
    ///   - router: a navigation router.
    ///   - presentationMode: a screen presentation mode.
    ///   - networkConnectionChecker: a network connection checker.
    ///   - backendStatusChecker: a backend status checker.
    init(
        error: NetworkError,
        router: any NavigationRouter,
        presentationMode: PresentationMode,
        networkConnectionChecker: NetworkConnectionChecker,
        backendStatusChecker: BackendStatusChecker
    ) {
        self.error = error
        self.router = router
        self.presentationMode = presentationMode
        self.networkConnectionChecker = networkConnectionChecker
        self.backendStatusChecker = backendStatusChecker
    }

    @MainActor func checkConnection() async {
        isLoading = true
        let result = await networkConnectionChecker.checkNetworkConnectivity()
        isLoading = false
        if result {
            popOrDismiss()
        }
    }

    @MainActor func checkBackendStatus() async {
        isLoading = true
        let status = await backendStatusChecker.checkBackendStatus()
        isLoading = false
        switch status {
        case let .issueDetected(error):
            self.error = error
        case .ok:
            popOrDismiss()
        }
    }
}
