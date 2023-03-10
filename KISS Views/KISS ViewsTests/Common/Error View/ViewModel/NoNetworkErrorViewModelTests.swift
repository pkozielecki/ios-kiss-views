//
//  NoNetworkErrorViewModelTests.swift
//  KISS Views
//

import Foundation
import XCTest

@testable import KISS_Views

final class NoNetworkErrorViewModelTest: XCTestCase {
    var fixturePresentationMode: PresentationMode!
    var fakeNavigationRouter: FakeNavigationRouter!
    var fakeNetworkConnectionChecker: FakeNetworkConnectionChecker!
    var sut: NoNetworkErrorViewModel!

    override func setUp() {
        fixturePresentationMode = .popup
        fakeNavigationRouter = FakeNavigationRouter()
        fakeNetworkConnectionChecker = FakeNetworkConnectionChecker()
        sut = NoNetworkErrorViewModel(
            router: fakeNavigationRouter,
            presentationMode: fixturePresentationMode,
            networkConnectionChecker: fakeNetworkConnectionChecker
        )
    }

    func test_properViewConfigurationShouldBeProduced_andUserActionHandled() async {
        //  when:
        let configuration = sut.viewConfiguration

        //  then:
        XCTAssertEqual(configuration, .noNetwork, "Should produce proper configuration")

        //  given:
        await fakeNetworkConnectionChecker.setCheckResult(value: false)

        //  when:
        await sut.onPrimaryButtonTap()

        //  then:
        let didCheck = await fakeNetworkConnectionChecker.didCheckConnectivity
        XCTAssertEqual(didCheck, true, "Should check the connectivity")

        //  given:
        await fakeNetworkConnectionChecker.setCheckResult(value: true)

        //  when:
        await sut.onPrimaryButtonTap()

        //  then:
        XCTAssertEqual(fakeNavigationRouter.didDismissLastPopup, true, "Should dismiss the view from nav stack if connectivity is restored")
    }
}
