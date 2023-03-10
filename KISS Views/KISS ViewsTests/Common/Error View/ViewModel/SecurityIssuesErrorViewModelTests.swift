//
//  SecurityIssuesErrorViewModelTests.swift
//  KISS Views
//

import Foundation
import XCTest

@testable import KISS_Views

final class SecurityIssuesErrorViewModelTest: XCTestCase {
    var sut: SecurityIssuesErrorViewModel!

    func test_whenAppIsTemperedWith_properViewConfigurationShouldBeProduced() {
        //  given:
        sut = SecurityIssuesErrorViewModel(error: .appTamperedWith)

        //  when:
        let configuration = sut.viewConfiguration

        //  then:
        XCTAssertEqual(configuration, .appTamperedWith, "Should produce proper configuration")
    }

    func test_whenDeviceIsJailbroken_properViewConfigurationShouldBeProduced() {
        //  given:
        sut = SecurityIssuesErrorViewModel(error: .jailbrokenDevice)

        //  when:
        let configuration = sut.viewConfiguration

        //  then:
        XCTAssertEqual(configuration, .jailbrokenDevice, "Should produce proper configuration")
    }
}
