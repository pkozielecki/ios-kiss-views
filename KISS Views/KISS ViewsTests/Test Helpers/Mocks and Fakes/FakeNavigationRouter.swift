//
//  FakeNavigationRouter.swift
//  KISS Views
//

import Foundation
import Combine

@testable import KISS_Views

final class FakeNavigationRouter: NavigationRouter {
    @Published var navigationRoute: NavigationRoute?
    var navigationPathPublished: Published<NavigationRoute?> { _navigationRoute }
    var navigationPathPublisher: Published<NavigationRoute?>.Publisher { $navigationRoute }
    private(set) var navigationStack: [NavigationRoute] = []

    @Published var presentedPopup: PopupRoute?
    var presentedPopupPublished: Published<PopupRoute?> { _presentedPopup }
    var presentedPopupPublisher: Published<PopupRoute?>.Publisher { $presentedPopup }

    private(set) var didPopLastScreen: Bool?
    private(set) var didDismissLastPopup: Bool?

    func set(navigationStack: [NavigationRoute]) {}

    func present(popup: PopupRoute.Popup) {}
    func dismiss() {
        didDismissLastPopup = true
    }

    func push(screen: NavigationRoute.Screen) {}
    func pop() {
        didPopLastScreen = true
    }

    func popAll() {}
}
