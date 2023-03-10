//
//  FakeNetworkConnectionChecker.swift
//  KISS Views
//

import Foundation

@testable import KISS_Views

final actor FakeNetworkConnectionChecker: NetworkConnectionChecker {
    private(set) var didCheckConnectivity: Bool?
    private var simulatedCheckResult = false

    func checkNetworkConnectivity() async -> Bool {
        didCheckConnectivity = true
        return simulatedCheckResult
    }
}

extension FakeNetworkConnectionChecker {

    func setCheckResult(value: Bool) {
        simulatedCheckResult = value
    }
}
