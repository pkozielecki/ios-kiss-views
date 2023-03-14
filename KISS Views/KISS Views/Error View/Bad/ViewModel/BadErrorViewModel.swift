//
//  BadErrorViewModel.swift
//  KISS Views
//

import Foundation
import Combine
import UIKit
import OSLog

/// A view model for a badly written error view.
final class BadErrorViewModel: ObservableObject, Navigator {

    /// A flag indicating if any actions are performed in the background.
    @Published var isLoading: Bool = false

    /// A network error.
    @Published var error: NetworkError?

    /// An app availability status.
    @Published var appUpdateAvailabilityStatus: AppUpdateAvailabilityStatus?

    /// - SeeAlso: Navigator.router
    let router: any NavigationRouter

    /// - SeeAlso: Navigator.presentationMode
    let presentationMode: PresentationMode

    private let networkConnectionChecker: NetworkConnectionChecker
    private let backendStatusChecker: BackendStatusChecker
    private let urlOpener: URLOpener

    /// A default BadErrorViewModel initializer.
    ///
    /// - Parameters:
    ///   - error: a network error.
    ///   - appUpdateAvailabilityStatus: an app update availability status.
    ///   - router: a navigation router.
    ///   - presentationMode: a screen presentation mode.
    ///   - networkConnectionChecker: a network connection checker.
    ///   - backendStatusChecker: a backend status checker.
    ///   - urlOpener: an app URL opener.
    init(
        error: NetworkError?,
        appUpdateAvailabilityStatus: AppUpdateAvailabilityStatus?,
        router: any NavigationRouter,
        presentationMode: PresentationMode,
        networkConnectionChecker: NetworkConnectionChecker,
        backendStatusChecker: BackendStatusChecker,
        urlOpener: URLOpener = UIApplication.shared
    ) {
        self.router = router
        self.presentationMode = presentationMode
        self.networkConnectionChecker = networkConnectionChecker
        self.backendStatusChecker = backendStatusChecker
        self.urlOpener = urlOpener
        if let error = error {
            self.error = error
            self.appUpdateAvailabilityStatus = nil
        } else if let appUpdateAvailabilityStatus = appUpdateAvailabilityStatus {
            self.appUpdateAvailabilityStatus = appUpdateAvailabilityStatus
            self.error = nil
        } else {
            logInvalidInitialisationError()
        }
    }

    @MainActor func checkConnection() async {
        isLoading = true
        let result = await networkConnectionChecker.checkNetworkConnectivity()
        isLoading = false
        if result {
            await popOrDismiss()
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
            await popOrDismiss()
        }
    }

    @MainActor func goToStore() async {
        let url = AppUrl.appStore.url
        if urlOpener.canOpenURL(url) {
            urlOpener.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open this link. Are you running the app on simulator?")
        }
    }
}

private extension BadErrorViewModel {

    func logInvalidInitialisationError() {
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "ErrorView")
        os_log("BadErrorViewModel:init()", log: log, type: .error)
    }
}
