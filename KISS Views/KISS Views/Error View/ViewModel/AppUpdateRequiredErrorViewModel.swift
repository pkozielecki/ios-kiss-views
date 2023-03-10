//
//  AppUpdateRequiredErrorViewModel.swift
//  KISS Views
//

import Foundation
import UIKit

/// A view model for App Update status screen.
final class AppUpdateRequiredErrorViewModel: ErrorViewModel {

    /// - SeeAlso: ErrorViewModel.viewConfiguration
    @Published var viewConfiguration: ErrorViewConfiguration
    var viewConfigurationPublished: Published<ErrorViewConfiguration> { _viewConfiguration }
    var viewConfigurationPublisher: Published<ErrorViewConfiguration>.Publisher { $viewConfiguration }

    /// - SeeAlso: ErrorViewModel.router
    let router: any NavigationRouter

    /// - SeeAlso: ErrorViewModel.presentationMode
    let presentationMode: PresentationMode

    private let appUpdateAvailabilityStatus: AppUpdateAvailabilityStatus
    private let urlOpener: URLOpener

    /// A default AppUpdateRequiredErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - router: a navigation router.
    ///   - presentationMode: a screen presentation mode.
    ///   - appstoreVersion: an app version currently available in the store.
    ///   - appUpdateAvailabilityChecker: a current app version provider.
    ///   - urlOpener: an app URL opener.
    init(
        router: any NavigationRouter,
        presentationMode: PresentationMode,
        appUpdateAvailabilityChecker: AppUpdateAvailabilityChecker,
        urlOpener: URLOpener = UIApplication.shared
    ) {
        self.router = router
        self.presentationMode = presentationMode
        self.urlOpener = urlOpener
        appUpdateAvailabilityStatus = appUpdateAvailabilityChecker.appUpdateAvailabilityStatus
        switch appUpdateAvailabilityStatus {
        case .notNeeded:
            viewConfiguration = .appUpdateNotAvailableConfiguration
        case let .available(version):
            viewConfiguration = .makeAppUpdateAvailableConfiguration(version: version)
        case let .required(minimalVersion, currentVersion):
            viewConfiguration = .makeAppUpdateRequiredConfiguration(minimalVersion: minimalVersion, currentVersion: currentVersion)
        }
    }

    /// - SeeAlso: ErrorViewModel.onPrimaryButtonTap()
    func onPrimaryButtonTap() async {
        switch appUpdateAvailabilityStatus {
        case .notNeeded:
            popOrDismiss()
        case .available, .required:
            openAppStoreUrl()
        }
    }

    /// - SeeAlso: ErrorViewModel.onSecondaryButtonTap()
    func onSecondaryButtonTap() async {
        if case .available = appUpdateAvailabilityStatus {
            popOrDismiss()
        }
    }
}

private extension AppUpdateRequiredErrorViewModel {

    func openAppStoreUrl() {
        let url = AppUrl.appStore.url
        if urlOpener.canOpenURL(url) {
            urlOpener.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open this link. Are you running the app on simulator?")
        }
    }
}
