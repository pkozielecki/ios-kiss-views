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

    /// A default NoNetworkErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - router: a navigation router.
    ///   - presentationMode: a screen presentation mode.
    init(
        router: any NavigationRouter,
        presentationMode: PresentationMode
    ) {
        self.router = router
        self.presentationMode = presentationMode
        viewConfiguration = .noNetwork
    }

    /// - SeeAlso: ErrorViewModel.onPrimaryButtonTap()
    func onPrimaryButtonTap() {
        popOrDismiss()
    }
}
