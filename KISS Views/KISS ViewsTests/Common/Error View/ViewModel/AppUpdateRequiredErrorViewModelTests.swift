//
//  AppUpdateRequiredErrorViewModelTests.swift
//  KISS Views
//

import Foundation
import XCTest

@testable import KISS_Views

final class AppUpdateRequiredErrorViewModelTest: XCTestCase {
    var fixturePresentationMode: PresentationMode!
    var fakeNavigationRouter: FakeNavigationRouter!
    var fakeAppUpdateAvailabilityChecker: FakeAppUpdateAvailabilityChecker!
    var fakeURLOpener: FakeURLOpener!
    var sut: AppUpdateRequiredErrorViewModel!

    override func setUp() {
        fixturePresentationMode = .inline
        fakeNavigationRouter = FakeNavigationRouter()
        fakeAppUpdateAvailabilityChecker = FakeAppUpdateAvailabilityChecker()
        fakeURLOpener = FakeURLOpener()
    }

    func test_whenNoUpdateIsAvailable_properViewConfigurationShouldBeProduced_andUserActionsHandled() async {
        //  given:
        fakeAppUpdateAvailabilityChecker.simulateAppUpdateAvailabilityStatus = .notNeeded
        sut = AppUpdateRequiredErrorViewModel(
            router: fakeNavigationRouter,
            presentationMode: fixturePresentationMode,
            appUpdateAvailabilityChecker: fakeAppUpdateAvailabilityChecker
        )

        //  when:
        let configuration = sut.viewConfiguration

        //  then:
        XCTAssertEqual(configuration, .appUpdateNotAvailableConfiguration, "Should produce proper configuration")

        //  when:
        await sut.onPrimaryButtonTap()

        //  then:
        XCTAssertEqual(fakeNavigationRouter.didPopLastScreen, true, "Should pop the screen from nav stack")
    }

    func test_whenAnUpdateIsAvailable_properViewConfigurationShouldBeProduced_andUserActionsHandled() async {
        //  given:
        let fixtureAppVersion = "1.1.0"
        fakeAppUpdateAvailabilityChecker.simulateAppUpdateAvailabilityStatus = .available(availableUpdate: fixtureAppVersion)
        sut = AppUpdateRequiredErrorViewModel(
            router: fakeNavigationRouter,
            presentationMode: fixturePresentationMode,
            appUpdateAvailabilityChecker: fakeAppUpdateAvailabilityChecker,
            urlOpener: fakeURLOpener
        )

        //  when:
        let configuration = sut.viewConfiguration

        //  then:
        let expectedViewConfiguration = ErrorViewConfiguration.makeAppUpdateAvailableConfiguration(version: fixtureAppVersion)
        XCTAssertEqual(configuration, expectedViewConfiguration, "Should produce proper configuration")

        //  when:
        await sut.onPrimaryButtonTap()

        //  then:
        XCTAssertEqual(fakeURLOpener.lastHandledURL, AppUrl.appStore.url, "Should open proper URL")

        //  when:
        await sut.onSecondaryButtonTap()

        //  then:
        XCTAssertEqual(fakeNavigationRouter.didPopLastScreen, true, "Should pop the screen from nav stack")
    }

    func test_whenAnUpdateIsRequired_properViewConfigurationShouldBeProduced_andUserActionsHandled() async {
        //  given:
        let fixtureMinimumSupportedVersion = "1.1.0"
        let fixtureLatestVersion = "1.2.0"
        fakeAppUpdateAvailabilityChecker.simulateAppUpdateAvailabilityStatus = .required(
            minimumSupportedVersion: fixtureMinimumSupportedVersion,
            currentVersion: fixtureLatestVersion
        )
        sut = AppUpdateRequiredErrorViewModel(
            router: fakeNavigationRouter,
            presentationMode: fixturePresentationMode,
            appUpdateAvailabilityChecker: fakeAppUpdateAvailabilityChecker,
            urlOpener: fakeURLOpener
        )

        //  when:
        let configuration = sut.viewConfiguration

        //  then:
        let expectedViewConfiguration = ErrorViewConfiguration.makeAppUpdateRequiredConfiguration(
            minimalVersion: fixtureMinimumSupportedVersion,
            currentVersion: fixtureLatestVersion
        )
        XCTAssertEqual(configuration, expectedViewConfiguration, "Should produce proper configuration")

        //  when:
        await sut.onPrimaryButtonTap()

        //  then:
        XCTAssertEqual(fakeURLOpener.lastHandledURL, AppUrl.appStore.url, "Should open proper URL")
    }
}
