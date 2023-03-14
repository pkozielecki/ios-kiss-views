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

                /// A primary action button:
                PrimaryButton(label: primaryButtonLabel) {
                    await handlePrimaryButtonTapped()
                }

                /// A secondary action button:
                if let secondaryButtonLabel {
                    SecondaryButton(label: secondaryButtonLabel) {
                        await handleSecondaryButtonTapped()
                    }
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
        if let error = viewModel.error {
            switch error {
            case .serverMaintenance:
                return LeadIcon.backendMaintenance.image
            case .serverError:
                return LeadIcon.backendIssue.image
            default:
                return LeadIcon.network.image
            }
        } else if let updateStatus = viewModel.appUpdateAvailabilityStatus {
            switch updateStatus {
            case .notNeeded:
                return LeadIcon.updateNotAvailable.image
            case .available:
                return LeadIcon.updateAvailable.image
            case .required:
                return LeadIcon.updateRequired.image
            }
        }
        return UIImage()
    }

    var title: String {
        if let error = viewModel.error {
            switch error {
            case .serverMaintenance:
                return "The server is under maintenance"
            case .serverError:
                return "Unexpected server issue"
            default:
                return "No network!"
            }
        } else if let updateStatus = viewModel.appUpdateAvailabilityStatus {
            switch updateStatus {
            case .notNeeded:
                return "Your app is up to date!"
            case .available:
                return "App update is available"
            case .required:
                return "Your app is no longer supported"
            }
        }
        return ""
    }

    var description: String {
        if let error = viewModel.error {
            switch error {
            case .serverMaintenance:
                return "We're sorry, but our server is being updated.\nPlease try again in a couple of minutes."
            case let .serverError(errorCode, message):
                let formattedMessage = message != nil ? " - \(message!)" : ""
                return "We're sorry, but there seems to be an issue with our server.\n\nError: \(errorCode)\(formattedMessage).\n\nPlease try again in a couple of minutes."
            default:
                return "I'm unable to connect to the Internet.\nUse the button below to check the connection."
            }
        } else if let updateStatus = viewModel.appUpdateAvailabilityStatus {
            switch updateStatus {
            case .notNeeded:
                return "No action required! Just enjoy the app!"
            case let .available(version):
                return "There's a \(version) version of app available.\nCheck it out!"
            case let .required(minimalVersion, currentVersion):
                return "Unfortunately, we no longer support \(currentVersion) version of the app.\nThe minimal supported version is now \(minimalVersion).\n\nPlease go to store and make the update!"
            }
        }
        return ""
    }

    var primaryButtonLabel: String {
        if let error = viewModel.error {
            switch error {
            case .serverMaintenance:
                return "Refresh backend status"
            case .serverError:
                return "Try again"
            default:
                return "Check connection"
            }
        } else if let updateStatus = viewModel.appUpdateAvailabilityStatus {
            switch updateStatus {
            case .notNeeded:
                return "Go back"
            case .available, .required:
                return "Go to store"
            }
        }
        return ""
    }

    var secondaryButtonLabel: String? {
        if let updateStatus = viewModel.appUpdateAvailabilityStatus {
            switch updateStatus {
            case .notNeeded, .required:
                return nil
            case .available:
                return "Not now"
            }
        }
        return ""
    }

    func handlePrimaryButtonTapped() async {
        if let error = viewModel.error {
            switch error {
            case .serverMaintenance, .serverError:
                await viewModel.checkBackendStatus()
            default:
                await viewModel.checkConnection()
            }
        } else if let updateStatus = viewModel.appUpdateAvailabilityStatus {
            switch updateStatus {
            case .notNeeded:
                await viewModel.popOrDismiss()
            case .available, .required:
                await viewModel.goToStore()
            }
        }
    }

    func handleSecondaryButtonTapped() async {
        if case .available = viewModel.appUpdateAvailabilityStatus {
            await viewModel.popOrDismiss()
        }
    }
}

struct BadErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BadErrorViewModel(
            error: .serverMaintenance(message: ""),
            appUpdateAvailabilityStatus: nil,
            router: PreviewNavigationRouter(),
            presentationMode: .inline,
            networkConnectionChecker: PreviewNetworkConnectionChecker(),
            backendStatusChecker: PreviewBackendStatusChecker()
        )
        return BadErrorView(viewModel: viewModel)
    }
}
