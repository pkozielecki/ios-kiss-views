//
//  NetworkConnectionChecker.swift
//  KISS Views
//

import Foundation

/// An abstraction allowing to check the internet connection status.
protocol NetworkConnectionChecker: Actor {

    /// Verifies internet connection status.
    ///
    /// - Returns: a internet connection is active flag.
    func checkNetworkConnectivity() async -> Bool
}

/// A placeholder implementation of NetworkConnectionChecker.
final actor PlaceholderNetworkConnectionChecker: NetworkConnectionChecker {

    /// - SeeAlso: NetworkConnectionChecker.checkNetworkConnectivity()
    func checkNetworkConnectivity() async -> Bool {
        do {
            // Discussion: Emulate checking network connection:
            try await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
        } catch {}

        return Bool.random()
    }
}
