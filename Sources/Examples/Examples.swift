import SwiftUI
import Combine
import CombineValidate

class FormViewModel: ObservableObject {
    @Published var email = ""
    @Published var americanPhone = ""
    @Published var text = ""
    
    @Published var iAgree = false
    
    public lazy var emailValidator: ValidationPublisher = {
        $email.validateWithRegex(
            regex: RegularPattern.email,
            error: "Not email",
            tableName: nil
        )
    }()
    
    public lazy var iAgreeValidator: ValidationPublisher = {
        $iAgree.validateToggle(
            error: "You should be agree",
            tableName: nil
        )
    }()
    
    public func reset() {

    }
}

struct Form: View {
    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
        List {
            Section(header: Text("Validate email")) {
                TextField("Should email", text: $viewModel.email)
                    .validate(for: viewModel.emailValidator)
            }
            
            Section(header: Text("Agreement")) {
                Toggle("Accept", isOn: $viewModel.iAgree)
                    .validate(for: viewModel.iAgreeValidator)
            }
        }
        #if os(iOS)
        .listStyle(.insetGrouped)
        #else
        .listStyle(.inset)
        #endif
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
