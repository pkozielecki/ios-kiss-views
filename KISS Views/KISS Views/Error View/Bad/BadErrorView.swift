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
                Image(uiImage: icon)
                    .leadIcon()

                //  Title text:
                Text(title)
                    .errorViewTitle()

                //  Description text:
                Text(description)
                    .errorViewDescription()

                Spacer()

                /// A check connection button:
                PrimaryButton(label: buttonLabel) {
                    await handlePrimaryButtonTapped()
                }
            }
            .padding(EdgeInsets(top: 50, leading: 20, bottom: 30, trailing: 20))
            .navigationBarHidden(true)
            .blur(radius: viewModel.isLoading ? 10 : 0)
            .animation(.easeIn(duration: 0.2), value: viewModel.isLoading)
        }
    }
}

private extension BadErrorView {
    var icon: UIImage {
        switch viewModel.error {
        case .serverMaintenance:
            return LeadIcon.backendMaintenance.image
        case .serverError:
            return LeadIcon.backendIssue.image
        default:
            return LeadIcon.network.image
        }
    }

    var title: String {
        switch viewModel.error {
        case .serverMaintenance:
            return "The server is under maintenance"
        case .serverError:
            return "Unexpected server issue"
        default:
            return "No network!"
        }
    }

    var description: String {
        switch viewModel.error {
        case .serverMaintenance:
            return "We're sorry, but our server is being updated.\nPlease try again in a couple of minutes."
        case let .serverError(errorCode, message):
            let formattedMessage = message != nil ? " - \(message!)" : ""
            return "We're sorry, but there seems to be an issue with our server.\n\nError: \(errorCode)\(formattedMessage).\n\nPlease try again in a couple of minutes."
        default:
            return "I'm unable to connect to the Internet.\nUse the button below to check the connection."
        }
    }

    var buttonLabel: String {
        switch viewModel.error {
        case .serverMaintenance:
            return "Refresh backend status"
        case .serverError:
            return "Try again"
        default:
            return "Check connection"
        }
    }

    func handlePrimaryButtonTapped() async {
        switch viewModel.error {
        case .serverMaintenance, .serverError:
            await viewModel.checkBackendStatus()
        default:
            await viewModel.checkConnection()
        }
    }
}

struct BadErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BadErrorViewModel(
            error: .serverMaintenance(message: ""),
            router: PreviewNavigationRouter(),
            presentationMode: .inline,
            networkConnectionChecker: PreviewNetworkConnectionChecker(),
            backendStatusChecker: PreviewBackendStatusChecker()
        )
        return BadErrorView(viewModel: viewModel)
    }
}
