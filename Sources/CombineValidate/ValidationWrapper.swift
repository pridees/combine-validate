import Foundation
import SwiftUI
import Combine

public struct ValidationWrapper<ValidatedView: View>: View {
    @State private var validated: Validated = .untouched
    
    private var content: ValidatedView
    private var publisher: ValidationPublisher
    private var successImage: Image?
    private var failureImage: Image?
    
    private let iconTransition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .trailing).combined(with: .opacity)
    ).animation(.easeInOut)
    
    private let errorMessageTransition: AnyTransition = .opacity
    
    public init(
        _ content: ValidatedView,
        _ publisher: ValidationPublisher,
        successImage: Image? = nil,
        failureImage: Image? = nil
    ) {
        self.content = content
        self.publisher = publisher
        self.successImage = successImage
        self.failureImage = failureImage
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                content
                    .animation(nil)
                    .padding(.vertical, 4)
                
                Spacer()
                icon
            }
            
            if case let .failure(reason, tableName) = self.validated, !reason.isEmpty {
                Text(LocalizedStringKey(reason), tableName: tableName)
                    .font(.callout)
                    .foregroundColor(.red)
                    .transition(errorMessageTransition)
            }
        }
        .onReceive(publisher, perform: handleValidation)
    }
    
    
    @ViewBuilder private var icon: some View {
        switch validated {
        case .success:
            if let successImage = successImage {
                successImage
                    .foregroundColor(.green)
                    .transition(iconTransition)
            }
            
        case .failure:
            if let failureImage = failureImage {
                failureImage
                    .foregroundColor(.red)
                    .transition(iconTransition)
            }
            
        default: EmptyView()
        }
    }
    
    private func handleValidation(_ validationResult: Validated) {
        withAnimation {
            self.validated = validationResult
        }
    }
}


extension TextField {
    public func validate(
        for publisher: ValidationPublisher,
        successImage: Image? = Image(systemName: "checkmark.circle"),
        failureImage: Image? = Image(systemName: "xmark.circle")
    ) -> some View {
        ValidationWrapper(self, publisher, successImage: successImage, failureImage: failureImage)
    }
}

extension SecureField {
    public func validate(
        for publisher: ValidationPublisher,
        successImage: Image? = Image(systemName: "checkmark.circle"),
        failureImage: Image? = Image(systemName: "xmark.circle")
    ) -> some View {
        ValidationWrapper(self, publisher, successImage: successImage, failureImage: failureImage)
    }
}

extension Toggle {
    public func validate(
        for publisher: ValidationPublisher
    ) -> some View {
        ValidationWrapper(self, publisher, successImage: nil, failureImage: nil)
    }
}

#if DEBUG
class FormViewModel: ObservableObject {
    @Published var email = ""
    @Published var americanPhone = ""
    @Published var text = ""
    
    @Published var iAgree = false
    
    public lazy var emailValidator: ValidationPublisher = {
        $email.validateWithRegex(regex: .email, errorMessage: "Not email", tableName: nil)
    }()
    
    public lazy var textNonEmptyValidator: ValidationPublisher = {
        $text.validateNonEmpty(errorMessage: "", tableName: nil)
    }()
    
    public lazy var americanPhoneValidator: ValidationPublisher = {
        $americanPhone.validateWithRegex(
            regex: .hexColor,
            errorMessage: "Isn't american phone",
            tableName: nil
        )
    }()
    
    public lazy var iAgreeValidator: ValidationPublisher = {
        $iAgree
            .validateToggle(errorMessage: "You should be agree", tableName: nil)
    }()
}

struct Form: View {
    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
        List {
            Section(header: Text("Validate email")) {
                TextField("Should email", text: $viewModel.email)
                    .validate(for: viewModel.emailValidator)
            }
            
            Section(header: Text("Validate phone")) {
                TextField("Phone", text: $viewModel.americanPhone)
                    .validate(for: viewModel.americanPhoneValidator)
            }
            
            Section(header: Text("Validate text")) {
                TextField("Should non empty text", text: $viewModel.text)
                    .validate(for: viewModel.textNonEmptyValidator)
            }
            
            Section(header: Text("Agreement")) {
                Toggle("Accept", isOn: $viewModel.iAgree)
                    .validate(for: viewModel.iAgreeValidator)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct Form_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                Form()
            }
            .navigationTitle("Combine Validate")
        }
        .previewDevice("iPhone 13")
    }
}
#endif
