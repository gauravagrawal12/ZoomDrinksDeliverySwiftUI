import SwiftUI
enum navigationType {
    case backBtnOnly
    case backBtnWithTitle
    case titleOnly
    case showrightBtn
    case all
}
struct NavigationHeaderView: View {

    // MARK: - Properties

    let title: String
    var titleColor : Color = .white
    var leftImage: String = "ic_back"
    var rightImage1: String?
    var rightImage2: String?

    var showBackButton: Bool = true

    var onBack: (() -> Void)?
    var onRight1: (() -> Void)?
    var onRight2: (() -> Void)?
    var navigationType : navigationType = .titleOnly
    private let buttonSize: CGFloat = 44

    var body: some View {

        ZStack {

            //----------------------------------------------------
            // Center Title
            //----------------------------------------------------
           
            Text(title)
                .font(.customfont(.semibold, fontSize: 22))
                .foregroundColor(titleColor)
                .lineLimit(1)
                .truncationMode(.tail)

            //----------------------------------------------------
            // Left & Right Buttons
            //----------------------------------------------------

            HStack {

                // Left Button

                Group {
                    if showBackButton {
                        Button {
                            onBack?()
                        } label: {
                            Image(leftImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .tint(titleColor == .textTitle ? .textTitle : .white)
                        }
                    } else {
                        Color.clear
                    }
                }
                .frame(width: buttonSize, height: buttonSize)

                Spacer()

                HStack(spacing: 8) {

                    if let rightImage1 {
                        Button {
                            onRight1?()
                        } label: {
                            Image(rightImage1)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                        }
                        .frame(width: buttonSize, height: buttonSize)
                    }

                    if let rightImage2 {
                        Button {
                            onRight2?()
                        } label: {
                            Image(rightImage2)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                        }
                        .frame(width: buttonSize, height: buttonSize)
                    }

                    if rightImage1 == nil && rightImage2 == nil {
                        Color.clear
                            .frame(width: buttonSize, height: buttonSize)
                    }

                }
            }
        }
        .frame(height: 56)
        .padding(.horizontal, 16)
    }
}
