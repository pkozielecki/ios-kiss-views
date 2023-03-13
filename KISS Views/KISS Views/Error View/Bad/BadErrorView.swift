//
//  BadErrorView.swift
//  KISS Views
//

import SwiftUI

struct BadErrorView: View {
    @StateObject var viewModel: BadErrorViewModel

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoaderView()
            }

            VStack(alignment: .center, spacing: 20) {

                Spacer()

                //  Lead icon:
                Image(uiImage: LeadIcon.network.image)
                    .leadIcon()

                //  Title text:
                Text("No network!")
                    .errorViewTitle()

                //  Description text:
                Text("I'm unable to connect to the Internet.\nUse the button below to check the connection.")
                    .errorViewDescription()

                Spacer()

                /// A check connection button:
                PrimaryButton(label: "Check connection") {
                    await viewModel.checkConnection()
                }
            }
            .padding(EdgeInsets(top: 50, leading: 20, bottom: 30, trailing: 20))
            .navigationBarHidden(true)
            .blur(radius: viewModel.isLoading ? 10 : 0)
            .animation(.easeIn(duration: 0.2), value: viewModel.isLoading)
        }
    }
}

struct BadErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BadErrorViewModel(
            router: PreviewNavigationRouter(),
            presentationMode: .inline,
            networkConnectionChecker: PreviewNetworkConnectionChecker()
        )
        return BadErrorView(viewModel: viewModel)
    }
}
