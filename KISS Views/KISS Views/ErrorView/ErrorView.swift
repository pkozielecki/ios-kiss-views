//
//  ErrorView.swift
//  KISS Views
//

import SwiftUI

struct ErrorView<ViewModel>: View where ViewModel: ErrorViewModel {
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 20) {

            Spacer()

            //  Lead icon:
            Image(uiImage: viewModel.viewConfiguration.icon)
                .leadIcon()

            //  Title text:
            Text(viewModel.viewConfiguration.title)
                .errorViewTitle()

            //  Description text:
            Text(viewModel.viewConfiguration.description)
                .errorViewDescription()

            Spacer()

            /// Primary CTA button:
            if let primaryLabel = viewModel.viewConfiguration.primaryButtonLabel {
                PrimaryButton(label: primaryLabel) {
                    viewModel.onPrimaryButtonTap()
                }
            }

            /// Secondary CTA button:
            if let secondaryLabel = viewModel.viewConfiguration.secondaryButtonLabel {
                SecondaryButton(label: secondaryLabel) {
                    viewModel.onPrimarySecondaryTap()
                }
            }
        }
        .padding(EdgeInsets(top: 50, leading: 20, bottom: 30, trailing: 20))
        .navigationBarHidden(true)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(viewModel: PreviewErrorViewModel(viewConfiguration: .noNetwork))
    }
}
