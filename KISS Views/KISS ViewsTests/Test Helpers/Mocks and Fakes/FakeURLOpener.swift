//
//  FakeURLOpener.swift
//  KISS Views
//

import Foundation
import UIKit

@testable import KISS_Views

final class FakeURLOpener: URLOpener {

    private(set) var lastHandledURL: URL?

    func canOpenURL(_ url: URL) -> Bool {
        true
    }

    func open(
        _ url: URL,
        options: [UIApplication.OpenExternalURLOptionsKey: Any],
        completionHandler completion: ((Bool) -> Void)?
    ) {
        lastHandledURL = url
    }
}
