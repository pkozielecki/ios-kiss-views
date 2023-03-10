//
//  FakeErrorViewModel.swift
//  KISS Views
//

import Foundation
import Combine
@testable import KISS_Views

final class FakeErrorViewModel: ErrorViewModel {
    @Published var viewConfiguration: ErrorViewConfiguration = .noNetwork
    var viewConfigurationPublished: Published<ErrorViewConfiguration> { _viewConfiguration }
    var viewConfigurationPublisher: Published<ErrorViewConfiguration>.Publisher { $viewConfiguration }
    var simulatedPresentationMode: PresentationMode?
    var fakeNavigationRouter = FakeNavigationRouter()

    var presentationMode: PresentationMode {
        simulatedPresentationMode ?? .inline
    }

    var router: any NavigationRouter {
        fakeNavigationRouter
    }

    func onPrimaryButtonTap() async {}

    func onSecondaryButtonTap() async {}
}
