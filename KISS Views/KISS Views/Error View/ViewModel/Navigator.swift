//
//  Navigator.swift
//  KISS Views
//

import Foundation

/// An abstraction describing a component initiating navigation requests.
protocol Navigator {

    /// A navigation router.
    var router: any NavigationRouter { get }

    /// A screen presentation mode.
    var presentationMode: PresentationMode { get }
}

extension Navigator {

    /// Depending on presentation mode: either pops or dismisses last displayed screen / popup.
    func popOrDismiss() {
        switch presentationMode {
        case .inline:
            router.pop()
        case .popup:
            router.dismiss()
        }
    }
}
