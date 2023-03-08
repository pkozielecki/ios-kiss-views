//
//  AppVersionProvider.swift
//  KISS Views
//

import Foundation

/// An abstraction providing current app version.
protocol AppVersionProvider: AnyObject {

    /// A current app version.
    var appVersion: String { get }
}

/// A default implementation of AppVersionProvider.
final class DefaultAppVersionProvider: AppVersionProvider {
    private let appBundle: Bundle

    /// A default initializer for DefaultAppVersionProvider.
    ///
    /// - Parameter appBundle: an application bundle.
    init(appBundle: Bundle = Bundle.main) {
        self.appBundle = appBundle
    }

    /// - SeeAlso: AppVersionProvider.appVersion
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
}
