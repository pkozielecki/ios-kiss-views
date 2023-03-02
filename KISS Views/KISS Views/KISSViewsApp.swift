//
//  KISSViewsApp.swift
//  KISS Views
//

import SwiftUI

@main
struct KISS_ViewsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView<DefaultNavigationRouter>(router: DefaultNavigationRouter())
        }
    }
}
