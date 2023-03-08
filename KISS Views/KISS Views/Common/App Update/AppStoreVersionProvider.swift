//
//  AppStoreVersionProvider.swift
//  KISS Views
//

import Foundation

/// An abstraction providing currently available and minimal required app version.
protocol AppStoreVersionProvider {

    /// A most recent app version available for download.
    var lastReleasedAppVersion: String? { get }

    /// A minimal supported app version.
    var minimalRequiredAppVersion: String? { get }
}

/// A default AppStoreVersionProvider implementation.
struct DefaultAppStoreVersionProvider: AppStoreVersionProvider {

    /// - SeeAlso: AppStoreVersionProvider.lastReleasedAppVersion
    let lastReleasedAppVersion: String?

    /// - SeeAlso: AppStoreVersionProvider.minimalRequiredAppVersion
    let minimalRequiredAppVersion: String?
}
