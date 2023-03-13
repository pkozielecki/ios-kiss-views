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

    /// A default SecurityIssuesErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - error: an application security error.
    init(
        error: ApplicationSecurityError
    ) {
        switch error {
        case .jailbrokenDevice:
            viewConfiguration = .jailbrokenDevice
        case .appTamperedWith:
            viewConfiguration = .appTamperedWith
        }
    }
}
