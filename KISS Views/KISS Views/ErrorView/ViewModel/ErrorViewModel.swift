//
//  ErrorViewModel.swift
//  KISS Views
//

import Foundation
import Combine

/// An abstraction describing a view model to be used in generic, universal app error screens.
protocol ErrorViewModel: AnyObject, ObservableObject {

    /// A navigation router.
    var router: any NavigationRouter { get }

    /// A screen presentation mode.
    var presentationMode: PresentationMode { get }

    /// An ErrorView configuration.
    var viewConfiguration: ErrorViewConfiguration { get }
    var viewConfigurationPublished: Published<ErrorViewConfiguration> { get }
    var viewConfigurationPublisher: Published<ErrorViewConfiguration>.Publisher { get }

    /// A primary button tap callback.
    func onPrimaryButtonTap()

    /// A secondary button tap callback.
    func onPrimarySecondaryTap()
}

extension ErrorViewModel {

    func onPrimaryButtonTap() {}

    func onPrimarySecondaryTap() {}

    func popOrDismiss() {
        switch presentationMode {
        case .inline:
            router.pop()
        case .popup:
            router.dismiss()
        }
    }
}
