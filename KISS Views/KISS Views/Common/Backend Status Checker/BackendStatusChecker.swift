//
//  BackendStatusChecker.swift
//  KISS Views
//

import Foundation

/// An enumeration describing backend status.
enum BackendStatus {
    /// Backend is working normally.
    case ok

    /// A backend issue is detected.
    case issueDetected(error: NetworkError)
}

/// An abstraction allowing to check backend status.
protocol BackendStatusChecker: Actor {

    /// Verifies backend status.
    ///
    /// - Returns: a backend status.
    func checkBackendStatus() async -> BackendStatus
}

/// A placeholder implementation of BackendStatusChecker.
final actor PlaceholderBackendStatusChecker: BackendStatusChecker {

    /// - SeeAlso: BackendStatusChecker.checkBackendStatus()
    func checkBackendStatus() async -> BackendStatus {
        do {
            // Discussion: Emulate checking backend status:
            try await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
        } catch {}

        switch Int.random(in: 0...2) {
        case 0:
            return .issueDetected(error: .serverMaintenance(message: nil))
        case 1:
            return .issueDetected(error: .serverError(code: 550, message: "Server not responding"))
        default:
            return .ok
        }
    }
}
