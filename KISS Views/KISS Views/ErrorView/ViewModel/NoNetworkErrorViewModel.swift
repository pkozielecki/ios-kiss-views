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

    private let router: any NavigationRouter
    private let presentationMode: PresentationMode

    /// A default NoNetworkErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - router: a navigation router.
    ///   - presentationMode: a screen presentation mode.
    init(
        router: any NavigationRouter,
        presentationMode: PresentationMode
    ) {
        // TODO: add network error
        self.router = router
        self.presentationMode = presentationMode
        viewConfiguration = .noNetwork
    }

    func onPrimaryButtonTap() {
        switch presentationMode {
        case .inline:
            router.pop()
        case .popup:
            router.dismiss()
        }
    }
}

extension UIImage.Configuration {

    static let leadIcon = UIImage.SymbolConfiguration(pointSize: 200, weight: .bold, scale: .large)
}
