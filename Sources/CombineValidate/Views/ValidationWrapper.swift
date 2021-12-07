import Foundation
import SwiftUI
import Combine

/// Wrapper for any field adds validation input value capabilities
public struct ValidationWrapper<ValidatedView: View, ValidationPayload>: View {
    @State private var validated: Validated<ValidationPayload> = .untouched
    
    private let content: ValidatedView
    private let publisher: ValidationPublisherOf<ValidationPayload>
    private let configuration: Self.Configuration
    
    public init(
        _ content: ValidatedView,
        _ publisher: ValidationPublisher,
        configuration: Self.Configuration
    ) where ValidationPayload == Void {
        self.content = content
        self.publisher = publisher
        self.configuration = configuration
    }
    
    public init(
        _ content: ValidatedView,
        _ publisher: ValidationPublisherOf<ValidationPayload>,
        configuration: Self.Configuration
    ) where ValidationPayload: RegexProtocol {
        self.content = content
        self.publisher = publisher
        self.configuration = configuration
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                content
                    .animation(nil)
                    .padding(validated.isSuccess || validated.isUntouched ? .vertical : .top, 4)
                
                Spacer()
                icon
            }
            
            if case let .failure(reason, tableName) = self.validated, !reason.isEmpty {
                Text(LocalizedStringKey(reason), tableName: tableName)
                    .font(configuration.hintFont)
                    .foregroundColor(configuration.dangerColor)
                    .transition(configuration.hintTransition)
            }
        }
        .onReceive(publisher, perform: handleValidation)
    }
    
    
    @ViewBuilder private var icon: some View {
        switch validated {
        case .success:
            if let successImage = configuration.successImage {
                successImage
                    .foregroundColor(configuration.successColor)
                    .transition(configuration.iconTransition)
            }
            
        case .failure:
            if let failureImage = configuration.failureImage {
                failureImage
                    .foregroundColor(configuration.dangerColor)
                    .transition(configuration.iconTransition)
            }
            
        default: EmptyView()
        }
    }
    
    private func handleValidation(_ validationResult: Validated<ValidationPayload>) {
        withAnimation {
            self.validated = validationResult
        }
    }
}

struct ValidationWrapper_Previews: PreviewProvider {
    struct Person {
        var email: String
    }
    
    class ViewModel: ObservableObject {
        @Published var person = Person(email: "")
        
        public lazy var emailValidator: ValidationPublisher = {
            $person.map(\.email)
                .validateWithRegex(
                    regex: RegularPattern.email,
                    error: "Not email",
                    tableName: nil
                )
        }()
    }
    
    struct Content: View {
        @StateObject private var viewModel = ViewModel()
        
        var body: some View {
            NavigationView {
                List {
                    TextField("Email", text: $viewModel.person.email)
                        .validate(for: viewModel.emailValidator)
                }
            }
        }
    }
    
    static var previews: some View {
        Group {
            Content()
        }
    }
}

