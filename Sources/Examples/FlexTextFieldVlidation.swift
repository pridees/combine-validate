import Foundation
import Combine
import CombineValidate
import SwiftUI

enum SocialLinkPattern: RegexPattern, RegexProtocol {
    case facebook = #"(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*?(\/)?([\w\-\.]{5,})"#
    case linkedIn = #"^(http(s)?:\/\/)?([\w]+\.)?linkedin\.com\/(pub|in|profile)"#
    case instagram = #"(?:(?:http|https):\/\/)?(?:www.)?(?:instagram.com|instagr.am|instagr.com)\/(\w+)"#
    
    var pattern: RegexPattern {
        self.rawValue
    }
}

class AddSocialProfileViewModel: ObservableObject {
    
    @Published var socialProfileUrl = ""
    @Published var validatedResult: Validated<SocialLinkPattern> = .untouched
    
    public lazy var socialProfileValidator: RichValidationPublisher<SocialLinkPattern> = {
        $socialProfileUrl.validateOneOfRegex(
            regexs: [.facebook, .linkedIn, .instagram],
            error: "Type one of social profile link (insta, facebook, linkedIn)",
            tableName: nil
        )
    }()
    
    private var subscription = Set<AnyCancellable>()
    
    init() {
        socialProfileValidator
            .assign(to: \.validatedResult, on: self)
            .store(in: &subscription)
    }
}

@available(iOS 15, *)
struct SoclialLinkForm: View {
    enum FocusField: Hashable {
        case socialProfile
    }
    
    @StateObject var viewModel = AddSocialProfileViewModel()
    
    @FocusState var focusField: FocusField?
    
    init() {}
    
    var body: some View {
        List {
            Section(
                header: Text("Add your socialProfile")
            ) {
                TextField("Should be profile", text: $viewModel.socialProfileUrl)
                    .validate(for: viewModel.socialProfileValidator)
                    .focused($focusField, equals: .socialProfile)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
        }
        .navigationBarTitle(Text(socialIcon))
        #if os(iOS)
        .listStyle(.insetGrouped)
        #else
        .listStyle(.inset)
        #endif
    }
    
    var socialIcon: String {
        switch viewModel.validatedResult {
        case .success(.linkedIn): return "LinkedIn"
        case .success(.instagram): return "Instagram"
        case .success(.facebook): return "Facebook"
        default: return "Не выбрано"
        }
    }
    
}

@available(iOS 15, *)
struct SoclialLinkForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                SoclialLinkForm()
            }
        }
        .previewDevice("iPhone 13")
    }
}
