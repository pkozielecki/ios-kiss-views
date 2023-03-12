//
//  ErrorView.swift
//  KISS Views
//

import SwiftUI

struct ErrorView<ViewModel>: View where ViewModel: ErrorViewModel {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            if showPreloader {
                LoaderView()
            }

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
                        await viewModel.onPrimaryButtonTap()
                    }
                }

                /// Secondary CTA button:
                if let secondaryLabel = viewModel.viewConfiguration.secondaryButtonLabel {
                    SecondaryButton(label: secondaryLabel) {
                        await viewModel.onSecondaryButtonTap()
                    }
                }
            }
            .padding(EdgeInsets(top: 50, leading: 20, bottom: 30, trailing: 20))
            .navigationBarHidden(true)
            .blur(radius: blurRadius)
            .animation(.easeIn(duration: 0.2), value: showPreloader)
        }
    }
}

private extension ErrorView {

    var blurRadius: Double {
        viewModel.viewConfiguration.showPreloader ? 10 : 0
    }

    var showPreloader: Bool {
        viewModel.viewConfiguration.showPreloader
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let configuration = ErrorViewConfiguration.makeAppUpdateRequiredConfiguration(minimalVersion: "1.1.0", currentVersion: "1.0.0")
        return ErrorView(viewModel: PreviewErrorViewModel(viewConfiguration: configuration.showingPreloader(true)))
    }
}
