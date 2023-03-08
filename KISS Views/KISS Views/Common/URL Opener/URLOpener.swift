//
//  URLOpener.swift
//  KISS Views
//

import UIKit

/// An abstraction allowing to open URLs by the application.
protocol URLOpener: AnyObject {

    /// - SeeAlso: UIApplication.canOpenURL(url:)
    func canOpenURL(_ url: URL) -> Bool

    /// - SeeAlso: UIApplication.open(url:options:completionHandler)
    func open(
        _ url: URL,
        options: [UIApplication.OpenExternalURLOptionsKey: Any],
        completionHandler completion: ((Bool) -> Void)?
    )
}

extension UIApplication: URLOpener {}
