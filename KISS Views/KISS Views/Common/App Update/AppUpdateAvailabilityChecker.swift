//
//  AppUpdateAvailabilityChecker.swift
//  KISS Views
//

import Foundation

/// An enumeration describing app updates availability status.
enum AppUpdateAvailabilityStatus: Equatable {
    case notNeeded
    case available(availableUpdate: String)
    case required(minimumSupportedVersion: String, currentVersion: String)
}

/// An abstraction performing app update availability check.
protocol AppUpdateAvailabilityChecker: AnyObject {

    /// A current app update availability status.
    var appUpdateAvailabilityStatus: AppUpdateAvailabilityStatus { get }
}

/// A default AppUpdateAvailabilityChecker implementation.
final class DefaultAppUpdateAvailabilityChecker: AppUpdateAvailabilityChecker {
    private let appStoreVersionProvider: AppStoreVersionProvider
    private let appVersionProvider: AppVersionProvider

    /// A default initializer for DefaultAppUpdateAvailabilityChecker.
    ///
    /// - Parameters:
    ///   - appStoreVersionProvider: an App Store app version provider.
    ///   - appVersionProvider: a current app version provider.
    init(
        appStoreVersionProvider: AppStoreVersionProvider,
        appVersionProvider: AppVersionProvider = DefaultAppVersionProvider()
    ) {
        self.appStoreVersionProvider = appStoreVersionProvider
        self.appVersionProvider = appVersionProvider
    }

    /// - SeeAlso: AppUpdateAvailabilityChecker.appUpdateAvailabilityStatus
    var appUpdateAvailabilityStatus: AppUpdateAvailabilityStatus {
        guard let currentStoreVersion = appStoreVersionProvider.lastReleasedAppVersion else {
            return .notNeeded
        }
        let currentVersion = appVersionProvider.appVersion
        let minimalRequiredVersion = appStoreVersionProvider.minimalRequiredAppVersion ?? currentVersion
        if currentVersion.compare(minimalRequiredVersion) == .orderedAscending {
            return .required(minimumSupportedVersion: minimalRequiredVersion, currentVersion: currentVersion)
        } else if currentVersion.compare(currentStoreVersion) == .orderedAscending {
            return .available(availableUpdate: currentStoreVersion)
        } else {
            return .notNeeded
        }
    }
}
