//
//  AppUrl.swift
//  KISS Views
//

import Foundation

/// An enumeration representing application links.
enum AppUrl {
    /// A link to the App Store.
    case appStore
}

extension AppUrl {

    /// A url to the resource represented by a given link.
    var url: URL {
        switch self {
        case .appStore:
            return URL(string: "itms-apps://itunes.apple.com/app/id1481186644")! // Baby Guard app
        }
    }
}
