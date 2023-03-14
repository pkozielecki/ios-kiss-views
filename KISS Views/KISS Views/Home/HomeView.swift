//
//  HomeView.swift
//  KISS Views
//

import SwiftUI

struct HomeView<Router: NavigationRouter>: View {
    @ObservedObject var router: Router

    var body: some View {
        NavigationStack(
            path: .init(
                get: {
                    router.navigationStack
                },
                set: { stack in
                    router.set(navigationStack: stack)
                })
        ) {
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                    Text("KISS Views showcase")
                        .font(.title)
                        .bold()
                    Divider()
                    VStack(spacing: 10) {
                        Text("\"SMART\" APP SCREENS (from nav links):")
                        NavigationLink(value: NavigationRoute.makeScreen(named: .badErrorView(.notFound))) {
                            Text("Network error")
                        }
                        NavigationLink(value: NavigationRoute.makeScreen(named: .badErrorView(.serverMaintenance(message: nil)))) {
                            Text("Backend under maintenance")
                        }
                        NavigationLink(value: NavigationRoute.makeScreen(named: .badErrorView(.serverError(code: 520, message: "Hosting down")))) {
                            Text("Backend down")
                        }
                    }
                    VStack(spacing: 10) {
                        Text("\"SMART\" APP ERROR POPUPS (from router):")
                        Button {
                            router.present(popup: .badErrorView(.notFound))
                        } label: {
                            Text("Network error")
                        }
                        Button {
                            router.present(popup: .badErrorView(.serverMaintenance(message: nil)))
                        } label: {
                            Text("Backend under maintenance")
                        }
                        Button {
                            router.present(popup: .badErrorView(.serverError(code: 520, message: "Hosting down")))
                        } label: {
                            Text("Backend down")
                        }
                    }
                    Divider()
                    VStack(spacing: 10) {
                        Text("\"SIMPLE, STUPID\" APP SCREENS:")
                        NavigationLink(value: NavigationRoute.makeScreen(named: .noNetwork)) {
                            Text("Network error")
                        }
                        NavigationLink(value: NavigationRoute.makeScreen(named: .backendError(.serverMaintenance(message: nil)))) {
                            Text("Backend under maintenance")
                        }
                        NavigationLink(value: NavigationRoute.makeScreen(named: .backendError(NetworkError(code: 511, message: "Database init failed")!))) {
                            Text("Backend down")
                        }
                        NavigationLink(value: NavigationRoute.makeScreen(named: .securityIssues(.jailbrokenDevice))) {
                            Text("Jailbroken device")
                        }
                        NavigationLink(value: NavigationRoute.makeScreen(named: .securityIssues(.appTamperedWith))) {
                            Text("Tampered app")
                        }
                        NavigationLink(value: NavigationRoute.makeScreen(named: .appUpdate)) {
                            Text("App update availability")
                        }
                    }
                    VStack(spacing: 10) {
                        Text("\"SIMPLE, STUPID\" APP POPUPS:")
                        Button {
                            router.present(popup: .noNetwork)
                        } label: {
                            Text("Network error")
                        }
                        Button {
                            router.present(popup: .backendError(.serverMaintenance(message: nil)))
                        } label: {
                            Text("Backend under maintenance")
                        }
                        Button {
                            router.present(popup: .backendError(NetworkError(code: 511, message: "Database init failed")!))
                        } label: {
                            Text("Backend down")
                        }
                        Button {
                            router.present(popup: .securityIssues(.jailbrokenDevice))
                        } label: {
                            Text("Jailbroken device")
                        }
                        Button {
                            router.present(popup: .securityIssues(.appTamperedWith))
                        } label: {
                            Text("Tampered app")
                        }
                        Button {
                            router.present(popup: .appUpdate)
                        } label: {
                            Text("App update availability")
                        }
                    }
                    Spacer()
                }
                .navigationDestination(for: NavigationRoute.self) { route in
                    //  Handling app screens, pushed to the navigation stack:
                    switch route.screen {
                    case .noNetwork:
                        makeNoNetworkErrorView(presentationMode: .inline)
                    case let .backendError(error):
                        makeBackendErrorView(error: error, presentationMode: .inline)
                    case let .securityIssues(error):
                        makeSecurityIssuesErrorView(error: error)
                    case .appUpdate:
                        makeAppUpdateInfoView(presentationMode: .inline)
                    case let .badErrorView(error):
                        makeBadErrorView(presentationMode: .inline, error: error)
                    }
                }
                .sheet(item: $router.presentedPopup) { _ in
                    if let $popup = Binding($router.presentedPopup) {
                        //  Handling app popups, presented as sheets:
                        switch $popup.wrappedValue.popup {
                        case .noNetwork:
                            makeNoNetworkErrorView(presentationMode: .popup)
                        case let .backendError(error):
                            makeBackendErrorView(error: error, presentationMode: .popup)
                        case let .securityIssues(error):
                            makeSecurityIssuesErrorView(error: error)
                        case .appUpdate:
                            makeAppUpdateInfoView(presentationMode: .popup)
                        case let .badErrorView(error):
                            makeBadErrorView(presentationMode: .popup, error: error)
                        }
                    }
                }
            }
        }
    }
}

