import SwiftUI

extension ValidationWrapper {
    public struct Configuration {
        
        public let successColor: Color
        public let dangerColor: Color
        
        public var successImage: Image?
        public var failureImage: Image?
        
        public let hintFont: Font
        
        public let iconTransition: AnyTransition
        public let hintTransition: AnyTransition
        
        public init(
            successColor: Color = .green,
            dangerColor: Color = .red,
            successImage: Image? = Image(systemName: "checkmark.circle"),
            failureImage: Image? = Image(systemName: "xmark.circle"),
            hintFont: Font? = nil,
            iconTransition: AnyTransition? = nil,
            hintTransition: AnyTransition? = nil
        ) {
            self.successColor = successColor
            self.dangerColor = dangerColor
            
            self.successImage = successImage
            self.failureImage = failureImage
            
            self.hintFont = hintFont ?? .callout
            
            self.iconTransition = iconTransition ?? .asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .trailing).combined(with: .opacity)
            ).animation(.easeInOut)
            self.hintTransition = hintTransition ?? .move(edge: .bottom)
        }
    }
}

extension ValidationWrapper.Configuration {
    public static var `default`: Self {
        .init()
    }
    
    public static var hintOnly: Self {
        .init(successImage: nil, failureImage: nil)
    }
    
    public static func customIcons(successImage: Image, failureImage: Image) -> Self {
        .init(successImage: successImage, failureImage: failureImage)
    }
}
