//
//  ErrorViewModel.swift
//  KISS Views
//

import Foundation
import Combine

/// An abstraction describing a view model to be used in generic, universal app error screens.
protocol ErrorViewModel: AnyObject, ObservableObject {

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
}
