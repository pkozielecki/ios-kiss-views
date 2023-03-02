//
//  SecondaryButton.swift
//  KISS Views
//

import SwiftUI

struct SecondaryButton: View {
    let label: String
    let onTapCallback: (() -> Void)?

    var body: some View {
        Button {
            onTapCallback?()
        } label: {
            Text(label)
                .secondaryButtonLabel()
                .frame(maxWidth: .infinity)
        }
        .secondaryButton()
    }
}
