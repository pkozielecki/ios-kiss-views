//
//  FakeAppUpdateAvailabilityChecker.swift
//  KISS Views
//

import Foundation

@testable import KISS_Views

final class FakeAppUpdateAvailabilityChecker: AppUpdateAvailabilityChecker {
    var simulateAppUpdateAvailabilityStatus: AppUpdateAvailabilityStatus?

    var appUpdateAvailabilityStatus: AppUpdateAvailabilityStatus {
        simulateAppUpdateAvailabilityStatus ?? .notNeeded
    }
}
