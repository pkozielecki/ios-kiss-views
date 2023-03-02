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
            VStack(spacing: 10) {
                Spacer()
                Text("KISS Views showcase")
                    .font(.title)
                    .bold()
                Spacer()
                Text("APP SCREENS:")
                NavigationLink(value: NavigationRoute.makeScreen(named: NavigationRoute.Screen.noNetwork)) {
                    Text("Network error - from link")
                }
                Button {
                    router.push(screen: .noNetwork)
                } label: {
                    Text("Network error - from router")
                }
                Spacer()
                Text("APP POPUPS:")
                Button {
                    router.present(popup: .noNetwork)
                } label: {
                    Text("Network error")
                }
                Spacer()
            }
            .navigationDestination(for: NavigationRoute.self) { route in
                //  Handling app screens, pushed to the navigation stack:
                switch route.screen {
                case .noNetwork:
                    makeNoNetworkErrorView(presentationMode: .inline)
                }
            }
            .sheet(item: $router.presentedPopup) { _ in
                if let $popup = Binding($router.presentedPopup) {
                    //  Handling app popups, presented as sheets:
                    switch $popup.wrappedValue.popup {
                    case .noNetwork:
                        makeNoNetworkErrorView(presentationMode: .popup)
                    }
                }
            }
        }
    }
}

extension HomeView {

    func makeNoNetworkErrorView(presentationMode: PresentationMode) -> ErrorView<NoNetworkErrorViewModel> {
        let viewModel = NoNetworkErrorViewModel(router: router, presentationMode: presentationMode)
        return ErrorView(viewModel: viewModel)
    }
}

struct HomeScene_Previews: PreviewProvider {
    static var previews: some View {
        HomeView<PreviewNavigationRouter>(router: PreviewNavigationRouter())
    }
}
