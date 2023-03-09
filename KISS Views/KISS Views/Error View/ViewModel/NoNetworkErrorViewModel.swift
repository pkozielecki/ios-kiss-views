//
//  NoNetworkErrorViewModel.swift
//  KISS Views
//

import Foundation
import UIKit
import Combine

/// A view model for No Network app error screen.
final class NoNetworkErrorViewModel: ErrorViewModel {

    /// - SeeAlso: ErrorViewModel.viewConfiguration
    @Published var viewConfiguration: ErrorViewConfiguration
    var viewConfigurationPublished: Published<ErrorViewConfiguration> { _viewConfiguration }
    var viewConfigurationPublisher: Published<ErrorViewConfiguration>.Publisher { $viewConfiguration }

    /// - SeeAlso: ErrorViewModel.router
    let router: any NavigationRouter

    /// - SeeAlso: ErrorViewModel.presentationMode
    let presentationMode: PresentationMode

    private let networkConnectionChecker: NetworkConnectionChecker

    /// A default NoNetworkErrorViewModel initializer.
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
        viewConfiguration = .noNetwork
    }

    /// - SeeAlso: ErrorViewModel.onPrimaryButtonTap()
    @MainActor func onPrimaryButtonTap() async {
        viewConfiguration = viewConfiguration.showingPreloader(true)
        let result = await networkConnectionChecker.checkNetworkConnectivity()
        viewConfiguration = viewConfiguration.showingPreloader(false)
        if result {
            popOrDismiss()
        }
    }
}
