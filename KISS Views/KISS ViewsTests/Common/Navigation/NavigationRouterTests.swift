//
//  NavigationRouterTests.swift
//  KISS Views
//

import Foundation
import XCTest

@testable import KISS_Views

final class NavigationRouterTest: XCTestCase {
    var sut: DefaultNavigationRouter!

    override func setUp() {
        sut = DefaultNavigationRouter()
    }

    func test_whenInitialisingNavigationStack_itShouldStartEmpty() {
        XCTAssertEqual(sut.navigationStack.count, 0, "Should start w empty navigation stack")
        XCTAssertEqual(sut.presentedPopup, nil, "Should start with no presented popup")
        XCTAssertEqual(sut.navigationRoute, nil, "Should start with no presented route")
    }

    func test_whenPushingAndPoppingViews_shouldUpdateNavigationStack() {
        //  given:
        let fixtureFirstScreen = NavigationRoute.Screen.noNetwork
        let fixtureSecondScreen = NavigationRoute.Screen.backendError(.serverMaintenance(message: nil))

        //  when:
        sut.push(screen: fixtureFirstScreen)
        sut.push(screen: fixtureSecondScreen)

        //  then:
        XCTAssertEqual(sut.navigationRoute?.screen, fixtureSecondScreen, "Should be showing proper screen")
        XCTAssertEqual(sut.navigationStack.count, 2, "Should update navigation stack")

        //  when:
        sut.pop()

        //  then:
        XCTAssertEqual(sut.navigationRoute?.screen, fixtureFirstScreen, "Should pop the screen from navigation stack")
    }

    func test_whenPresentingAndDismissingPopup_shouldNotifySubscribers() {
        //  given:
        let fixtureFirstPopup = PopupRoute.Popup.noNetwork

        //  when:
        sut.present(popup: fixtureFirstPopup)

        //  then:
        XCTAssertEqual(sut.presentedPopup?.popup, fixtureFirstPopup, "Should be showing second popup")

        //  given:
        let fixtureSecondPopup = PopupRoute.Popup.backendError(.serverMaintenance(message: nil))

        //  when:
        sut.present(popup: fixtureSecondPopup)

        //  then:
        XCTAssertEqual(sut.presentedPopup?.popup, fixtureSecondPopup, "Should be showing second popup")

        //  when:
        sut.dismiss()

        //  then:
        XCTAssertEqual(sut.presentedPopup, nil, "Should be dismiss the popup")
    }

    func test_whenSettingNavigationStack_shouldReplaceCurrentlyDisplayedScreens() {
        //  given:
        let fixtureFirstScreen = NavigationRoute.Screen.noNetwork
        let fixtureSecondScreen = NavigationRoute.Screen.backendError(.serverMaintenance(message: nil))
        sut.push(screen: fixtureFirstScreen)

        //  when:
        sut.set(navigationStack: [NavigationRoute.makeScreen(named: fixtureSecondScreen)])

        //  then:
        XCTAssertEqual(sut.navigationRoute?.screen, fixtureSecondScreen, "Should set navigation stack accordingly")
        XCTAssertEqual(sut.navigationStack.count, 1, "Should replace all previous screens in navigation stack")
    }

    func test_whenPoppingAllScreens_shouldClearNavigationStack() {
        //  given:
        let fixtureFirstScreen = NavigationRoute.Screen.appUpdate
        let fixtureSecondScreen = NavigationRoute.Screen.securityIssues(.appTamperedWith)
        sut.push(screen: fixtureFirstScreen)
        sut.push(screen: fixtureSecondScreen)

        //  when:
        sut.popAll()

        //  then:
        XCTAssertEqual(sut.navigationRoute, nil, "Should show no screen")
        XCTAssertEqual(sut.navigationStack.count, 0, "Should pop all screens from nav stack")
    }
}
