//
//  TextStyles.swift
//  KISS Views
//

import SwiftUI

struct ErrorViewTitleModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct ErrorViewDescriptionModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .lineLimit(4)
            .multilineTextAlignment(.center)
            .font(.body)
    }
}

struct PrimaryButtonLabelModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .font(.title3)
            .fontWeight(.bold)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}

struct SecondaryButtonLabelModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .underline()
            .font(.headline)
            .fontWeight(.medium)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}

extension Text {
    func errorViewTitle() -> some View {
        modifier(ErrorViewTitleModifier())
    }

    func errorViewDescription() -> some View {
        modifier(ErrorViewDescriptionModifier())
    }

    func primaryButtonLabel() -> some View {
        modifier(PrimaryButtonLabelModifier())
    }

    func secondaryButtonLabel() -> some View {
        modifier(SecondaryButtonLabelModifier())
    }
}
