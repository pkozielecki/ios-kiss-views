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

    /// - SeeAlso: Navigator.router
    let router: any NavigationRouter

    /// - SeeAlso: Navigator.presentationMode
    let presentationMode: PresentationMode

    private let networkConnectionChecker: NetworkConnectionChecker

    /// A default BadErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - router: a navigation router.
    ///   - presentationMode: a screen presentation mode.
    ///   - networkConnectionChecker: a network connection checker.
    init(
        router: any NavigationRouter,
        presentationMode: PresentationMode,
        networkConnectionChecker: NetworkConnectionChecker
    ) {
        self.router = router
        self.presentationMode = presentationMode
        self.networkConnectionChecker = networkConnectionChecker
    }

    @MainActor func checkConnection() async {
        isLoading = true
        let result = await networkConnectionChecker.checkNetworkConnectivity()
        isLoading = false
        if result {
            popOrDismiss()
        }
    }
}
