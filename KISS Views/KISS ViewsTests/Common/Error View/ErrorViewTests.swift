//
//  ErrorViewTests.swift
//  KISS Views
//

import Foundation
import XCTest
import UIKit
import SwiftUI
import SnapshotTesting

@testable import KISS_Views

final class ErrorViewTest: XCTestCase {
    var fakeViewModel: FakeErrorViewModel!
    var sut: ErrorView<FakeErrorViewModel>!

    override func setUp() {
        let fakeViewModel = FakeErrorViewModel()
        sut = ErrorView(viewModel: fakeViewModel)
        self.fakeViewModel = fakeViewModel
    }

    // MARK: - Networking messages:

    func test_whenInitialisedWithNoNetworkConfiguration_shouldGenerateProperSnapshot() {
        //  given:
        fakeViewModel.viewConfiguration = .noNetwork

        //  then:
        executeSnapshotTests(forViewController: sut.wrappedInHostingViewController(), named: "ErrorView_NoNetwork")
    }

    func test_whenInitialisedWithBackendUnderMaintainanceConfiguration_shouldGenerateProperSnapshot() {
        //  given:
        fakeViewModel.viewConfiguration = .backendMaintenance

        //  then:
        executeSnapshotTests(forViewController: sut.wrappedInHostingViewController(), named: "ErrorView_BackendUnderMaintenance")
    }

    func test_whenInitialisedWithBackendUnavailableConfiguration_shouldGenerateProperSnapshot() {
        //  given:
        fakeViewModel.viewConfiguration = .makeBackendDownConfiguration(errorCode: 515, message: "Database init failed")

        //  then:
        executeSnapshotTests(forViewController: sut.wrappedInHostingViewController(), named: "ErrorView_BackendDown")
    }

    // MARK: - App updates messages:

    func test_whenInitialisedWithAppUpToDateConfiguration_shouldGenerateProperSnapshot() {
        //  given:
        fakeViewModel.viewConfiguration = .appUpdateNotAvailableConfiguration

        //  then:
        executeSnapshotTests(forViewController: sut.wrappedInHostingViewController(), named: "ErrorView_AppUpToDate")
    }

    func test_whenInitialisedWithAppUpdateAvailableConfiguration_shouldGenerateProperSnapshot() {
        //  given:
        fakeViewModel.viewConfiguration = .makeAppUpdateAvailableConfiguration(version: "1.2.0")

        //  then:
        executeSnapshotTests(forViewController: sut.wrappedInHostingViewController(), named: "ErrorView_AppUpdateAvailable")
    }

    func test_whenInitialisedWithAppUpdateRequiredConfiguration_shouldGenerateProperSnapshot() {
        //  given:
        fakeViewModel.viewConfiguration = .makeAppUpdateRequiredConfiguration(minimalVersion: "1.2.0", currentVersion: "1.1.0")

        //  then:
        executeSnapshotTests(forViewController: sut.wrappedInHostingViewController(), named: "ErrorView_AppUpdateRequired")
    }

    // MARK: - Security messages:

    func test_whenInitialisedWithJailbrokenAppConfiguration_shouldGenerateProperSnapshot() {
        //  given:
        fakeViewModel.viewConfiguration = .jailbrokenDevice

        //  then:
        executeSnapshotTests(forViewController: sut.wrappedInHostingViewController(), named: "ErrorView_JailbrokenApp")
    }

    func test_whenInitialisedWithTamperedAppConfiguration_shouldGenerateProperSnapshot() {
        //  given:
        fakeViewModel.viewConfiguration = .appTamperedWith

        //  then:
        executeSnapshotTests(forViewController: sut.wrappedInHostingViewController(), named: "ErrorView_TamperedApp")
    }
}

extension View {

    func wrappedInHostingViewController() -> UIViewController {
        UIHostingController(rootView: self)
    }
}