private extension HomeView {

    func makeNoNetworkErrorView(presentationMode: PresentationMode) -> ErrorView<NoNetworkErrorViewModel> {
        let connectionChecker = PlaceholderNetworkConnectionChecker()
        let viewModel = NoNetworkErrorViewModel(
            router: router,
            presentationMode: presentationMode,
            networkConnectionChecker: connectionChecker
        )
        return ErrorView(viewModel: viewModel)
    }

    func makeBackendErrorView(error: NetworkError, presentationMode: PresentationMode) -> ErrorView<BackendUnavailableErrorViewModel> {
        let viewModel = BackendUnavailableErrorViewModel(
            router: router,
            error: error,
            presentationMode: presentationMode,
            backendStatusChecker: PlaceholderBackendStatusChecker()
        )
        return ErrorView(viewModel: viewModel)
    }

    func makeSecurityIssuesErrorView(error: ApplicationSecurityError) -> ErrorView<SecurityIssuesErrorViewModel> {
        let viewModel = SecurityIssuesErrorViewModel(error: error)
        return ErrorView(viewModel: viewModel)
    }

    func makeAppUpdateInfoView(presentationMode: PresentationMode) -> ErrorView<AppUpdateRequiredErrorViewModel> {
        // Discussion: Choose one of the configurations below:
        let provider = DefaultAppStoreVersionProvider(lastReleasedAppVersion: "1.0.0", minimalRequiredAppVersion: "1.0.0") // The app is up to date.
//        let provider = DefaultAppStoreVersionProvider(lastReleasedAppVersion: "1.2.0", minimalRequiredAppVersion: "1.0.0") // The app is outdated but still supported.
//        let provider = DefaultAppStoreVersionProvider(lastReleasedAppVersion: "1.2.0", minimalRequiredAppVersion: "1.1.0") // The app is outdated and must be updated.
        let checker = DefaultAppUpdateAvailabilityChecker(appStoreVersionProvider: provider)
        let viewModel = AppUpdateRequiredErrorViewModel(
            router: router,
            presentationMode: presentationMode,
            appUpdateAvailabilityChecker: checker
        )
        return ErrorView(viewModel: viewModel)
    }
}

private extension HomeView {

    func makeBadErrorView(presentationMode: PresentationMode, error: NetworkError) -> BadErrorView {
        let viewModel = BadErrorViewModel(
            error: error,
            router: router,
            presentationMode: presentationMode,
            networkConnectionChecker: PlaceholderNetworkConnectionChecker(),
            backendStatusChecker: PlaceholderBackendStatusChecker()
        )
        return BadErrorView(viewModel: viewModel)
    }
}

struct HomeScene_Previews: PreviewProvider {
    static var previews: some View {
        HomeView<PreviewNavigationRouter>(router: PreviewNavigationRouter())
    }
}
