//
//  SecondaryButton.swift
//  KISS Views
//

import SwiftUI

struct SecondaryButton: View {
    let label: String
    let onTapCallback: (() async -> Void)?

    var body: some View {
        Button {
            Task {
                await onTapCallback?()
            }
        } label: {
            Text(label)
                .secondaryButtonLabel()
                .frame(maxWidth: .infinity)
        }
        .secondaryButton()
    }
}
